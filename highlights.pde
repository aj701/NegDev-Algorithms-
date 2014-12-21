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

