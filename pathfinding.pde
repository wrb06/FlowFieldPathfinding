Grid grid;
ArrayList<FlowObject> objects = new ArrayList<FlowObject>();


// Goal node is 0, 0
int goalx;
int goaly;
int xSize = 20;
int ySize = 15;
int scale = 40;
boolean editable = true;

void setup(){
  frameRate(40);
  size(800, 600);
  noStroke();
  textSize(10);
  
  grid = new Grid(); 
  
  for (int i = 0; i< 100; i++){
    objects.add(new FlowObject((int)random(799), (int)random(599)));
  }
  
  // Calculate Integration Field
  grid.CalculateIntegrationField(0, 0);
}

void keyPressed(){
   if (key == 'q'){
     editable = !editable;
   }
}
      
void draw(){  
  if (editable){
    if (mousePressed == true){
      if (mouseButton == LEFT){
        if (grid.GetCellCost(mouseX/scale, mouseY/scale) < 255){
          grid.Addwall(mouseX/scale, mouseY/scale);
          grid.MakeBoard();
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
      if (grid.GetIFValue(x, y) < 255){
        fill(0, 255 - 255*grid.GetIFValue(x, y)/maxIF, 0); 
      }
      else {
        fill(100, 100, 100);
      }
       
      // Draw the rectabgle
      rect(x*scale, y*scale, scale, scale);
      
      // Draw the text
      //fill(0);
      //text(grid.GetCellCost(x, y), (x)*scale, (y)*scale+10);
      //text(grid.GetIFValue(x, y), (x)*scale + 35, (y)*scale + 10);
      
    }
  } 
  
  // Draw the objects
  for (FlowObject fo : objects){
    fo.UpdatePosition(grid);
    fill(0);
    rect(fo.X-2, fo.Y-2, 4, 4);  
  }
}  
