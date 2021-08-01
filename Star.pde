class Star {

  float x, y;
  int vy;
  
  Star() { //CONSTRUCTOR
    this.x = random(width);
    this.y = 0;
    this.vy = 5; //velocity of falling star
  }
  
  void display() {
    y+=vy;
    strokeWeight(5);
    stroke(255);
    point(x,y);
    
  }
}
