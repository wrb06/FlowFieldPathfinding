int[][] WeightGrid = new int[80][60];
int playerx = 40;
int playery = 30;

void setup(){
  size(800, 600);
  noStroke();
  
  // Setup Board
  int count = 0;
  for (int x = 0; x<80; x++){
    for (int y = 0; y<60; y++){
      WeightGrid[x][y] = count++;
    }
  }
}

void draw(){  
  
  for (int x = 0; x<80; x++){
    for (int y = 0; y<60; y++){
      fill(WeightGrid[x][y] *255 / 4800); 
      rect(x*10, y*10, 10, 10);
    }
  }
      
  fill(255, 255, 0);
  rect(playerx*10, playery*10, 10, 10);
  
  //PlayerUpdate();
}  

void PlayerUpdate(){
  // Player goes to the smallest weight
  int currentbestx = -1;
  int currentbesty = -1;
  int bestweight = 1000000;

  for (int x  = -1; x<=1; x++){
    for (int y = -1; y<=1; y++){
      if (!(playerx+x < 0 || playerx + x >= 80 || playery+y < 0 || playery+y >= 60)){
        if (WeightGrid[playerx + x][playery+y] < bestweight){
          currentbestx = playerx + x;
          currentbesty = playery + y;
          bestweight = WeightGrid[playerx + x][playery+y];
        }
      }
    }
  }
  playerx = currentbestx;
  playery = currentbesty;
}
