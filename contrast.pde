
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

