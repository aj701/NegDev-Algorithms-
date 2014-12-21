//Negative Developer Super Duper Alpha what?
//Help from Daniel Shiffman
//Help from http://www.dfstudios.co.uk/articles/programming/image-programming-algorithms/ articles & math on image adjustment algorithms
//Help from pocket handbook of image processing algorithms 
//TBD White Balance Study via Gimp http://docs.gimp.org/en/gimp-layer-white-balance.html -- remap?
//TBD future color info http://www.comp.nus.edu.sg/~brown/pdf/ColorConstancyJOSAv10.pdf - http://www.comp.nus.edu.sg/~whitebal/illuminant/files/illuminantEstimator.m
//Conversion Chats - http://www.cs.rit.edu/~ncs/color/t_convert.html
//convert to hsv for more color balance?


import controlP5.*;
ControlP5 cp5;
Slider abc;
float Contrast = 40;
float Gamma;
float RedSaturate; 
float GreenSaturate; 
float BlueSaturate;
float MasterBright;
float RedBright;
float GreenBright; 
float BlueBright;

float vertSpace = 80;
float horSpace = 810;
PImage src;
void setup() {
  background(35);
  cp5 = new ControlP5(this);
  src = loadImage("portra400-small.jpg");
  size(src.width+300, src.height); //double size to see both images at once
  PImage dest = src.get(); //get image and put in destination - run functions
  invert(dest);
  contrast(dest, 40); //between -255 and 255 This is moving from red(low contrast) to green(high contrast) ??
  saturate(dest, 230, 315, 230); //(r,g,b) between 0-500
  bright(dest, 25, 0, -7, 0); //maste brightness, red, green, blue
  gamma(dest, 3.4); //between 1-7
  //highlights(dest, -20 );
  //shadows(dest);
  //midtones(dest);

  image(dest, 0, 0); 
  cp5.addSlider("MasterBright")
    .setPosition(horSpace, vertSpace+20)
      .setSize(200, 20)
        .setRange(-50, 50)
          .setValue(25)
            ;

  cp5.addSlider("RedBright")
    .setPosition(horSpace, vertSpace+60)
      .setSize(200, 20)
        .setRange(-50, 50)
          .setValue(0)
            ;

  cp5.addSlider("GreenBright")
    .setPosition(810, vertSpace+90)
      .setSize(200, 20)
        .setRange(-50, 50)
          .setValue(-7)
            ;

  cp5.addSlider("BlueBright")
    .setPosition(horSpace, vertSpace+120)
      .setSize(200, 20)
        .setRange(-50, 50)
          .setValue(0)
            ;
  cp5.addSlider("Contrast")
    .setPosition(horSpace, vertSpace+180)
      .setSize(200, 20)
        .setRange(-255, 255)
          .setValue(40)
            ;

  cp5.addSlider("Gamma")
    .setPosition(horSpace, vertSpace+210)
      .setSize(200, 20)
        .setRange(0, 6)
          .setValue(3.4)
            ;

  cp5.addSlider("RedSaturate")
    .setPosition(horSpace, vertSpace+270)
      .setSize(200, 20)
        .setRange(0, 500)
          .setValue(230)
            ;
  cp5.addSlider("GreenSaturate")
    .setPosition(horSpace, vertSpace+300)
      .setSize(200, 20)
        .setRange(0, 500)
          .setValue(315)
            ;

  cp5.addSlider("BlueSaturate")
    .setPosition(horSpace, vertSpace+330)
      .setSize(200, 20)
        .setRange(0, 500)
          .setValue(230)
            ;
}

void draw() {

  PImage dest = src.get(); //get image and put in destination - run functions
  invert(dest);
  contrast(dest, Contrast); //between -255 and 255 This is moving from red(low contrast) to green(high contrast) ??
  saturate(dest, RedSaturate, GreenSaturate, BlueSaturate); //(r,g,b) between 0-500
  bright(dest, MasterBright, RedBright, GreenBright, BlueBright); //maste brightness, red, green, blue
  gamma(dest, Gamma); //between 1-7
//  highlights(dest, -20 );
  //shadows(dest);
  //midtones(dest);

  image(dest, 0, 0); 

  //noLoop();
}



void bright(PImage img, float brightMaster, float brightR, float brightG, float brightB) {
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y=0; y < img.height; y++) {
      int loc = x+y*img.width;
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      float newR = r + brightR + brightMaster*0.299; //percieved ratio of RGB levelled out for the human eye
      float newG = g + brightG + brightMaster*0.587;
      float newB = b + brightB + brightMaster*0.114;
      
      img.pixels[loc] = color(newR, newG, newB);
    }
  }
  img.updatePixels();
}

PImage contrast(PImage img, float contrast) {
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y=0; y < img.height; y++) {
      float factor = (259*(contrast+255)) / (255*(259 - contrast));
      int loc = x+y*img.width;
      float r = red(img.pixels[loc]);
      float newR = ((factor*(r - 128)) + 128);//*0.299;
      float g = green(img.pixels[loc]);
      float newG = ((factor*(g - 128)) + 128);//*0.587;
      float b = blue(img.pixels[loc]);
      float newB = ((factor*(b - 128)) + 128);//*0.114;
      newR = constrain(newR, 0, 255); 
      newG = constrain(newG, 0, 255); 
      newB = constrain(newB, 0, 255);

      img.pixels[loc] = color(newR, newG, newB);
    }
  }
  img.updatePixels();
  return img;
}

PImage gamma(PImage img, float gammaMaster) {
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y=0; y < img.height; y++) {
      int loc = x+y*img.width;
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      float newR = 255 * pow((r/255), gammaMaster);
      float newG = 255 * pow((g/255), gammaMaster);
      float newB = 255 * pow((b/255), gammaMaster);
      img.pixels[loc] = color(newR, newG, newB);
    }
  }
  img.updatePixels();
  return img;
}

PImage highlights(PImage img, float highMaster) {
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y=0; y < img.height; y++) {
      int loc = x+y*img.width;
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      if (r >= 171 & r <= 205 ) {
        float rdHigh = r + highMaster;
        r = rdHigh;
        img.pixels[loc] = color(r, g, b);
      } else if ( g >= 171 & g <= 205 ) {
        float gHigh = g + highMaster;
        g = gHigh;
        img.pixels[loc] = color(r, g, b);
      } else if ( b >= 171 & b <= 205 ) {
        float bHigh = b + highMaster;
        b = bHigh;
        img.pixels[loc] = color(r, g, b);
      }
    }
  }
  img.updatePixels();
  return img;
}

//PImage gamma(PImage img, float h, float s, float v) {
//  img.loadPixels();
//  for (int x = 0; x < img.width; x++) {
//    for (int y=0; y < img.height; y++) {
//      int loc = x+y*img.width;
//      float r = red(img.pixels[loc]);
//      float g = green(img.pixels[loc]);
//      float b = blue(img.pixels[loc]);
//      float minVal = min(r, g, b);
//      float maxVal = max(r, g, b);
//      float v = maxVal;
//      
//      
//      
//      
//      
//      float newR = 255 * pow((r/255), gammaMaster);
//      float newG = 255 * pow((g/255), gammaMaster);
//      float newB = 255 * pow((b/255), gammaMaster);
//      img.pixels[loc] = color(newR, newG, newB);
//    }
//  }
//  img.updatePixels();
//  return img;
//}
PImage invert(PImage img) {
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y=0; y < img.height; y++) {
      int loc = x+y*img.width;
      float r = 255-red(img.pixels[loc]);
      float g = 255-green(img.pixels[loc]);
      float b = 255-blue(img.pixels[loc]);
      img.pixels[loc] = color(r, g, b);
    }
  }
  img.updatePixels();
  return img;
}
PImage midtones(PImage img) {
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y=0; y < img.height; y++) {
      int loc = x+y*img.width;
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      if (r >= 85 & r <= 170 ) {
        float rdHigh = r*1.4;
        r = rdHigh;
        img.pixels[loc] = color(r, g, b);
      } else if ( g >= 85 & g <= 170 ) {
        float gHigh = g*1.4;
        g = gHigh;
        img.pixels[loc] = color(r, g, b);
      } else if ( b >= 85 & b <= 170 ) {
        float bHigh = b*1.4;
        b = bHigh;
        img.pixels[loc] = color(r, g, b);
      }
    }
  }
  img.updatePixels();
  return img;
}

PImage saturate(PImage img, float saturR, float saturG, float saturB) {
  for (int x = 0; x < img.width; x++) {
    for (int y=0; y < img.height; y++) {
      int loc = x+y*img.width;
      float satR = map(saturR, 0, width, 0, 500);
      float satG = map(saturG, 0, width, 0, 500);
      float satB = map(saturB, 0, width, 0, 500);
      color col;

      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);

      float r1 = r; 
      float g1 = g; 
      float b1 = b;
      float ry1 = ((100*r1-59*g1-11*b1)/100);
      float by1 = ((-30*r1-59*g1+89*b1)/100);
      float gy1 = ((-30*r1+41*g1-11*b1)/100);
      float y1   =  ( 30*r1+59*g1+11*b1)/100 ;
      float ry  = (ry1*satR)/100;
      float gy  = (gy1*satG)/100;
      float by  = (by1*satB)/100;
      r1 = ry + y1; 
      g1 = gy + y1; 
      b1 = by + y1;
      r1 = constrain(r1, 0, 255); 
      g1 = constrain(g1, 0, 255); 
      b1 = constrain(b1, 0, 255);
      r = r1; 
      g = g1; 
      b = b1;
      img.pixels[loc] = color(r, g, b);
    }
  }
  img.updatePixels();
  return img;
}

PImage shadows(PImage img) {
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y=0; y < img.height; y++) {
      int loc = x+y*img.width;
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      if (r >= 20 & r <= 85 ) {
        float rdHigh = r*1.6;
        r = rdHigh;
        img.pixels[loc] = color(r, g, b);
      } else if ( g >= 20 & g <= 85 ) {
        float gHigh = g*1.6;
        g = gHigh;
        img.pixels[loc] = color(r, g, b);
      } else if ( b >= 20 & b <= 85 ) {
        float bHigh = b*1.6;
        b = bHigh;
        img.pixels[loc] = color(r, g, b);
      }
    }
  }
  img.updatePixels();
  return img;
}


//// Simple Slider
//// Thanks Daniel Shiffman <http://www.shiffman.net>
//
//class Slider { 
//  //initiate 
//  boolean dragging = false; // Is the slider being dragged?
//  boolean rollover = false; // Is the mouse over the slider?
//  // Rectangle variables for slider
//  float x = 100;
//  float y;
//  float w = 10;
//  float h = 50;
//  // Start and end of slider
//  float sliderStart = 100;
//  float sliderEnd = 400;
//  // Offset for dragging slider
//  float offsetX = 0;
//  float rangeLow;
//  float rangeHigh;
//  float fillColor;
//  float yPos;
//
//  //constructor
//  Slider (float yPos, float rangeStart, float rangeLow, float rangeHigh, float fillColor) {
//    offsetX = rangeStart;
//    this.rangeLow = rangeLow;
//    this.rangeHigh = rangehigh;
//    this.fillColor = fillColor;
//    y = yPos;
//  }
//
//
//  // Is it being dragged?
//  
//  if (dragging) {
//    x = mouseX + offsetX;
//  }
//    
//  // Keep rectangle within limits of slider
//  x = constrain(x, sliderStart, sliderEnd-w);
//
//  // Draw a line for slider
//  stroke(0);
//  line(sliderStart, y+h/2, sliderEnd, y+h/2);
//
//  stroke(0);
//  // Fill according to state
//  if (dragging) {
//    fill (this.fillColor/2);
//  } else {
//    fill(this.fillColor);
//  }
//
//
//  // Map is an amazing function that will map one range to another!
//  // Here we take the slider's range and map it to a value between 0 and 255
//  float b = map(x, sliderStart, sliderEnd-w, this.rangeLow, this.rangeHigh);
//  fill(b);
//  rect(sliderStart, this.yPos, sliderEnd-sliderStart, 150);
//}
//
//void mousePressed() {
//  // Did I click on slider?
//  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
//    dragging = true;
//    // If so, keep track of relative location of click to corner of rectangle
//    offsetX = x-mouseX;
//  }
//}
//
//void mouseReleased() {
//  // Stop dragging
//  dragging = false;
//}
//}
//PImage whiteB(PImage img) {
//  img.loadPixels();
//  for (int x = 0; x < img.width; x++) {
//    for (int y=0; y < img.height; y++) {
//      int loc = x+y*img.width;
//      float r = red(img.pixels[loc]);
//      float g = green(img.pixels[loc]);
//      float b = blue(img.pixels[loc]);
//      float newR = 255 * pow((r/255), gammaMaster);
//      float newG = 255 * pow((g/255), gammaMaster);
//      float newB = 255 * pow((b/255), gammaMaster);
//      img.pixels[loc] = color(newR, newG, newB);
//    }
//  }
//  img.updatePixels();
//  return img;
//}

