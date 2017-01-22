  Sierpinsky sierpinsky;
  
  void mousePressed() {
    redraw();
  }
  
  void setup() {
    size (650, 650, P3D);
    background (255);  
    
    sierpinsky = new Sierpinsky();
    noLoop();
  }
  
  // Keyboard functionality
  // Pressing 'w' alternates between wireframe and solid modes
  // Up and down arrow keys alternates between fractal displays
  // r rotates the object
  void keyPressed() {
    
    if (keyPressed) {
      
      delay (200);
      
      if (key == 'w') {
        sierpinsky.altWireframe();
      } 
    
      else if (key == CODED && keyCode == UP) {
        sierpinsky.altArrowheadOpt();
      }
      
      redraw();
    }
  }
  
  void drawSierpinsky() {
    
    sierpinsky.draw();
    sierpinsky.incrementDepth(7);
    
    fill(255);
    textSize(17);
    if (!sierpinsky.getArrowheadOpt()) text ("Sierpinsky's Gasket", 245, 50);
    else text ("Sierpinsky's Arrowhead Curve", 205, 50);
  }
  
  void draw() {
    
    drawSierpinsky();
    
  }