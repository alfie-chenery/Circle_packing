int maxsize = 1000; //max radius of circle, smaller value will give better resolution
int pen_size = 1; //keep at 1
int force_new_each_frame = 5;
//larger number works faster with greater resolution
//smaler number generally allows for larger circles

ArrayList<Circle> circles;
ArrayList<PVector> spots;
PImage seed;

void setup(){
  fullScreen();
  strokeWeight(pen_size);
  circles = new ArrayList<Circle>();
  spots = new ArrayList<PVector>();
  seed = loadImage("seed.png");
  seed.resize(width,height);
  seed.loadPixels();
  for(int x=0; x<seed.width; x++){
    for(int y=0; y<seed.height; y++){
      int loc = x + y*seed.width;
      float bright = brightness(seed.pixels[loc]);
      if(bright >= 128){//more than 50% bright (closer to white than black)
         spots.add(new PVector(x,y));
      }
    }
  }
}

void draw(){
  background(0);
  
  //add new circles
  int count = 0;
  while(count < force_new_each_frame){
    int rand = int(random(spots.size()));
    PVector centre = spots.get(rand);
    float X = centre.x;
    float Y = centre.y;
    
    boolean valid = true;
    for(Circle c : circles){
      float d = dist(X,Y,c.x,c.y);
      if (d < c.r){
        valid = false;
        break;
      }
    }
    if(valid){
      circles.add(new Circle(X,Y));
      count++;
    }
  }

 
  
  //ckeck stop conditions
  for (Circle c : circles){
    if(c.growing){
      if(c.x+c.r>width-pen_size || c.x-c.r<pen_size || c.y+c.r>height-pen_size || c.y-c.r<pen_size){//check edge hit
        c.growing= false;
      }else if(c.r>=maxsize){
        c.growing = false;
      }else{
        for(Circle other : circles){
          if (c!=other){
            float d = dist(c.x,c.y,other.x,other.y);
            if (d-pen_size < c.r+other.r){
              c.growing = false;
              break;
            }
          }
        }
      }
    }
    
    //update circle
    c.show();
    c.grow();
  }
}
