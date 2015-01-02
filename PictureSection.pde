class PictureSection {
  int xPos;
  int yPos;
  float xMove;
  float yMove;
  int psWidth = 50;
  int psHeight = 50;
  int filterCount;

  boolean invert = false;

  PImage primaryImage;
  PImage sectionImage;

  PictureSection(PImage i) {
    primaryImage = i;//initialize primary image
    xPos = (int)random(30, width-psWidth);
    yPos = (int)random(30, height-psHeight);

    xMove = random(1, 3);
    yMove = random(1, 3);

    sectionImage = new PImage(psWidth, psHeight);

    //load pixels for primary image and section image
    // for manipulation later...
    primaryImage.loadPixels();
    sectionImage.loadPixels();

    filterCount = (int)random(0, 5.4);
  }

  //===============================================================
  // displays pic section
  void display(PImage i) {
    primaryImage = i;
    sectionImage = new PImage(psWidth, psHeight);
    updatePicSection();
    updatePosition();
    isPressed();//if pressed invert
    if (keyPressed && key == ' ') {
      invert = false;
    }

    if (invert) {
      displayFilter(primaryImage);
      image(primaryImage, 0, 0);
    }

    stroke(200);
    rect(xPos, yPos, psWidth, psHeight);//border around seciton image
    displayFilter(sectionImage);
    image(sectionImage, xPos, yPos);
  }

  //======================================================================
  //update pic section position
  void updatePosition() {
    xPos += xMove;
    yPos += yMove;

    xPos = constrain(xPos, 0, width-psWidth);
    yPos = constrain(yPos, 0, height-psHeight);

    // do we need to bounce the rect?
    if (xPos >=  width-psWidth || xPos <= 0) {
      xMove = xMove * -1;
      if (!invert) filterCount++;
    }

    if (yPos >= height-psHeight || yPos <= 0) {
      yMove = yMove * -1;
      if (!invert) filterCount++;
    }
  }


  //=======================================================================
  //using algorithm to capture section of image...
  void updatePicSection() {
    //initilize location of x,y position of section
    int location = xPos + yPos*primaryImage.width;

    //    for (int i = 0; i < sr.rectWidth; i++) {//for eahc pixel in the row
    //      for (int j = 0; j < sr.rectHeight; j++) {//for each row of section
    //        croppedImage.pixels[i+ j*sr.rectWidth] = userImage.pixels[location + i*sr.rectWidth];
    //      }
    //      location += width;//update location variable to next row of section
    //    }

    for (int i = 0; i < psWidth; i++) {//for each row of section
      for (int j = 0; j < psHeight; j++) {//for each pixel at row
        sectionImage.pixels[i+ j*psWidth] = primaryImage.pixels[location + i +j*width];
      }
    }
  }

  void displayFilter(PImage i) {
    if (filterCount >5) filterCount = 0;

    if (filterCount == 0) i.filter(THRESHOLD);
    if (filterCount == 1) i.filter(GRAY);
    if (filterCount == 2) i.filter(POSTERIZE, 2);
    if (filterCount == 3) i.filter(BLUR); 
    if (filterCount == 4) i.filter(ERODE);
    if (filterCount == 5) i.filter(DILATE);
  }

  //=======================================================
  //determiness if picture section is pressed
  //if so, then the whole pic will have that filter..
  void isPressed() {
    if (mousePressed) {
      if (((mouseX >= xPos) && (mouseX <= xPos+psWidth)) &&
        ((mouseY >= yPos) && (mouseY <=yPos+psHeight))) {
        invert = true;
      }
    }
  }


  //==========================================================================
  //increase and decrease width and height of each section
  void increaseWidthAndHeight() {
    psWidth++;
    psHeight++;
  }

  void decreaseWidthAndHeight() {
    psWidth--;
    psHeight--;
  }

  //==========================================================================
  //increase and decrease speed of each section
  void increaseSpeed() {
    if (xMove < 4 && yMove < 4) {//set speed limit 
      xMove += 0.2;
      yMove += 0.2;
    }
  }

  void decreaseSpeed() {
    if (xMove > 1 && yMove > 1) {
      xMove -= 0.2;
      yMove -= 0.2;
    }
  }
}

