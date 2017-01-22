// Maps world coordinates to screen coordinates
public class Mapper {
  
  float xv_min, yv_min, xv_max, yv_max; // screen coordinates
  float xw_min, yw_min, xw_max, yw_max; // world coordinates
  float scaleX, scaleY, translationX, translationY;
  
  Mapper (float xv_min, float yv_min, float xv_max, float yv_max,
                float xw_min, float yw_min, float xw_max, float yw_max) {
                  
    this.xv_min = xv_min;
    this.yv_min = yv_min;
    this.xv_max = xv_max;
    this.yv_max = yv_max;
    
    this.xw_min = xw_min;
    this.yw_min = yw_min;
    this.xw_max = xw_max;
    this.yw_max = yw_max;
    
    calcScale();
    calcTranslation();
    
  }
  
  // Change the predefined window
  void setWindow(float xw_min, float yw_min, float xw_max, float yw_max) {
    this.xw_min = xw_min;
    this.yw_min = yw_min;
    this.xw_max = xw_max;
    this.yw_max = yw_max;
    
    calcScale();
    calcTranslation();
  }
  
  void calcScale() {
    
    this.scaleX = (xv_max - xv_min) / (xw_max - xw_min);
    this.scaleY = (yv_max - yv_min) / (yw_max - yw_min);
    
  }
  
  void calcTranslation() {
    
    this.translationX = (xw_max * xv_min - xw_min * xv_max) / (xw_max - xw_min);
    this.translationY = (yw_max * yv_min -yw_min * yv_max) / (yw_max - yw_min);
    
  }
  
  PVector windowToViewport(float xw, float yw) {
    
    float x = scaleX * xw + translationX;
    float y = scaleY * yw + translationY;
    
    y = height - y; // Y grows downwards in processing
        
    return new PVector (x, y);
  }
  
}