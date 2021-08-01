class Enemy {
  
  PImage img = loadImage("enemy.png");
  PImage trail = loadImage("enemy.trail.png");
  
  float posX;
  float posY;
  int offset = 0;
  
  int direction = 3;
  
  int signum(float value) {
  return value < 0 ? -1 : value > 0 ? 1 : 0;
  }
  
  
  Enemy(){
    // Randomly generate x-position between 80 and 800
    this.posX = (float) Math.random() * 720 + 80;
    //this.posY;
    
    
  }
  

  boolean checkColl(Object other){
    if (other instanceof Lazer){
      
      Lazer lazer = (Lazer) other;
      float distance = dist(posX, posY, lazer.x, lazer.y);
      
      if (distance <= 80){
        //isAlive = false;
        
        return true;
      
      } 
    }
    else if(other instanceof Ship){
      
      Ship spcship = (Ship) other;
      float distance = dist(posX, posY, spcship.posx, spcship.posy);
      //println(distance+","+check);
      if (distance < 80){
        
        
        return true;
      }
    }
    
    
    return false;
  
  }
  
  void hunt(Object other){
    Ship spcship = (Ship) other;
    int dx = signum(spcship.posx - posX);
    int dy = signum(spcship.posy - posY);
    posX += dx;
    posY += dy;
  
  }
  
  
  void display() {
    
    image(trail, posX, posY - offset, 80, 80);
    image(img, posX, posY, 80, 80);
    //posY += 5;
    offset += 2;
    
    if(offset > 20){
      offset = 0;
    }
    
    
   
  }
}
