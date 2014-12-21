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
