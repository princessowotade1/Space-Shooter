class Lazer{
  
  float x,y,vy;
  float size;
  
  
  
  Lazer(float shipx, float shipy ){
    
    this.x = shipx+40;
    this.y = shipy;
    this.vy = -8;
    this.size = 5;
  
  }
  
  void displayLazer(){
    
    fill(255, 0, 0);
    ellipse(x, y, size, size);
    y += vy;
    fill(255);
  
  }
  
}
