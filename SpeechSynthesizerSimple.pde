/**
 * Speech Synthesizer
 *
 * Uses a SpeakJet chip from magnevation.com to generate synthesized
 * speech.
 *
 * Copyright 2009 Jonathan Oxer <jon@oxer.com.au>
 * Copyright 2009 Hugh Blemings <hugh@blemings.org>
 *
 * http://www.practicalarduino.com/projects/medium/speech-synthesizer
 */

#include <SoftwareSerial.h>

#define rxPin 2
#define txPin 3

// Create a new software serial port object called "speakJet"
SoftwareSerial speakJet =  SoftwareSerial(rxPin, txPin);

// Set up a memorable token for "Word Pause"
#define WP 6    // 6 is 90ms pause

uint8_t message[] = {
/* hello    */ 183, 007, 159, 146, 164, WP, WP,
/* my       */ 140, 155, WP,
/* name     */ 141, 154, 140, WP,
/* is       */ 8, 129, 167, WP,
/* arduino  */ 152, 148, 175, 147, 128, 141, 164, WP
};

int messageSize = sizeof(message);


/**
 */
void setup()  
{
  // Configure software serial port pins for SpeakJet
  pinMode(rxPin, INPUT);
  pinMode(txPin, OUTPUT);
  speakJet.begin(9600);       // The SpeakJet defaults to 9600bps

  // Send the SpeakJet some initialisation values
  speakJet.print(20, BYTE);   // Enter volume set mode
  speakJet.print(96, BYTE);   // Set volume to 96 (out of 127)
  speakJet.print(21, BYTE);   // Enter speed set mode
  speakJet.print(114, BYTE);  // Set speed to 114 (out of 127)
  delay(1000);
}


/**
 */
void loop()
{
  int i;
  for (i=0; i<messageSize; i++)
  {
    speakJet.print(message[i], BYTE);
  }
  delay (5000);
}
