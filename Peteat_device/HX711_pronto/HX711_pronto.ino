#include "HX711.h"
#include <EEPROM.h>
#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <time.h>
#include <string.h>


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


// HX711 circuit wiring
const int DOUT_PIN = 5;
const int DOUT_SCK = 4;

const int DOUT_PIN_1 = 0;
const int DOUT_SCK_1 = 2;
//MQTT
const char* SSID = "Rafael";                           
const char* PASSWORD = "V7356i2851v41o";                  
const char* ip = "seu ip";                       
const char* mqtt_server = "e55ab74b.us-east-1.emqx.cloud";
int broker_port = 15139;                                  
#define outTOPIC "testLB/outtopic"                       
#define inTOPIC "testLB/intopic"
#define notification "notification" 
#define DISPARO "DISPARO"
#define ESTOQUE "ESTOQUE"
#define CALIBRADO "CALIBRA"
int value = 0;
char tarefa = '.';
char *funcao = &tarefa;
char tarefas[4]= {'0','0','0'};
char *funcaos = &tarefas[4];


HX711 tigela;
bool letter = false;
const int FLAGS = 0;
const int ENDER_ESCALA = 1;
const byte FLAG_CALIBRADA = 0x10;
float peso;

HX711 reservatorio;
const int FLAGS_ = 0;
const int ENDER_ESCALA_ = 1;
const byte FLAG_CALIBRADA_ = 0x20;
float peso_;
int cont = 0;

WiFiClient espClient;                                     
PubSubClient client(espClient);                           

unsigned long lastMsg = 0;                                
#define MSG_BUFFER_SIZE  (50)
char msg[MSG_BUFFER_SIZE];



void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.println("]");
  char sfuncao[1];
  char funcaoss[6];
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
    if (i == 0){
      sfuncao[0] = ((char)payload[i]);
      }if (i == 2){
      funcaoss[i-2] = ((char)payload[i]);
      }
    }
  Serial.print(">");
  Serial.print(sfuncao[0]);
  Serial.println("<");
   if(sfuncao[0] == 'A'){
    float valor;
    float entrada;
    float entradas;
    peso = tigela.get_units(10);
    char medida[17];
    char teste[17];
    dtostrf (peso, 6, 3, medida);
    client.publish(DISPARO, medida);
    entradas = atof(funcaoss);
    entrada = entradas * 0.10;
    Serial.print("Variavel ap??s a convers??o: ");    
    Serial.println(entradas);
    if(valor < entrada){
    digitalWrite(12, HIGH);
    Serial.println("Motor ligado");
    delay(12000);
    }
    digitalWrite(12, LOW);
    Serial.println("Motor desligado");
    delay(1000);
    unsigned long now = millis();
    Serial.println("Publish message: ");
    strcat (medida, "g");
    Serial.print("Tigela: ");
    Serial.println(medida);
    client.publish(notification, medida);
    
      }
  
   if(sfuncao[0] == 'B'){
    peso_ = reservatorio.get_units(10);
    char medidaE[17];
    Serial.print("Reservatorio: ");
    dtostrf (peso_, 7, 3, medidaE);
    client.publish(ESTOQUE, medidaE);
    }
  

  
  // Switch on the LED if the first character is present
  if ((char)payload[0] != NULL) {
    digitalWrite(LED_BUILTIN, LOW); // Turn the LED on (Note that LOW is the voltage level
    // but actually the LED is on; this is because
    // it is active low on the ESP-01)
    
    delay(500);
    digitalWrite(LED_BUILTIN, HIGH); // Turn the LED off by making the voltage HIGH
  } else {
    digitalWrite(LED_BUILTIN, HIGH); // Turn the LED off by making the voltage HIGH
  }
    Serial.println("N??o travou ate aqui");

}


void setup_wifi() {
  WiFi.begin(SSID, PASSWORD);
  Serial.println("Conectando na rede: ");
  Serial.println(SSID);
  while (WiFi.status() != WL_CONNECTED) {
   Serial.print(".");
   delay(500);
  }
    Serial.println("Conetado ao wifi");
    
}

void reconnect() {
  // Loop until we???re reconnected
  while (!client.connected()) {
    Serial.print("Tentando conex??o ao Mqtt ");
    String clientId = "Peteat Device";
    // Attempt to connect
    // Insert your password
    if (client.connect(clientId.c_str(),"PeteatEsp","Semsenha123456789")) {
      Serial.println("connected");
      // Once connected, publish an announcement???
      client.publish("testLB/outtopic", "ESP-CONECTADO");
      // ??? and resubscribe
      client.subscribe(inTOPIC);
    } else {
      Serial.print("Falha, rc = ");
      Serial.print(client.state());
      Serial.println(" tentando novamente em 5 segundos");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}



void ajustaTara() {
  Serial.println("Registrando TARA");
  delay(500);
  tigela.tare(50);
  reservatorio.tare(50);
}


void calibra() {
  // Mostra as instru????es
  
  Serial.println("CALIBRAGEM");
  Serial.println("Deixe a tigela e o reservatorio vazios");
  client.publish("CALIBRA", "INICIA_CALIBRAGEM");
  delay (5000);

  Serial.println("Coloque 500g na tigela e 1kg no reservatorio");
  for(int l = 0; l < 10; l++){
    delay(1000);
    Serial.println(l);
    }
  delay(5000);
  if (letter = 'A') {
    delay(100);
      // Faz a leitura e calcula a escala
  long leitura = tigela.read_average(25);
  float escala = (leitura - tigela.get_offset())/0.50f;
  long leitura_ = reservatorio.read_average(25);
  float escala_ = (leitura_ - reservatorio.get_offset())/.50f;
  // Salva na EEProm
  EEPROM.put(ENDER_ESCALA, escala);
  EEPROM.put(ENDER_ESCALA_, escala_);
  EEPROM.write(FLAGS, FLAG_CALIBRADA);
  EEPROM.write(FLAGS_, FLAG_CALIBRADA_);
  
    // Usa a escala calculada
  Serial.println("Sistema Iniciado com sucesso");
  delay(2000);
  tigela.set_scale(escala);
  reservatorio.set_scale(escala_);
  }
 client.publish("CALIBRA", "TERMINA_CALIBRAGEM");

 Serial.println("balan??as calibradas");
  delay(1000);
  
}



void setup() {
  Serial.begin(9600);
  setup_wifi();
  client.setServer(mqtt_server, broker_port);
  client.setCallback(callback);
  tigela.begin(DOUT_PIN, DOUT_SCK);
  reservatorio.begin(DOUT_PIN_1, DOUT_SCK_1);
  ajustaTara();
  if (!client.connected()) {
    reconnect();
  }
  pinMode(12, OUTPUT);
  if (EEPROM.read(FLAGS) != FLAG_CALIBRADA){
    calibra();
    float pesos = tigela.get_units(10);
    float pesoz = reservatorio.get_units(10);
  } else {
    // Usa escala salva na EEPROM
    float escala;
    float escala_;
    EEPROM.get(ENDER_ESCALA, escala);
    EEPROM.get(ENDER_ESCALA_,escala_);
    tigela.set_scale(escala);
    reservatorio.set_scale(escala_);
       }  
    }


void loop() {

   if (!client.connected()) {
    reconnect();
  }
  client.loop();



  delay(500);
  
tarefa = '.';
}
