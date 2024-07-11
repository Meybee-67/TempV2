#define uS_TO_S_FACTOR 1000000 /* Conversion factor for micro seconds to seconds */  
#define TIME_TO_SLEEP 3 /* Time ESP32 will go to sleep (in seconds) */    
RTC_DATA_ATTR int bootCount = 0;    
#define GREEN_LED_PIN 4
#define YELLOW_LED_PIN 3  

void setup(){    
 pinMode(GREEN_LED_PIN,OUTPUT);  
 pinMode(YELLOW_LED_PIN,OUTPUT);  
 delay(500);
 bootCount= bootCount+1;
 if(bootCount%2==0) //Run this only the first time  
 {  
 digitalWrite(YELLOW_LED_PIN,HIGH);   
 }else  
 {  
 digitalWrite(GREEN_LED_PIN,HIGH);  
 }     
 delay(3000);    
 digitalWrite(GREEN_LED_PIN,LOW);  
 digitalWrite(YELLOW_LED_PIN,LOW);    
 esp_sleep_enable_timer_wakeup(TIME_TO_SLEEP * uS_TO_S_FACTOR);  
 esp_deep_sleep_start();  
}    

void loop(){}
