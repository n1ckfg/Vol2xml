class Smiley {

  float xPos = 320;
  float yPos = 240;
  float diameter = 100;
  boolean mouseFollow = true;
  float mouthClosed = 20;

  Smiley(float x, float y, float d, boolean m) {
    xPos = x;
    yPos = y;
    diameter = d;
    mouseFollow = m;
  }

  void make() {
    ellipseMode(CENTER);
    rectMode(CENTER);
    noStroke();
    fill(200,200,0);
    ellipse (xPos,yPos,diameter,diameter);
    fill(0);
    ellipse(xPos-diameter/7,yPos-diameter/10,diameter/10,diameter/10);
    ellipse(xPos+diameter/7,yPos-diameter/10,diameter/10,diameter/10);
    rect(xPos,yPos+diameter/5,diameter/2,diameter/mouthClosed);
  }

  void update() {
    if(mouseFollow){
      xPos = mouseX;
    yPos = mouseY;
    if(mousePressed) {
      diameter++;
    }
    }
    make();
  }
}

