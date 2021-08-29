
#include <VirtualWire.h>

const int led_pin = 13;
const int transmit_pin = 12;
const int receive_pin = 11;
const int transmit_en_pin = 3;
int led = 6;
int led1=7;
int led2 = 9;
int led3=8;

void setup()
{ pinMode(led, OUTPUT);
pinMode(led1, OUTPUT);
pinMode(led2, OUTPUT);
pinMode(led3, OUTPUT);
  
   pinMode(2,OUTPUT);
   pinMode(4,OUTPUT);
   
    delay(1000);
    Serial.begin(9600);	// Debugging only
    Serial.println("setup");
    

    // Initialise the IO and ISR
    vw_set_tx_pin(transmit_pin);
    vw_set_rx_pin(receive_pin);
   vw_set_ptt_pin(transmit_en_pin);
    vw_set_ptt_inverted(true); 
    Serial.begin(9600);
    vw_setup(2000);	 

    vw_rx_start();       

    pinMode(led_pin, OUTPUT);
}

void loop()
{
 
  
    uint8_t buf[VW_MAX_MESSAGE_LEN];
    uint8_t buflen = VW_MAX_MESSAGE_LEN;

        if (vw_get_message(buf, &buflen)) 
    {
	int i;

        digitalWrite(13, true); 
	
	Serial.print("Got: ");
	
	for (i = 0; i < buflen; i++)
	{
	  
        if(buf[i] == '1')
        {
           digitalWrite(led, HIGH);
          }
       if(buf[i] == '2')
       {
       digitalWrite(led, LOW);
         }
        if(buf[i] == '3')
        {
          digitalWrite(led1, HIGH);
        }
       if(buf[i] == '4')
        {
        digitalWrite(2, HIGH);
        digitalWrite(4, LOW);
           }
         if(buf[i] == '5')
        {
          digitalWrite(2, LOW);
        digitalWrite(4, HIGH);
        }
	    Serial.print(" ");
	}
	Serial.println("");
        digitalWrite(13, false);

}
    }

