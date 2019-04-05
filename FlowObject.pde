class FlowObject{
  int X;
  int Y;
  float h = -10;
  PVector disp;
  PVector speed;
  PVector acc;
  
  public FlowObject(int x, int y){
    X = x;
    Y = y;
    disp = new PVector(x, y);
    speed = new PVector();
    acc = new PVector();
  }
  
  public void UpdatePosition(Grid g){
    X = (int)disp.x;
    Y = (int)disp.y;
           
    int currentx = X/scale;
    int currenty = Y/scale;
    
    // Object goes to the smallest weight
    int currentbestx = currentx;
    int currentbesty = currenty;
    int bestweight = 100000;

    
    //TODO: remake this
    
        //right
        // if its inside the board
        if (!(currentx+1 < 0 || currentx + 1 >= g.xSize || currenty + 0 < 0 || currenty + 0>= g.ySize)){
          //if its better than before
          if (g.GetIFValue(currentx + 1, currenty + 0) < bestweight){
             currentbestx = currentx + 1;
             currentbesty = currenty + 0;
             bestweight = g.GetIFValue(currentx + 1, currenty+0);
           }
        }
        
        //left
        // if its inside the board
        if (!(currentx-1 < 0 || currentx - 1 >= g.xSize || currenty - 0 < 0 || currenty - 0>= g.ySize)){
          //if its better than before
          if (g.GetIFValue(currentx - 1, currenty + 0) < bestweight){
             currentbestx = currentx - 1;
             currentbesty = currenty + 0;
             bestweight = g.GetIFValue(currentx - 1, currenty+0);
           }
        }
        
        //up
        // if its inside the board
        if (!(currentx+0 < 0 || currentx + 0 >= g.xSize || currenty + 1 < 0 || currenty +1>= g.ySize)){
          //if its better than before
          if (g.GetIFValue(currentx + 0, currenty + 1) < bestweight){
             currentbestx = currentx + 0;
             currentbesty = currenty + 1;
             bestweight = g.GetIFValue(currentx + 0, currenty+1);
           }
        }
        
        // down
        // if its inside the board
        if (!(currentx+0 < 0 || currentx + 0 >= g.xSize || currenty - 1 < 0 || currenty -1>= g.ySize)){
          //if its better than before
          if (g.GetIFValue(currentx + 0, currenty - 1) < bestweight){
             currentbestx = currentx + 0;
             currentbesty = currenty - 1;
             bestweight = g.GetIFValue(currentx + 0, currenty-1);
           }
        }
        
        // right up
        // if its inside the board
        if (!(currentx+1 < 0 || currentx + 1 >= g.xSize || currenty < 0 || currenty >= g.ySize) && !(currentx+0 < 0 || currentx + 0 >= g.xSize || currenty + 1 < 0 || currenty +1>= g.ySize)){
          if (g.GetIFValue(currentx + 1, currenty) < 10000 && g.GetIFValue(currentx, currenty + 1) < 10000) {
            if (!(currentx+1 < 0 || currentx + 1 >= g.xSize || currenty + 1 < 0 || currenty + 1>= g.ySize)){
              //if its better than before
              if (g.GetIFValue(currentx + 1, currenty + 1) < bestweight){
                 currentbestx = currentx + 1;
                 currentbesty = currenty + 1;
                 bestweight = g.GetIFValue(currentx + 1, currenty+1);
               }
            }
          }
        }
        // left up
        // if its inside the board
        if (!(currentx-1 < 0 || currentx - 1 >= g.xSize || currenty < 0 || currenty >= g.ySize) && !(currentx+0 < 0 || currentx + 0 >= g.xSize || currenty + 1 < 0 || currenty +1>= g.ySize)){
          if (g.GetIFValue(currentx - 1, currenty) < 10000 && g.GetIFValue(currentx, currenty + 1) < 10000) {
            if (!(currentx-1 < 0 || currentx - 1 >= g.xSize || currenty + 1 < 0 || currenty + 1>= g.ySize)){
              //if its better than before
              if (g.GetIFValue(currentx - 1, currenty + 1) < bestweight){
                 currentbestx = currentx - 1;
                 currentbesty = currenty + 1;
                 bestweight = g.GetIFValue(currentx - 1, currenty+1);
               }
            }
          }
        }
                // right down
        // if its inside the board
        if (!(currentx+1 < 0 || currentx + 1 >= g.xSize || currenty < 0 || currenty >= g.ySize) && !(currentx+0 < 0 || currentx + 0 >= g.xSize || currenty - 1 < 0 || currenty -1>= g.ySize)){
          if (g.GetIFValue(currentx + 1, currenty) < 10000 && g.GetIFValue(currentx, currenty - 1) < 10000) {
            if (!(currentx+1 < 0 || currentx + 1 >= g.xSize || currenty - 1 < 0 || currenty - 1>= g.ySize)){
              //if its better than before
              if (g.GetIFValue(currentx + 1, currenty - 1) < bestweight){
                 currentbestx = currentx + 1;
                 currentbesty = currenty - 1;
                 bestweight = g.GetIFValue(currentx + 1, currenty-1);
               }
            }
          }
        }
        // left down
        // if its inside the board
        if (!(currentx-1 < 0 || currentx - 1 >= g.xSize || currenty < 0 || currenty >= g.ySize) && !(currentx+0 < 0 || currentx + 0 >= g.xSize || currenty - 1 < 0 || currenty -1>= g.ySize)){
          if (g.GetIFValue(currentx - 1, currenty) < 10000 && g.GetIFValue(currentx, currenty - 1) < 10000) {
            if (!(currentx-1 < 0 || currentx - 1 >= g.xSize || currenty - 1 < 0 || currenty - 1>= g.ySize)){
              //if its better than before
              if (g.GetIFValue(currentx - 1, currenty - 1) < bestweight){
                 currentbestx = currentx - 1;
                 currentbesty = currenty - 1;
                 bestweight = g.GetIFValue(currentx - 1, currenty-1);
               }
            }
          }
        }
        
        
        
        

    
    acc = new PVector(map(currentbestx, currentx-1, currentx+1, -1, 1), map(currentbesty, currenty-1, currenty+1, -1, 1));
    acc.limit(0.1);
    
    speed.add(acc);
    speed.limit(2);
    
    int newx = (int)(disp.x + speed.x);
    int newy = (int)(disp.y + speed.y);
    
    if (newx >= 0 && newx < g.xSize*scale && newy >= 0 && newy < g.ySize*scale){
      if (g.GetIFValue(newx/scale, newy/scale) == Integer.MAX_VALUE){
        speed = new PVector();
      }
    }
    else{
      speed = new PVector();
    }
    disp.add(speed);
    
  }
}
  
