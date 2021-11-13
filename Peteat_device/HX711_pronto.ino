#include "HX711.h"
#include <EEPROM.h>

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
