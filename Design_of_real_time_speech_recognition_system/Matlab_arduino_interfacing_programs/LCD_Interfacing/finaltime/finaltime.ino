// Written by John Boxall from http://tronixstuff.com
// include the library code:
#include <LiquidCrystal.h>
#include <VirtualWire.h>

const int led_pin = 13;
const int transmit_pin = 12;
const int receive_pin = 11;
const int transmit_en_pin = 3;

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(8, 9, 4, 5, 6, 7);
#include "Wire.h"
#define DS3231_I2C_ADDRESS 0x68
// Convert normal decimal numbers to binary coded decimal
byte decToBcd(byte val){
  return( (val/10*16) + (val%10) );
}
// Convert binary coded decimal to normal decimal numbers
byte bcdToDec(byte val){
  return( (val/16*10) + (val%16) );
}
void setup(){
  Wire.begin();
  Serial.begin(9600);
  lcd.begin(16, 2);
  // Print a message to the LCD.
  
  // set the initial time here:
  // DS3231 seconds, minutes, hours, day, date, month, year
  //setDS3231time(00,18,01,4,3,5,17);
  Serial.println("setup");
    

//Initialise the IO and ISR
  vw_set_tx_pin(transmit_pin);
   vw_set_rx_pin(receive_pin);
  vw_set_ptt_pin(transmit_en_pin);
   vw_set_ptt_inverted(true); // Required for DR3100
   Serial.begin(9600);
    vw_setup(2000);	 // Bits per sec

    vw_rx_start();       // Start the receiver PLL running

    pinMode(led_pin, OUTPUT);
  
}
void setDS3231time(byte second, byte minute, byte hour, byte dayOfWeek, byte
dayOfMonth, byte month, byte year){
  // sets time and date data to DS3231
  Wire.beginTransmission(DS3231_I2C_ADDRESS);
  Wire.write(0); // set next input to start at the seconds register
  Wire.write(decToBcd(second)); // set seconds
  Wire.write(decToBcd(minute)); // set minutes
  Wire.write(decToBcd(hour)); // set hours
  Wire.write(decToBcd(dayOfWeek)); // set day of week (1=Sunday, 7=Saturday)
  Wire.write(decToBcd(dayOfMonth)); // set date (1 to 31)
  Wire.write(decToBcd(month)); // set month
  Wire.write(decToBcd(year)); // set year (0 to 99)
  Wire.endTransmission();
}
void readDS3231time(byte *second,
byte *minute,
byte *hour,
byte *dayOfWeek,
byte *dayOfMonth,
byte *month,
byte *year){
  Wire.beginTransmission(DS3231_I2C_ADDRESS);
  Wire.write(0); // set DS3231 register pointer to 00h
  Wire.endTransmission();
  Wire.requestFrom(DS3231_I2C_ADDRESS, 7);
  // request seven bytes of data from DS3231 starting from register 00h
  *second = bcdToDec(Wire.read() & 0x7f);
  *minute = bcdToDec(Wire.read());
  *hour = bcdToDec(Wire.read() & 0x3f);
  *dayOfWeek = bcdToDec(Wire.read());
  *dayOfMonth = bcdToDec(Wire.read());
  *month = bcdToDec(Wire.read());
  *year = bcdToDec(Wire.read());
}
void displayTime(){
  byte second, minute, hour, dayOfWeek, dayOfMonth, month, year;
  // retrieve data from DS3231
  readDS3231time(&second, &minute, &hour, &dayOfWeek, &dayOfMonth, &month,
  &year);
  // send it to the serial monitor
  Serial.print(hour, DEC);
  // convert the byte variable to a decimal number when displayed
  Serial.print(":");
  if (minute<10){
    Serial.print("0");
  }
  Serial.print(minute, DEC);
  Serial.print(":");
  if (second<10){
    Serial.print("0");
  }
  Serial.print(second, DEC);
  Serial.print(" ");
  Serial.print(dayOfMonth, DEC);
  Serial.print("/");
  Serial.print(month, DEC);
  Serial.print("/");
  Serial.print(year, DEC);
  Serial.print(" Day of week: ");
  switch(dayOfWeek){
  case 1:
    Serial.println("Sunday");
    break;
  case 2:
    Serial.println("Monday");
    break;
  case 3:
    Serial.println("Tuesday");
    break;
  case 4:
    Serial.println("Wednesday");
    break;
  case 5:
    Serial.println("Thursday");
    break;
  case 6:
    Serial.println("Friday");
    break;
  case 7:
    Serial.println("Saturday");
    break;
  }
  uint8_t buf[VW_MAX_MESSAGE_LEN];
    uint8_t buflen = VW_MAX_MESSAGE_LEN;

        if (vw_get_message(buf, &buflen)) // Non-blocking
    {
	int i;

        digitalWrite(13, true); // Flash a light to show received good message
	// Message with a good checksum received, dump it.
	Serial.print("Got: ");
	
	for (i = 0; i < buflen; i++)
	{
	   // Serial.print(buf[i]);
        if(buf[i] == '1')
        {

           lcd.clear();
  lcd.display();
   lcd.setCursor(0, 0);
   lcd.print("BLUE LIGHT ON");
        
        
        }
       if(buf[i] == '2')
       {
       lcd.clear();
  lcd.display();
   lcd.setCursor(0, 0);
   lcd.print("BLUE LIGHT OFF");
        
     }
        if(buf[i] == '3')
        {lcd.clear();
  lcd.display();
   lcd.setCursor(0, 0);
   lcd.print("RED LIGHT ON");
        }
       if(buf[i] == '4')
        {lcd.clear();
  lcd.display();
   lcd.setCursor(0, 0);
   lcd.print("RED LIGHT OFF");
          
       }
         if(buf[i] == '5')
        {lcd.clear();
  lcd.display();
   lcd.setCursor(0, 0);
   lcd.print("FAN ON");
        }
        if(buf[i] == '6')
        {lcd.clear();
  lcd.display();
   lcd.setCursor(0, 0);
   lcd.print("FAN OFF");
        }
        if(buf[i] == '7')
        {lcd.clear();
  lcd.display();
   lcd.setCursor(0, 0);
   lcd.print("GOOD MORNING");
        }
        if(buf[i] == '8')
        {lcd.clear();
  lcd.display();
   lcd.setCursor(0, 0);
   lcd.print("GOOD AFTERNOON");
        }
        if(buf[i] == '9')
        {lcd.clear();
  lcd.display();
   lcd.setCursor(0, 0);
   lcd.print("GOOD EVENING");
        }
        if(buf[i] == 'a')
        {lcd.clear();
  lcd.display();
   lcd.setCursor(0, 0);
   lcd.print("GOOD NIGHT");
        }
        if(buf[i] == 'b')
        {lcd.clear();
  lcd.display();
   lcd.setCursor(0, 0);
   lcd.print("TIME");
   lcd.print(" ");
  lcd.print(hour);
    lcd.print(":");
    lcd.print(minute);
    lcd.print(":");
    lcd.print(second);
    lcd.setCursor(0, 1);
    lcd.print("DATE");
    lcd.print(" ");
   lcd.print(dayOfMonth);
    lcd.print("/");
    lcd.print(month);
    lcd.print("/");
    lcd.print(year) ;
        }
        
	    Serial.print(" ");
	}
	Serial.println("");
        digitalWrite(13, false);

}
 
}
void loop(){
  displayTime(); // display the real-time clock data on the Serial Monitor,
  delay(1000); // every second
}

