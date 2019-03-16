class FlowObject{
  int X;
  int Y;
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
    //print(currentx, currenty);
    
    // Object goes to the smallest weight
    int currentbestx = currentx;
    int currentbesty = currenty;
    int bestweight = 100000;

    
    //TODO: remake this
    
        //right
        // if its inside the board
        if (!(currentx+1 < 0 || currentx + 1 >= g.xSize || currenty + 0 < 0 || currenty + 0>= g.ySize)){
          //if its better than before
          if (grid.GetIFValue(currentx + 1, currenty + 0) < bestweight){
             currentbestx = currentx + 1;
             currentbesty = currenty + 0;
             bestweight = grid.GetIFValue(currentx + 1, currenty+0);
           }
        }
        
        //left
        // if its inside the board
        if (!(currentx-1 < 0 || currentx - 1 >= g.xSize || currenty - 0 < 0 || currenty - 0>= g.ySize)){
          //if its better than before
          if (grid.GetIFValue(currentx - 1, currenty + 0) < bestweight){
             currentbestx = currentx - 1;
             currentbesty = currenty + 0;
             bestweight = grid.GetIFValue(currentx - 1, currenty+0);
           }
        }
        
        //up
        // if its inside the board
        if (!(currentx+0 < 0 || currentx + 0 >= g.xSize || currenty + 1 < 0 || currenty +1>= g.ySize)){
          //if its better than before
          if (grid.GetIFValue(currentx + 0, currenty + 1) < bestweight){
             currentbestx = currentx + 0;
             currentbesty = currenty + 1;
             bestweight = grid.GetIFValue(currentx + 0, currenty+1);
           }
        }
        
        // down
        // if its inside the board
        if (!(currentx+0 < 0 || currentx + 0 >= g.xSize || currenty - 1 < 0 || currenty -1>= g.ySize)){
          //if its better than before
          if (grid.GetIFValue(currentx + 0, currenty - 1) < bestweight){
             currentbestx = currentx + 0;
             currentbesty = currenty - 1;
             bestweight = grid.GetIFValue(currentx + 0, currenty-1);
           }
        }
        
        // right up
        // if its inside the board
        if (!(currentx+1 < 0 || currentx + 1 >= g.xSize || currenty < 0 || currenty >= g.ySize) && !(currentx+0 < 0 || currentx + 0 >= g.xSize || currenty + 1 < 0 || currenty +1>= g.ySize)){
          if (grid.GetIFValue(currentx + 1, currenty) < 10000 && grid.GetIFValue(currentx, currenty + 1) < 10000) {
            if (!(currentx+1 < 0 || currentx + 1 >= g.xSize || currenty + 1 < 0 || currenty + 1>= g.ySize)){
              //if its better than before
              if (grid.GetIFValue(currentx + 1, currenty + 1) < bestweight){
                 currentbestx = currentx + 1;
                 currentbesty = currenty + 1;
                 bestweight = grid.GetIFValue(currentx + 1, currenty+1);
               }
            }
          }
        }
        // left up
        // if its inside the board
        if (!(currentx-1 < 0 || currentx - 1 >= g.xSize || currenty < 0 || currenty >= g.ySize) && !(currentx+0 < 0 || currentx + 0 >= g.xSize || currenty + 1 < 0 || currenty +1>= g.ySize)){
          if (grid.GetIFValue(currentx - 1, currenty) < 10000 && grid.GetIFValue(currentx, currenty + 1) < 10000) {
            if (!(currentx-1 < 0 || currentx - 1 >= g.xSize || currenty + 1 < 0 || currenty + 1>= g.ySize)){
              //if its better than before
              if (grid.GetIFValue(currentx - 1, currenty + 1) < bestweight){
                 currentbestx = currentx - 1;
                 currentbesty = currenty + 1;
                 bestweight = grid.GetIFValue(currentx - 1, currenty+1);
               }
            }
          }
        }
                // right down
        // if its inside the board
        if (!(currentx+1 < 0 || currentx + 1 >= g.xSize || currenty < 0 || currenty >= g.ySize) && !(currentx+0 < 0 || currentx + 0 >= g.xSize || currenty - 1 < 0 || currenty -1>= g.ySize)){
          if (grid.GetIFValue(currentx + 1, currenty) < 10000 && grid.GetIFValue(currentx, currenty - 1) < 10000) {
            if (!(currentx+1 < 0 || currentx + 1 >= g.xSize || currenty - 1 < 0 || currenty - 1>= g.ySize)){
              //if its better than before
              if (grid.GetIFValue(currentx + 1, currenty - 1) < bestweight){
                 currentbestx = currentx + 1;
                 currentbesty = currenty - 1;
                 bestweight = grid.GetIFValue(currentx + 1, currenty-1);
               }
            }
          }
        }
        // left down
        // if its inside the board
        if (!(currentx-1 < 0 || currentx - 1 >= g.xSize || currenty < 0 || currenty >= g.ySize) && !(currentx+0 < 0 || currentx + 0 >= g.xSize || currenty - 1 < 0 || currenty -1>= g.ySize)){
          if (grid.GetIFValue(currentx - 1, currenty) < 10000 && grid.GetIFValue(currentx, currenty - 1) < 10000) {
            if (!(currentx-1 < 0 || currentx - 1 >= g.xSize || currenty - 1 < 0 || currenty - 1>= g.ySize)){
              //if its better than before
              if (grid.GetIFValue(currentx - 1, currenty - 1) < bestweight){
                 currentbestx = currentx - 1;
                 currentbesty = currenty - 1;
                 bestweight = grid.GetIFValue(currentx - 1, currenty-1);
               }
            }
          }
        }
        
        
        
        

    
    acc = new PVector(map(currentbestx, currentx-1, currentx+1, -1, 1), map(currentbesty, currenty-1, currenty+1, -1, 1));
    acc.limit(1);
    
    speed.add(acc);
    speed.limit(10);
    disp.add(speed.copy().limit(2));
    
  }
}
  
