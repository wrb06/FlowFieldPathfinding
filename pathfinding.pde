Grid grid;
ArrayList<FlowObject> objects = new ArrayList<FlowObject>();


// Goal node is 0, 0
int goalx;
int goaly;

int XSize = 50;
int YSize = 50;
int scale = 20;

float rot = 0;
float yrot = -PI/5;
float zoom = 2;
int Size = 10;

boolean editable = true;
boolean timeFlows = false;
boolean View3d = false;

void setup(){
  frameRate(60);
  size(1000, 1000, P3D);
  
  noStroke();
  textSize(10);
  
  grid = new Grid(); 
  
  // Calculate Integration Field
  //grid.CalculateIntegrationField(0, 0);
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
  if (key == ENTER || key == RETURN){
    stroke(0);
    background(255);
    editable = false;
    View3d = !View3d;
    if (View3d){
      grid.CalculateIntegrationField(goalx, goaly);
        beginCamera();
        camera();
        translate(width/2, height/2);
        endCamera();
    }   
    else{
      camera();
      noStroke();
    }

  }
}

void mouseWheel(MouseEvent e){
  zoom += e.getCount()/100.0;
} 

void draw(){  
  if (!View3d){
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
  }
  else{
    if (keyPressed){
      if (key == 'a'){
        rot+=0.01;
      } else if (key =='d') {
        rot-=0.01;
      }
      
      if (key == 'w'){
        yrot-=0.01;
      } else if (key== 's') {
        yrot+=0.01;
      }  
    }
  }

  if (View3d){
    background(255);
    scale(zoom);
    rotateX(yrot);
    rotateY(rot);
    
    translate(-Size*XSize/2, 100, -Size*YSize/2);
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
            fill(255*grid.GetCellCost(x, y)/100, 255, 255);
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
    

      if (!View3d){
        // Draw the rectabgle
        rect(x*scale, y*scale, scale, scale); 
        fill(0);
        if (editable){
          text(grid.GetCellCost(x, y), x*scale, y*scale+10); 
        }
        else{
          text(grid.GetIFValue(x, y), (x)*scale, y*scale+10);
        }
        
      } else {
        float h;
          if (!editable){
            h = grid.GetIFValue(x, y);
                      
            if (h==Integer.MAX_VALUE) {
              h = 0;
            } else {
              h = h*100.0/maxIF;
            }
          }
          else
          {
            h = grid.GetCellCost(x, y); 
            if (h==Integer.MAX_VALUE) {
              h = 0;
            }
          }

            

          translate(x*Size, -h, y*Size);
          box(Size, 2*h, Size);
          translate(-x*Size, h,-y*Size);
      }
    } 
  }
  
      // Draw the objects
    if (!editable){
      if (!View3d){
        for (FlowObject fo : objects){
          if (timeFlows){
            fo.UpdatePosition(grid);
          }
          fill(0);
          rect(fo.X-2, fo.Y-2, 4, 4);  
        }
      } else {
        strokeWeight(3);
        for (FlowObject fo : objects){
          if (timeFlows){
            fo.UpdatePosition(grid);
            
            fo.h = max(grid.GetIFValue(fo.X/scale, fo.Y/scale)* 200.0 /maxIF, fo.h-1);
          }
          fill(0);
          
          point((fo.disp.x / scale - 0.5 )* Size, -fo.h-1, (fo.disp.y / scale - 0.5 ) * Size);
        }
      strokeWeight(1);
      }
    }
  }
