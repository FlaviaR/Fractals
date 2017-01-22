import java.util.HashMap;

// Keeps track of color combinations for gradients

public class ColorObj {
  
  color c1;
  color c2;
  
  ColorObj (color c1, color c2) {
    this.c1 = c1;
    this.c2 = c2;
  }
}

public class Colors {
  
  HashMap < String, ColorObj> colMap = new HashMap<String, ColorObj> ();
  
  public Colors() {
    color lBlue = color(66, 244, 244);
    color dBlue = color(0, 3, 117);
    ColorObj blue = new ColorObj(lBlue, dBlue);
    
    color lGold = color(237, 198, 59);
    color dGold = color(165, 132, 13);
    ColorObj gold = new ColorObj(lGold, dGold);
    
    color lPurple = color(198, 131, 234);
    color dPurple = color(100, 7, 150);
    ColorObj purple = new ColorObj(lPurple, dPurple);
    
    color lRed = color(224, 40, 40);
    color dRed = color(127, 2, 2);
    ColorObj red = new ColorObj(lRed, dRed);
    
    colMap.put("Blues", blue);
    colMap.put("Golds", gold);
    colMap.put("Purples", purple);
    colMap.put("Reds", red);
  }
  
}