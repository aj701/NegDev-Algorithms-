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

