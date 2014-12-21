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


