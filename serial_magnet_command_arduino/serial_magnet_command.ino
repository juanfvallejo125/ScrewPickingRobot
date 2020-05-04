const int magnetPin = 2;

void setup() {
  Serial.begin(9600);
  pinMode(magnetPin, OUTPUT);
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  int magnetStatus;
  int dataIn;

  // check if data has been sent from the computer:
  if (Serial.available()>0) {
    dataIn = Serial.read();
    if(dataIn != '\n'){
    magnetStatus = dataIn;
    }
    if  (magnetStatus == 1)           
    { 
    digitalWrite(magnetPin, HIGH);
    digitalWrite(LED_BUILTIN, HIGH);
    }
    if(magnetStatus == 0)         
    { 
    digitalWrite(magnetPin, LOW);
    digitalWrite(LED_BUILTIN, LOW);
    }
  }
}
