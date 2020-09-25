void setup() {
  pinMode(3, OUTPUT); //red
  pinMode(4, OUTPUT); //green
  pinMode(5, OUTPUT); //green
  pinMode(2, INPUT); //button
}

void loop() {
  int switchState = 0;
  switchState = digitalRead(2);
 //variable set to state of pin 2, which is button
  if (switchState == LOW) {
    //button not pressed

    digitalWrite(3, HIGH); //red light
    digitalWrite(4, LOW); //green light
    digitalWrite(5, LOW); //green light

  }

  else {
    //if button pressed
    digitalWrite(3, LOW); //red light
    digitalWrite(4, LOW); //green light
    digitalWrite(5, HIGH); //green light

    delay(250); // wait for quarter second
    // toggle LEDs
    digitalWrite(4, HIGH); //green light
    digitalWrite(5, LOW); //green light
    delay(250); // wait for quarter second
  }
}
