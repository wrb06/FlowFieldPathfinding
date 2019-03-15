Grid grid;

// Goal node is 0, 0

int xSize = 8;
int ySize = 6;
int scale = 100;

int playerx = 4;
int playery = 3;

void setup(){
  frameRate(1);
  size(800, 600);
  noStroke();
  textSize(10);
  
  grid = new Grid();
  
  grid.NewGridPoint(1, 0, 255);
  grid.NewGridPoint(1, 1, 255);
  grid.NewGridPoint(1, 2, 255);
  grid.NewGridPoint(2, 4, 255);
  grid.NewGridPoint(2, 5, 255);
  
  
  // CalculateIntegrationField
  grid.CalculateIntegrationField(0, 0);
}
  
void draw(){  
  for (int x = 0; x<xSize; x++){
    for (int y = 0; y<ySize; y++){
      // Set the colour
      if (grid.GetCellCost(x, y)  < 255){
        fill(0, 255 - grid.GetCellCost(x, y), 0); 
      }
      else {
        fill(100, 100, 100);
      }
       
      // Draw the rectabgle
      rect(x*scale, y*scale, scale-10, scale-10);
      
      // Draw the text
      fill(0);
      text(grid.GetCellCost(x, y), (x)*scale, (y)*scale+10);
      text(grid.GetIFValue(x, y), (x)*scale + 40, (y)*scale + 10);
    }
  }
      
  fill(255, 255, 0);
  rect(playerx*scale +20, playery*scale + 20, scale-50, scale-50);
  
  //PlayerUpdate();
}  


void PlayerUpdate(){
  // Player goes to the smallest weight
  int currentbestx = playerx;
  int currentbesty = playery;
  int bestweight = grid.GetCellCost(playerx, playery);

  for (int x  = -1; x<=1; x++){
    for (int y = -1; y<=1; y++){
      if (!(playerx+x < 0 || playerx + x >= xSize || playery+y < 0 || playery+y >= ySize)){
        if (grid.GetCellCost(playerx + x, playery + y) < bestweight){
          currentbestx = playerx + x;
          currentbesty = playery + y;
          bestweight = grid.GetCellCost(playerx + x, playery + y);
        }
      }
    }
  }
  playerx = currentbestx;
  playery = currentbesty;
}
