class Grid{
  public GridPoint[][] _grid;
  private int[][] weightarray;
  
  private ArrayList<Integer> wall = new ArrayList<Integer>();
  
  int xSize = 25;
  int ySize = 25; 

  public Grid(){
    weightarray = new int[xSize][ySize];
    for (int x = 0; x< xSize; x++){
      for (int y = 0; y< ySize; y++){
        weightarray[x][y] = (int)random(255);
        
      }
    }
      
    MakeBoard();
  }
  
  public void MakeBoard(){
     // Setup Board
    _grid = new GridPoint[xSize][ySize];
    for (int x = 0; x<xSize; x++){
      for (int y = 0; y<ySize; y++){
        NewGridPoint(x, y, weightarray[x][y]);
      }
    }
    
    for (int index : wall){
       NewGridPoint(index%xSize, index/xSize, 255); 
    }
  }
  
  public void Addwall(int x, int y){
    wall.add(y*xSize + x);
    NewGridPoint(x, y, 255); 
  }
  
  public void Removewall(int x, int y){
    wall.remove(Integer.valueOf(y*xSize + x));
  }
    
  public void NewGridPoint(int x, int y, int c){
    _grid[x][y] = new GridPoint(x, y, c);
  }
  
  public int GetCellCost(int x, int y){
    return _grid[x][y].Cost;
  }
  public void SetCellCost(int x, int y, int c){
    _grid[x][y].Cost = c;
  }
  public int GetIFValue(int x, int y){
    return _grid[x][y].IFValue;
  }
  public void SetIFValue(int x, int y, int i){
    _grid[x][y].IFValue = i;
  }
  
  public void CalculateIntegrationField(int targetx, int targety){
    int targetID = targety * xSize + targetx;
  
    ArrayList<Integer> openlist = new ArrayList<Integer>();
    
    SetIFValue(targetx, targety, 0);
    openlist.add(0, targetID);

      
    while (openlist.size() > 0){
      
      int currentID = openlist.get(0);
      
      openlist.remove(0);
      
      
      int currentx = currentID % xSize;
      int currenty = currentID / xSize;
      
      ArrayList<Integer> neighbors = GetNeighbors(currentx, currenty);
      
      for (int i = 0; i<neighbors.size(); i++){
        int cost = GetIFValue(currentx, currenty) + GetCellCost(currentx, currenty);
        
        if (cost < GetIFValue(neighbors.get(i) % xSize, neighbors.get(i) / xSize)){
          if (!openlist.contains(neighbors.get(i))){
            openlist.add(0, neighbors.get(i));
          }
          SetIFValue(neighbors.get(i)%xSize, neighbors.get(i)/xSize, cost);
        }
      }
      

    } 
  }
  
  private ArrayList<Integer> GetNeighbors(int x, int y){
    ArrayList<Integer> ret = new ArrayList<Integer>();
    
    if (x-1 < xSize && x-1 >= 0 && GetCellCost(x-1, y) < 255){
      ret.add(y*xSize + x -1);
    }
    if (y-1 < ySize && y-1 >=0 && GetCellCost(x, y-1) < 255){
      ret.add((y-1)*xSize + x);
    }
    if (x+1 < xSize && x+1 >= 0 && GetCellCost(x+1, y) < 255){
      ret.add(y*xSize + x + 1);
    }
        if (y+1 < ySize && y+1 >=0 && GetCellCost(x, y+1) < 255){
      ret.add((y+1)*xSize + x);
    }
    
    
    return ret;
  }
  
  public int GetHighestIFValue(){
    int h = 0;
    for (GridPoint[] r : _grid){
      for (GridPoint p : r){
        if (!(p.IFValue == 100000)){
          h = max(h, p.IFValue);
        }
      }
    }
    return h;
  }
}
