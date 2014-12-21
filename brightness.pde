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
