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
