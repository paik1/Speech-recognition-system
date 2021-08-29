#include <VirtualWire.h>
int incomingByte = 0; 

const int led_pin = 11;
const int transmit_pin = 12;
const int receive_pin = 2;
const int transmit_en_pin = 3;


void setup()
{
   vw_set_tx_pin(transmit_pin);
    vw_set_rx_pin(receive_pin);
     vw_set_ptt_pin(transmit_en_pin);
    vw_set_ptt_inverted(true); // Required for DR3100
    vw_setup(2000);       // Bits per sec
    pinMode(led_pin, OUTPUT);
  Serial.begin(9600);
}
void loop()
{
  
  
 
   char *msg;
if (Serial.available() > 0)
{incomingByte = Serial.read();
if(incomingByte==49)
  { 
            for(int i=0;i<30;i++)
        {    
    char *msg = "1";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

 
        }
 
  }
  else
  if(incomingByte==50)
  { 
       for(int i=0;i<30;i++)
        {             
    char *msg = "2";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

 // Serial.println("left");
        }
  }
  else
  if(incomingByte==51)
  { 
      for(int i=0;i<30;i++)
        {              
    char *msg = "3";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

 // Serial.println("left");
        }
 
  }
  else
  if(incomingByte==52)
  { 
      for(int i=0;i<30;i++)
        {              
    char *msg = "4";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

 // Serial.println("left");
        }
  }
  
  else
 if(incomingByte==53)
  { 
                
    char *msg = "5";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

 // Serial.println("left");
 
  }
  else
 if(incomingByte==54)
  { 
                
    char *msg = "6";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

 // Serial.println("left");
 
  }
  else
 if(incomingByte==55)
  { 
                
    char *msg = "7";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

 // Serial.println("left");
 
  }
  else
 if(incomingByte==56)
  { 
                
    char *msg = "8";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

 // Serial.println("left");
 
  }
  else
 if(incomingByte==57)
  { 
                
    char *msg = "9";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

 // Serial.println("left");
 
  }
  else
 if(incomingByte==97)
  { 
                
    char *msg = "a";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

 // Serial.println("left");
 
  }
  else
 if(incomingByte==98)
   { 
                
    char *msg = "b";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

 // Serial.println("left");
 
  }
/*  

  if((329<x<337)  &&(264<y)&&(y<279)&&  (380<z<391))
{
  Serial.println("right");
      char *msg = "2";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

  
}
  
 if((405<x)&&(x<416)  &&  (318<y<329)  && (363<z<374))
 
  {Serial.println("forward");
  char *msg = "3";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

}
  
  if((272<x)&&(x<282)  &&  (333<y<344)  &&  (377<z<388))
  {
  Serial.println("backward");
      char *msg = "4";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

}
if((347<x<358)  && (318<y<328 ) &&  (420<z)&&(z<431))
  {
    char *msg = "5";
      digitalWrite(13, true); // Flash a light to show transmitting
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx(); // Wait until the whole message is gone
    digitalWrite(13, false);

  Serial.println("stop");
 
  }
 */ delay(500);

}
}
