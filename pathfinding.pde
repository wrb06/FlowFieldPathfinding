Grid grid;
ArrayList<FlowObject> objects = new ArrayList<FlowObject>();


// Goal node is 0, 0
int goalx;
int goaly;

int xSize = 25;
int ySize = 25;
int scale = 40;
boolean editable = true;

void setup(){
  frameRate(40);
  size(1000, 1000);
  noStroke();
  textSize(10);
  
  grid = new Grid(); 
  
  // Calculate Integration Field
  grid.CalculateIntegrationField(0, 0);
}

void keyPressed(){
   if (key == 'q'){
     editable = !editable;
   }
   if (key == 'r'){
     objects.clear();
     while(objects.size() < 5000){
      int x = (int)random(999);
      int y = (int)random(999);
      if (grid.GetIFValue(x/scale, y/scale) < 10000){
        objects.add(new FlowObject(x, y));
      }
    }
  }
}
      
void draw(){  
  if (editable){
    if (mousePressed == true){
      if (mouseButton == LEFT){
        if (grid.GetCellCost(mouseX/scale, mouseY/scale) < 255){
          grid.Addwall(mouseX/scale, mouseY/scale);
          grid.CalculateIntegrationField(goalx, goaly);
        }
  
      }
      if (mouseButton == RIGHT){
        
        if (grid.GetCellCost(mouseX/scale, mouseY/scale) >= 255){
          grid.Removewall(mouseX/scale, mouseY/scale);
          grid.MakeBoard();
          grid.CalculateIntegrationField(goalx, goaly);
          
        }
      } 
    }
  } else {
    if (mousePressed == true){
      if (mouseButton == LEFT){
        goalx = mouseX/scale;
        goaly = mouseY/scale;
        grid.MakeBoard();
        grid.CalculateIntegrationField(mouseX/scale, mouseY/scale);
      }
    }
  }
    
    
  
  int maxIF = grid.GetHighestIFValue();
  
  for (int x = 0; x<xSize; x++){
    for (int y = 0; y<ySize; y++){
      // Set the colour
      if (editable) {
        if (grid.GetIFValue(x, y) < 10000){
          fill(grid.GetCellCost(x, y), 150, 150);
        }
        else {
          fill(0);
        }
      } else {
        if (grid.GetIFValue(x, y) < 10000){
        fill(0, 255 - 255*grid.GetIFValue(x, y)/maxIF, 255*grid.GetIFValue(x, y)/maxIF); 
        }
        else {
          if (grid.GetCellCost(x, y) == 255){
              fill(50);
          }
          else {
            fill(100);
          }
        }
      }

       
      // Draw the rectabgle
      rect(x*scale, y*scale, scale, scale);      
    }
  } 
  
  // Draw the objects
  for (FlowObject fo : objects){
    if (!editable){
      fo.UpdatePosition(grid);
    }
    fill(0);
    rect(fo.X-2, fo.Y-2, 4, 4);  
  }
}  
