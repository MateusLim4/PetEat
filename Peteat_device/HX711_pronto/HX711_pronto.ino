#include "HX711.h"
#include <EEPROM.h>
#include <ESP8266WiFi.h>
#include <PubSubClient.h>

#define D0    16
#define D1    5
#define D2    4
#define D3    0
#define D4    2
#define D5    14
#define D6    12
#define D7    13
#define D8    15
#define D9    3
#define D10   1



//MQTT
const char* SSID = "Rafael";                           
const char* PASSWORD = "V7356i2851v41o";                  
const char* ip = "seu ip";                       
const char* mqtt_server = "test.mosquitto.org";    
int broker_port = 1883;                                  
#define outTOPIC "testLB/outtopic"                       
#define inTOPIC "testLB/intopic" 

WiFiClient espClient;                                     
PubSubClient client(espClient);                           

unsigned long lastMsg = 0;                                
#define MSG_BUFFER_SIZE  (50)
char msg[MSG_BUFFER_SIZE];
int value = 0;


void setup_wifi() {
  WiFi.begin(SSID, PASSWORD);
  Serial.print("Conectando na rede: ");
  Serial.println(SSID);
  while (WiFi.status() != WL_CONNECTED) {
   Serial.print(".");
   delay(500);
  }
    Serial.print("Conetado ao wifi");
    
}

void reconnect() {
  while (!client.connected()) {
    Serial.print("Conectando ao MQTT...");
    if (client.connect("ESP8266Client-")) {
      Serial.println("connected");                                              
    } else {
      Serial.print("Falha ao Conectar, rc=");                        
      Serial.print(client.state());
      Serial.println(" tentando se reconectar...");          
      delay(5000);
    }
  }
}

//
// HX711 circuit wiring
const int DOUT_PIN = 5;
const int DOUT_SCK = 4;

HX711 tigela;
bool letter = false;
const int FLAGS = 0;
const int ENDER_ESCALA = 1;
const byte FLAG_CALIBRADA = 0x55;
float peso;

void ajustaTara() {
  Serial.println("Registrando TARA");
  delay(500);
  tigela.tare(50);
}

void calibra() {
  // Mostra as instruções
  Serial.println("CALIBRACAO");
  Serial.println("Deixe a tigela vazia");

  delay (3000);

  Serial.println("Coloque 500g");
  delay(5000);
  if (letter = 'A') {
    delay(100);
      // Faz a leitura e calcula a escala
  long leitura = tigela.read_average(25);
  float escala = (leitura - tigela.get_offset())/0.50f;
  
  // Salva na EEProm
  EEPROM.put(ENDER_ESCALA, escala);
  EEPROM.write(FLAGS, FLAG_CALIBRADA);
  
    // Usa a escala calculada
  Serial.println("Iniciou");
  delay(2000);
  tigela.set_scale(escala);
  }
  
 Serial.println("balança ja calibrada");
  delay(1000);
  
}


void setup() {
  Serial.begin(9600);
  void setup_wifi();

  client.setServer(mqtt_server, 1883);

  tigela.begin(DOUT_PIN, DOUT_SCK);
  ajustaTara();
  pinMode(12, OUTPUT);
  if (EEPROM.read(FLAGS) != FLAG_CALIBRADA){
    calibra();
  } else {
    // Usa escala salva na EEPROM
    float escala;
    EEPROM.get(ENDER_ESCALA, escala);
    tigela.set_scale(escala);
 
  }  
  
  }


void loop() {

   if (!client.connected()) {
    reconnect();
  }
  client.loop();

  unsigned long now = millis();                          
  if (now - lastMsg > 2000) {
    lastMsg = now;
    ++value;
    snprintf (msg, MSG_BUFFER_SIZE, "hello world #%ld", value);
    Serial.print("Publish message: ");
    Serial.println(msg);
    client.publish(outTOPIC, msg);
}

  peso = tigela.get_units(10);
  char medida[17];
  dtostrf (peso, 7, 3, medida);
  strcat (medida, "g");
  Serial.println(medida);
  float entrada = 00.250;
  float valor;
  valor = atof(medida);
  if(valor < entrada){
    digitalWrite(12, HIGH);
    delay(1000);
    }else{
    digitalWrite(12, LOW); 
    delay(1000);
      }
 
  delay(100);
  
}
