/* Sonic Pi to Processing OSC example 1 */
/* Note light bars 1 by Mehackit | 2018 */

import netP5.*;
import oscP5.*;
OscP5 oscP5;

static float noteMaximum = 127.0; // 127 is the last MIDI note number :-)
boolean drawNow = false;
float noteNumber = 1;
float xWidth = 1;

void setup() {
  size(800,600);
  smooth();
  oscP5 = new OscP5(this,7010); // defines the OSC port we are listening to!
  //background(255,255,255);
  xWidth = (float)width / noteMaximum; // divides the width of screen by 127 to get a single "note width"  
  strokeWeight(0);
}

 
void draw() {
  fill(255,255,255,8);
  
  rect(0,0,width,height);
 
  // Draws a full height column for the note when drawNow boolean is true
  if (drawNow) {
    fill(255,127,(noteNumber/noteMaximum)*256);
    float posX = noteNumber * xWidth; 
    rect(posX, 0, xWidth, height);
    
    fill(255,127,(noteNumber/noteMaximum)*256);
    textAlign(LEFT, BOTTOM);
    text((int)noteNumber, posX + 10, height - 10);
    drawNow = false;
    
  }
  fill(0,0,0);
  textAlign(LEFT, TOP);
  text("Notebar visualizer by Mehackit", 10, 10);
}

void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/nuotti")==true) {
    if(theOscMessage.checkTypetag("i")) {
      noteNumber = theOscMessage.get(0).intValue();
      drawNow = true;
    }
  }
}