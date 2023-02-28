class Circle{
  float x;
  float y;
  float r;
  boolean growing = true;
  
  //constructor
  Circle(float X, float Y){
    x = X;
    y = Y;
    r = pen_size;
    //if r < pensize visual glitches happen so start at minimum
  }
  

  
  void grow(){  
    if(growing){
      r++;
    }
  }
  
  void show(){
    stroke(255);
    noFill();
    ellipse(x,y,r*2,r*2);
  }
  
  
  
}
