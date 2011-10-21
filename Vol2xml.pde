import ddf.minim.*;
import proxml.*;

String fileIn = "B track lawyer fx.wav";
String fileOut = "audio_lawyer.xml";

int fps = 24;
int counterMin = 0;
int counter = counterMin;
int counterMax = 1200;
boolean limitReached = false;

XMLInOut xmlIO;
proxml.XMLElement xmlFile;
String xmlFileName = fileOut;

Minim minim;
//AudioInput in;
AudioPlayer player;
float volumeLevel;
float volumeScale = 75;
int yFloor = 220;
int yPos = yFloor;
Smiley bob;

void xmlInit() {
  xmlIO = new XMLInOut(this);
  xmlFile = new proxml.XMLElement("keyFrameList");
}

void xmlAdd() {
    proxml.XMLElement frameData = new proxml.XMLElement("frameData");
    xmlFile.addChild(frameData);
    proxml.XMLElement frameNum = new proxml.XMLElement("frameNum");
    frameData.addChild(frameNum);
    frameNum.addChild(new proxml.XMLElement(""+counter,true));
    proxml.XMLElement volume = new proxml.XMLElement("volume");
    frameData.addChild(volume);
    volume.addChild(new proxml.XMLElement(""+volumeLevel,true));
}

/* saves the XML list to disk */
void xmlSaveToDisk() {
  xmlIO.saveElement(xmlFile, xmlFileName);
}    

void setup() {
  size(640,480);
  frameRate(fps);
  minim = new Minim(this);
  player = minim.loadFile(fileIn,512);
  player.play();
  bob = new Smiley(width/2,yFloor,100,false);
  xmlInit();
}

void draw() {
  if(!limitReached) {
    background(200);
    trackVolume();
    drawVolume();
    bob.update();
    
    if(counter<counterMax) {
      xmlAdd();
      counter++;
    } else {
      limitReached=true;
      xmlSaveToDisk();
      println("saved file " + xmlFileName);
    }
  }
}

void trackVolume() {
  volumeLevel=0;  //must reset to 0 each frame before measuring
  for(int i = 0; i < player.bufferSize() - 1; i++) {
    if ( abs(player.mix.get(i)) > volumeLevel ) {
      volumeLevel = abs(player.mix.get(i));
      if(volumeLevel < 0.001){
      volumeLevel=0;
      }
      println(volumeLevel);
    }
  }
}

void drawVolume() {
  yPos -= volumeLevel * volumeScale;
  bob.yPos = yPos;
  if ( yPos < height ) {
    yPos = yFloor;
  }
  bob.mouthClosed = abs(30-(volumeLevel*volumeScale));
  if(bob.mouthClosed<5) {
    bob.mouthClosed = 5;
  }
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}

