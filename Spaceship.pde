class Ship {
PImage space_sh = loadImage("spaceship.png");
float posx;
float posy;

int time_left;
int previous_time;

boolean alive;
boolean isHit;

  Ship(int _time_left){
    
    this.posx = 460;
    this.posy = 450;
    
    alive = true;
    isHit = false;
    
    time_left = _time_left;
    previous_time = time_left;
  
  }
  
  void play(int _time_left, boolean _isHit){
  
    time_left = _time_left;
    isHit = _isHit;
    
    if (isHit){
      alive = false;
      
    if(!alive){
      
      int currentTime = time_left/1000;
      
      if((currentTime % 3 == 0) && (previous_time - currentTime >=3)){
        
        previous_time = currentTime;
        
        
        isHit = false;
        alive = true;
      
      }
    }
   }
      
      
    if (!isHit){
      alive = true;
      
        }
    }

  
  void keypresses(){
    
    if( keyPressed & keyCode == LEFT){
    
      posx -= 5;
      
      if (posx == 10){
      
        posx = 10; 
        posx += 5;
      }
    }
    if (keyPressed & keyCode == RIGHT){
        
      posx += 5;
      
      if (posx == 875){
        
        posx = 875;
        posx -= 5;
      
      }
    }
    
    if (keyPressed & keyCode == UP){
    
        posy -= 5;
        
        if (posy == 30){
        
          posy = 30;
          posy += 5;
        }
    }
    
    if (keyPressed & keyCode == DOWN){
      
      posy +=5;
      
      if (posy == 450){
         
        posy = 450;
        posy -=5;
      
      }
    }
  }
  
  void display(){
    
    if(alive == true){
      
      image(space_sh, posx, posy, 80, 80);
      
    
    } 
  
  }
  
  float[] ship_pos() {
    
    float[] pl_pos = new float[2];
    if( alive == true){
    
      pl_pos[0] = posx;
      pl_pos[1] = posy;
      
    }
    else{
      
      pl_pos[0] = 0;
      pl_pos[1] = 0;
    
    }
    return pl_pos;
  }

}
