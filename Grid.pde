class Grid{
  public GridPoint[][] _grid;
  
  int xSize = 8;
  int ySize = 6;

  public Grid(){
    // Setup Board
    _grid = new GridPoint[xSize][ySize];
    for (int x = 0; x<xSize; x++){
      for (int y = 0; y<ySize; y++){
        NewGridPoint(x, y, 1);
      }
    }
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
      
      int currentx = currentID % 8;
      int currenty = currentID / 8;
      
      ArrayList<Integer> neighbors = new ArrayList<Integer>();
      

    }
   

    
    
  }
}
