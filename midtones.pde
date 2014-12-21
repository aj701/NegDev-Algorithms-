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

