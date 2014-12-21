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



