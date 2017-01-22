// Draws Sierpinsky's gasket in both 2D and 3D
// The Sierpinski triangle also called the Sierpinski gasket or the Sierpinski Sieve, is a fractal 
// and attractive fixed set with the overall shape of an equilateral triangle, subdivided recursively into smaller equilateral triangles. 
// https://en.wikipedia.org/wiki/Sierpinski_triangle
public class Sierpinsky {

  private Mapper mapper; // Map coordinates from window coordinates to viewport coordinates
  private boolean wireframe; // Whether to draw the gasket in wireframe mode or not
  private int maxDepth; // The current maximum recursion depth
  private Colors colors; // Color structures for gradient lines
  private PVector[] corners; // corners of Sierpinsky's triangle
  private PVector startPoint; // Starting point for the arrowhead curve
  private double curveLength; // Length of the curve for the arrowhead curve
  private boolean arrowhead;
  
  Sierpinsky() {
    
    mapper = new Mapper (0, 0, width, height,
                         -2.0, -2.0, 2.0, 2.0);
    maxDepth = 2;
    wireframe = false;  
    colors = new Colors();
    
    PVector l = new PVector(-1.0, -1.0);
    PVector t = new PVector(0.0, 1.0);
    PVector r = new PVector(1.0, -1.0);
    corners = new PVector[] {l, t, r};
    startPoint = corners[0];
    curveLength = dist(corners[0].x, corners[0].y, corners[1].x, corners[1].y, corners[2].x, corners[2].y);
    arrowhead = false;
    
  }
  
  // Increment the maximum recursion depth until the given limit
  private void incrementDepth(int limit) {
    
    if (mousePressed) {
      delay(100);
      maxDepth = (maxDepth < limit) ? maxDepth += 1 : 2;
    }
    
  }
  
  // Alternate between wireframe and solid view
  public void altWireframe() {
    
    wireframe = !wireframe; 
    
  }
  
  // Alternate between drawing the normal sierpinsky gasket and the arrowhead curve
  public void altArrowheadOpt() {
    
    arrowhead = !arrowhead; 
    
  }
  
  public boolean getArrowheadOpt() {
    return arrowhead;
  }
  
  // Given a vector, map the coordinates to the viewport and call vertex
  private void vertexMapped (PVector p) {
    
    PVector vertexLoc = mapper.windowToViewport(p.x, p.y);
    vertex(vertexLoc.x, vertexLoc.y);
    
  }
  
  // Given three vectors, map the coordinates to the viewport and draw the resulting triangle
  private void triMapped(PVector leftV, PVector topV, PVector rightV) {
    
      PVector l = mapper.windowToViewport(leftV.x, leftV.y);
      PVector t = mapper.windowToViewport(topV.x, topV.y); 
      PVector r = mapper.windowToViewport(rightV.x, rightV.y);
      
      triangle (l.x, l.y, t.x, t.y, r.x, r.y); 
      
  }
  
  // ------------------------------------------------------Sierpinsky 3D-------------------------------------------------------------

  // Function to draw a single pyramid object
  private void drawPyramid() {
    //float negV = mapper.windowToViewport();
    translate(width/2, height/2, 0);
    stroke(255);
    rotateX(PI/2);
    rotateZ(-PI/6);
    noFill();
    
    beginShape();
      vertex(-100, -100, -100);
      vertex( 100, -100, -100);
      vertex(   0,    0,  100);
      
      vertex( 100, -100, -100);
      vertex( 100,  100, -100);
      vertex(   0,    0,  100);
      
      vertex( 100, 100, -100);
      vertex(-100, 100, -100);
      vertex(   0,   0,  100);
      
      vertex(-100,  100, -100);
      vertex(-100, -100, -100);
      vertex(   0,    0,  100);
    endShape();
  }
  
  private void drawSierpinski3D () {
    
  }
  
  // ---------------------------------------------------Sierpinsky 2D-----------------------------------------------------------------
  
  // Draw the generic Sierpinsky triangle
  private void sierpinski2D(PVector left, PVector top, PVector right, int level) {
    
    level += 1;
    
    if (level < maxDepth) {
      
      // Get the midpoints of each side
      float midLeftX = left.x + (top.x - left.x)/2;
      float midLeftY = top.y + (left.y - top.y)/2;
      
      float botCenterX = left.x + (right.x - left.x)/2;
      float botCenterY = left.y + (left.y - right.y)/2;
      
      float midRightX = top.x + (right.x - top.x)/2;
      float midRightY = top.y + (right.y - top.y)/2;
      
      PVector midLeft = new PVector(midLeftX, midLeftY);
      PVector botCenter = new PVector(botCenterX, botCenterY);
      PVector midRight = new PVector(midRightX, midRightY);
      
      // Draw the lower left, upper, and lower right triangle recursively
      sierpinski2D (left, midLeft, botCenter, level);
      sierpinski2D (midLeft, top, midRight, level);
      sierpinski2D (botCenter, midRight, right, level);
      
    } else {


      if (wireframe) {
        drawWireFrameTri(left, top, right); 
      } else {
        stroke(colors.colMap.get("Golds").c2);
        strokeWeight(2);
        fill (0, 242, 255);
        
        triMapped(left, top, right);
      }
    }
  }
  
  // Given two point coordinates, draw a gradient line between the two
  // Based off of the following discussion: https://forum.processing.org/two/discussion/5620/how-to-draw-a-gradient-colored-line
  private void gradientLine(float x1, float y1, float x2, float y2, color a, color b) {
    
    float deltaX = x2-x1;
    float deltaY = y2-y1;
    float tStep = 1.0/dist(x1, y1, x2, y2);
    for (float t = 0.0; t < 1.0; t += tStep) {
      stroke(lerpColor(a, b, t));
      ellipse(x1+t*deltaX,  y1+t*deltaY, 1, 1);
    }
    
  }
  
  // Draw the wireframe version of Sierpinsky's Triangle
  private void drawWireFrameTri(PVector l, PVector t, PVector r) {
    
    noFill();
    strokeWeight(1);
    color c1 = colors.colMap.get("Golds").c1;
    color c2 = colors.colMap.get("Golds").c2;
    PVector leftV = mapper.windowToViewport(l.x, l.y);
    PVector topV = mapper.windowToViewport(t.x, t.y); 
    PVector rightV = mapper.windowToViewport(r.x, r.y);

    gradientLine(leftV.x, leftV.y, topV.x, topV.y, c1, c2);
    gradientLine(topV.x, topV.y, rightV.x, rightV.y, c1, c2);
    gradientLine(leftV.x, leftV.y, rightV.x, rightV.y, c1, c2);
    
  }
  
  // Draw a base triangle to appear behind the Sierpinsky triangle
  private void drawBaseTriangle(PVector left, PVector top, PVector right) {
    
      fill (2, 0, 158);
      triMapped (left, top, right); 
      
  }
  
  private void drawSierpinsky2D() {
    
    mapper.setWindow(-1.3, -1.3, 1.3, 1.3);
    if (!wireframe) 
      drawBaseTriangle(corners[0], corners[1], corners[2]);
    sierpinski2D (corners[0], corners[1], corners[2], 0);
    
  }
  
  // ------------------------------------------------Sierpinsky Arrowhead Curve--------------------------------------------------------
  
  // Resets the variables used for the arrowhead curve 
  private void resetArrowheadVars() {
    
    startPoint = corners[0];
    turnAngle = 0;
    
  }
  
  private void initializeArrowhead() {
    
    resetArrowheadVars();
    mapper.setWindow(-1.5, -1.5, 2.5, 2.0);
    stroke (colors.colMap.get("Reds").c1);
    noFill();
    
  }
  
  // The Sierpiński arrowhead curve is a fractal curve similar in appearance and identical in limit to the Sierpiński triangle.
  // The Sierpiński arrowhead curve draws an equilateral triangle with triangular holes at equal intervals. It can be described
  // with two substituting production rules: (A → B-A-B) and (B → A+B+A). A and B recur and at the bottom do the same thing — 
  // draw a line. Plus and minus (+ and -) mean turn 60 degrees either left or right. 
  // https://en.wikipedia.org/wiki/Sierpi%C5%84ski_arrowhead_curve
  private void arrowHeadCurve(int order, double length) { //<>//
    initializeArrowhead();

    beginShape();
    
    vertexMapped(startPoint);
    
    if (0 == order % 2)
      curve (order, length, -60);
    else { // order is odd
      turn(60);
      curve (order, length, -60);
    }
    
    endShape();
  }
  
  int turnAngle = 0;
  private void turn (int angle) {
    turnAngle += angle;
  }
  
  // Add a new vertex to the shape
  private void drawLine (double length) {
    float t = radians(turnAngle);
    PVector endPoint = new PVector ((float)(startPoint.x + length * cos(t)), (float)(startPoint.y + length * sin(t)));
    startPoint = endPoint;
    
    vertexMapped(startPoint);
  }
  
  private void curve(int order, double length, int angle) {
    
    if (order == 0) {
      drawLine(length);
    } else {
      curve (order - 1, length/2, -angle);
      turn (+angle);
      curve (order - 1, length/2, angle);
      turn (+angle);
      curve (order - 1, length/2, -angle);
    }
    
  }
  
  // --------------------------------------------------------------------------------------------
  
  
  void draw() {
    background (140, 164, 165);

    if (arrowhead) arrowHeadCurve(maxDepth, curveLength);
    else drawSierpinsky2D();

  }
}