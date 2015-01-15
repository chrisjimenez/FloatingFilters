/**
* FloatingFilters.pde
* By: Chris Jimenez
*
* Interactive mirror where you could select which filters you want
* to use by clicking on them as they float on the screen.
*/

import processing.video.*;

//  video feed
Capture video1;


//  array of video sections....
PictureSection[] vidSections = new PictureSection[4];

float pixelAlpha = 100;
float pixelCount = 0.5;

void setup() {
  size(320, 240);

  // grab an array of our cameras
  String[] cameras = Capture.list();

  // no camera objects - no need to continue!  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    video1 = new Capture(this, 320, 240);
    video1.start();
  }


  //construct array of vid sections 
  for (int i = 0; i < vidSections.length;i++) {
    vidSections[i] = new PictureSection(video1);
  }
}

/**
* Gets called repeatedly.
*/
void draw() {
  //check if video feed is ready...
  if (video1.available()) video1.read();

  image(video1, 0, 0, 320, 240);
  for (int x = 0 ; x < video1.width; x+=8) {
    for (int y = 0; y < video1.height; y+=8) {
      int location = x + y*video1.width;
      color temp = video1.pixels[ location ];

      noStroke();
      fill(temp, pixelAlpha);
      rect(x + random(-3, 3), y + random(-3, 3), 8, 8);
    }
  }

  //display vid sections..
  for (int i = 0; i < vidSections.length; i++) {
    println(i + " = " + vidSections[i].invert);
    vidSections[i].display(video1);
  }

  updateCount();
}

/**
* updates the alpha count of the expanded pixels and ellipse
*/
void updateCount() {
  if ((pixelAlpha > 250) || (pixelAlpha < 100)) {
    pixelCount *= -1;
  }

  //  update alpha values..
  pixelAlpha += pixelCount;
}

/**
* Gets called when user presses the UP, DOWN, LEFT OR RIGHT arrow button
*/
void keyPressed() {
  if ( key == CODED) {
    if (keyCode == UP) {
      for (int i= 0; i< vidSections.length;i++) {
        vidSections[i].increaseWidthAndHeight();
      }
    }

    if (keyCode == DOWN) {
      for (int i= 0; i< vidSections.length;i++) {
        vidSections[i].decreaseWidthAndHeight();
      }
    }

    //left & right to control circle radius
    if (keyCode == LEFT) {
      for (int i= 0; i< vidSections.length;i++) {
        vidSections[i].decreaseSpeed();
      }
    }

    if (keyCode == RIGHT) {
      for (int i= 0; i< vidSections.length;i++) {
        vidSections[i].increaseSpeed();
      }
    }
  }
}

