import processing.sound.*;

SoundFile file;
SoundFile ex_file;
SoundFile bg;
SoundFile life;
SoundFile gameover;
SoundFile win;

PImage sound;
PImage nosound;

Timer t;
Ship spcship;

int frequency = 4;
int enemy_freq;
int killCount;
int HP = 10;
int x = 0;
int sX = 730, sY = 20;
int nsX = 880, nsY = 20;

ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<Lazer> lazers = new ArrayList<Lazer>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

boolean isPlayerHit = false;
boolean Musc_play = true;
boolean Musc_pause = false;

float[] shipPos = new float[2];
boolean startingScreen = true;
char option = '0';

Table scores;
boolean update = true;


  void setup() {
    size(960, 540);
    background(0);
    
    
    
    // Create a timer for 1 min
    t = new Timer(60000);
    
   
    
    spcship = new Ship(t.timeRemaining);
    file = new SoundFile(this, "lazer.mp3", false);
    ex_file = new SoundFile(this,"explosion.mp3", false);
    bg = new SoundFile(this, "background.wav", false);
    life = new SoundFile(this, "life.wav", false);
    gameover = new SoundFile(this, "gameover.mp3",false);
    win = new SoundFile(this, "win.mp3");
    
    sound = loadImage("Sound.png");
    nosound = loadImage("no.png");
    sound.resize(50,40);
    nosound.resize(50,40);
    
    float[] shipPos = spcship.ship_pos();
  
    scores = loadTable("scores.csv", "header");
    
    killCount = 0;
    bg.loop();
    
    

}

  void draw() {
    background(0);
    
    image(sound, sX, sY);
    image(nosound, nsX, nsY);
    
    if(startingScreen){
      if(keyPressed) {
        if(key == '0' | key == '1' | key == '2' | key == '3' | key == 'r'){
          option = key;
        }
      }
      
      if (option == '0' | option == 'r'){
        textSize(50);
        text("Space Shooter", 325, 125);
        textSize(35);
        text("A game by Princess Owotade and Joyce Wang", 100, 200);
        textSize(30);
        text("Press 1 to start a new game (EASY)", 100, 350);
        text("Press 2 to start a new game (HARD)", 100, 400);
        text("Press 3 to view top scores", 100, 450);
      }
      else if (option == '1') {
        enemy_freq = 60;
        startingScreen = false;
        bg.stop();
      }
      else if (option == '2') {
        enemy_freq = 20;
        startingScreen = false;
        bg.stop();
      }
      else if (option == '3') {
        textSize(30);
        text("Rank", 100, 100);
        text("Score", 400, 100);
        int y = 150;
        for (TableRow row : scores.rows()) {
          text(row.getInt("Rank"), 100, y);
          text(row.getInt("Score"), 400, y);
          y += 50;
        }
        text("Press 0 to return to the main screen", 100, 450);
      }
    }
    else {
      spcship.keypresses();
      
      
  
      if (frameCount % frequency == 0) {
        Star myStar = new Star();
        stars.add(myStar);
      }
      for (int i = 0; i<stars.size(); i++) {
        Star currentStar = stars.get(i);
        currentStar.display();
      }
    
      if(t.timeRemaining >= 0 && HP >= 1) {
        t.update();
        t.display();
        
        String string = "Lives Left: "+HP;
        text(string, 10, 80);
        text("Score: " + killCount, 10, 120);
      
        if(t.isPaused) {
          
          textSize(40);
          text("Press the space bar to start or pause the game", 25, 275);
        }
        else { //if timer is not paused    
      
          spcship.play(t.timeRemaining, isPlayerHit);
          spcship.display();
          
          displayEnemies();
          
          drawLazer();
          
          checkHit();
          
          MoveEnemies();
        
        }
      }
    
   
      else if ((t.timeRemaining == 0 && HP == 0)||(t.timeRemaining > 0 && HP == 0)){
        x++;
        bg.stop();
        
        textSize(50);
        text("You Lose! Score: " + killCount, 200, 280);
        textSize(30);
        text("Press r to restart the game", 100, 450);
        if(update) {
          updateTable();
          update = false;
        }
        
        if(Musc_play && x == 1){
        gameover.amp(1.0);
        gameover.play();
      }
        
      }
       else {
        x++;
        bg.stop();
        
        textSize(50);
        text("You Win! Score: " + killCount, 200, 280);
        textSize(30);
        text("Press r to restart the game", 100, 450);
        if(update) {
          updateTable();
          update = false;
        }
        
        if(Musc_play && x == 1){
        win.amp(1.0);
        win.play();
      }
        
      }
    }
    if(Musc_pause && file.isPlaying() && bg.isPlaying() && life.isPlaying() && gameover.isPlaying() && win.isPlaying() && ex_file.isPlaying()){
      
      file.pause();
      bg.pause();
      life.pause();
      gameover.pause();
      win.pause();
      ex_file.pause();
    }
  }

  void drawLazer(){
    for (int i = 0; i<lazers.size(); i++){
    
      lazers.get(i).displayLazer();
  
    }

  }

  void checkHit(){
  
    for(int e = 0; e < enemies.size(); e++){
    
      Enemy x = enemies.get(e);
      
      if(x.checkColl(spcship) == true){
      
        fill(255, 0, 0, 100);
        rect(0, 0, width, height);
        fill(255);
        
        HP--;
        if(Musc_play){
          life.play();
        }
        enemies.remove(e);
        
        isPlayerHit = true;
      }
    
      else{isPlayerHit = false;}
  
      for( int l = 0; l <lazers.size(); l++){
   
      Lazer lazer = lazers.get(l);
    
      if(x.checkColl(lazer) == true){
      
        fill(0, 255, 0, 100);
        rect(0, 0, width, height);
        fill(255);
        
        if(Musc_play){
          ex_file.play();
        }
        
        if(Musc_pause){
          ex_file.pause();
        
        }
        
        killCount++;
        lazers.remove(lazer);
        enemies.remove(e);
        
        l--;
        }
      }
    }
  
  
    spcship.play(t.timeRemaining,isPlayerHit);
    spcship.display();
  
    if(spcship.alive == false){
       isPlayerHit = false;
    }

  }

  void displayEnemies(){
  
    if (frameCount % enemy_freq == 0){
    
      enemies.add(new Enemy());
    }
  
    for(int i = 0; i <enemies.size(); i++){
    
      Enemy curr_enemy = enemies.get(i);
      
      curr_enemy.display();
      
      if (curr_enemy.posY >= height-40){
      
        enemies.remove(curr_enemy);
        i--;
      }
  
    }

  }
  
  void MoveEnemies(){
    
    for(int e = 0; e < enemies.size(); e++){
    
      Enemy x = enemies.get(e);
      x.hunt(spcship);
    }
  
  
  }
  
  void reset(){
    HP = 10;
    x = 0;
    isPlayerHit = false;
    t = new Timer(60000);
    killCount = 0;
    stars.clear();
    enemies.clear();
    lazers.clear();
    spcship = new Ship(t.timeRemaining);
    bg.stop();
    startingScreen = true;
    option = '0';
    update = true;
    scores = loadTable("scores.csv", "header");
  }

  void keyPressed() {
    if(key == ' ') {
      if(t.isPaused) {
        
        t.resume();
        if(startingScreen == false) {
          bg.loop();
        }
      }
      else {
        
        t.pause();
        bg.pause();
      
      }
    }
    if(keyCode == SHIFT){
      if(startingScreen == false) {
        shipPos = spcship.ship_pos();
        
        Lazer myLazer = new Lazer(shipPos[0], shipPos[1]);
        lazers.add(myLazer);
        
        if(Musc_play){
          file.play();
        }
      }
  
    }
    
    if(key == 'r'){
    
      reset();
          
    }
  }
  
  void mousePressed(){
  
    
    if( mouseX > sX && mouseX < (sX + sound.width) &&
      mouseY > sY && mouseY < (sY + sound.height)){
       Musc_play = true;
       Musc_pause = false;
      };
    
    if( mouseX > nsX && mouseX < (nsX + nosound.width) &&
      mouseY > nsY && mouseY < (nsY + nosound.height)){
       Musc_play = false;
       Musc_pause = true;
      };
      
 
    
    if(!bg.isPlaying() && Musc_play){
      bg.loop();
    }

  if(Musc_pause){
     bg.pause();}
  }
  
  
  void updateTable() {
    TableRow newRow = scores.addRow();
    newRow.setInt("Score", killCount);
    
    scores.setColumnType("Score", Table.INT);
    scores.sortReverse(1);
    scores.removeRow(5);
    
    int rank = 1;
    for(TableRow row : scores.rows()) {
      row.setInt("Rank", rank);
      rank++;
    }
    saveTable(scores, "data/scores.csv");
  }
