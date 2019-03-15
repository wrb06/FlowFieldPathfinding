class FlowObject{
  int X;
  int Y;
  float speedx;
  float speedy;
  
  public FlowObject(int x, int y){
    X = x;
    Y = y;
  }
  
  public void UpdatePosition(Grid g){
    X += speedx;
    Y += speedy;
    int currentx = X/scale;
    int currenty = Y/scale;
    //print(currentx, currenty);
    
    // Object goes to the smallest weight
    int currentbestx = currentx;
    int currentbesty = currenty;
    int bestweight = 100000;
  

        // if its inside the board
        if (!(currentx+1 < 0 || currentx + 1 >= g.xSize || currenty + 0 < 0 || currenty + 0>= g.ySize)){
          //if its better than before
          if (grid.GetIFValue(currentx + 1, currenty + 0) < bestweight){
             currentbestx = currentx + 1;
             currentbesty = currenty + 0;
             bestweight = grid.GetIFValue(currentx + 1, currenty+0);
           }
        }
        
        // if its inside the board
        if (!(currentx-1 < 0 || currentx - 1 >= g.xSize || currenty - 0 < 0 || currenty - 0>= g.ySize)){
          //if its better than before
          if (grid.GetIFValue(currentx - 1, currenty + 0) < bestweight){
             currentbestx = currentx - 1;
             currentbesty = currenty + 0;
             bestweight = grid.GetIFValue(currentx - 1, currenty+0);
           }
        }
        
        // if its inside the board
        if (!(currentx+0 < 0 || currentx + 0 >= g.xSize || currenty + 1 < 0 || currenty +1>= g.ySize)){
          //if its better than before
          if (grid.GetIFValue(currentx + 0, currenty + 1) < bestweight){
             currentbestx = currentx + 0;
             currentbesty = currenty + 1;
             bestweight = grid.GetIFValue(currentx + 0, currenty+1);
           }
        }
        
        // if its inside the board
        if (!(currentx+0 < 0 || currentx + 0 >= g.xSize || currenty - 1 < 0 || currenty -1>= g.ySize)){
          //if its better than before
          if (grid.GetIFValue(currentx + 0, currenty - 1) < bestweight){
             currentbestx = currentx + 0;
             currentbesty = currenty - 1;
             bestweight = grid.GetIFValue(currentx + 0, currenty-1);
           }
        }

    
    if (!(map(currentbestx, currentx-1, currentx+1, -1, 1) == 0 && map(currentbesty, currenty-1, currenty+1, -1, 1) == 0)){
      speedx = map(currentbestx, currentx-1, currentx+1, -2, 2);
      speedy = map(currentbesty, currenty-1, currenty+1, -2, 2);
    }
  }
}
  
