Grid grid;
ArrayList<FlowObject> objects = new ArrayList<FlowObject>();


// Goal node is 0, 0
int goalx;
int goaly;

int XSize = 25;
int YSize = 25;
int scale = 40;
boolean editable = true;
boolean timeFlows = false;

void setup(){
  frameRate(60);
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
     if (!editable){
       grid.MakeBoard();
       grid.CalculateIntegrationField(goalx, goaly);
     }
   }
   if (key == 'r'){
     int size = objects.size();
     println("replaced " + objects.size() + " objects");
     objects.clear();
     while (objects.size() < size){
       int x = (int)random(999);
       int y = (int)random(999);
       if (grid.GetIFValue(x/scale, y/scale) < Integer.MAX_VALUE){
         objects.add(new FlowObject(x, y));
        }
      }
   }
   if (key == '+' || key == '='){
     int size = objects.size() + 1000;
     while (objects.size() < size){
      int x = (int)random(999);
      int y = (int)random(999);
      if (grid.GetIFValue(x/scale, y/scale) < Integer.MAX_VALUE){
        objects.add(new FlowObject(x, y));
      }
    }
  }
  if (key == '-' || key == '_'){
    if (objects.size() >= 1000){
      for (int i = 0; i<1000; i++){
        objects.remove(objects.size()-1);
      }
    }
    
  }
  if (key == TAB){
    timeFlows = !timeFlows;
  } 
  if (key == 'c'){
    println("removed " + objects.size() + " objects");
    objects.clear();
  }
}
      
void draw(){  
  if (editable){
    if (mousePressed == true){
      if (mouseButton == LEFT){
        if (grid.GetCellCost(mouseX/scale, mouseY/scale) < Integer.MAX_VALUE){
          grid.Addwall(mouseX/scale, mouseY/scale);
          grid.CalculateIntegrationField(goalx, goaly);
        }
  
      }
      if (mouseButton == RIGHT){
        
        if (grid.GetCellCost(mouseX/scale, mouseY/scale) == Integer.MAX_VALUE){
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
  
  for (int x = 0; x<XSize; x++){
    for (int y = 0; y<YSize; y++){
      // Set the colour
      if (editable) {
        // if its a wall
        if (grid.GetIFValue(x, y) == Integer.MAX_VALUE){ 
          if (grid.GetCellCost(x, y) == Integer.MAX_VALUE){
              fill(50);
          }
          else {
            fill(100);
          }
        }
        //if its not a wall
        else {
          if (grid.GetIFValue(x, y) == 0){
            // if its the goal
            fill(255, 0, 0);
          }
          else{
            fill(grid.GetCellCost(x, y), 150, 150);
          }
        }
      }
      else {
        if (grid.GetIFValue(x, y) < Integer.MAX_VALUE){
        fill(0, 255 - 255*grid.GetIFValue(x, y)/maxIF, 255*grid.GetIFValue(x, y)/maxIF); 
        }
        else {
          if (grid.GetCellCost(x, y) == Integer.MAX_VALUE){
              fill(50);
          }
          else {
            fill(100);
          }
        }
      }
    

       
      // Draw the rectabgle
      rect(x*scale, y*scale, scale, scale); 
            fill(0);
      text(grid.GetIFValue(x, y), (x)*scale, y*scale+10);
    } 
  }
  
  // Draw the objects
  if (!editable){
    for (FlowObject fo : objects){
      if (timeFlows){
        fo.UpdatePosition(grid);
      }
      fill(0);
      rect(fo.X-2, fo.Y-2, 4, 4);  
    }
  }
}  
