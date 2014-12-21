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
