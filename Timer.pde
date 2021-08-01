class Timer {
  
  // Time passed since creating the object
  int time;
  // Length of the timer
  int interval;
  // If the timer is active
  boolean isActive;
  // If the timer is paused
  boolean isPaused;
  // Time passed since creating the object minus the time it is paused
  int timeElapsed;
  // Remaining time of the timer
  int timeRemaining;
  
  Timer(int _interval) {
    time = millis();
    interval = _interval;
    timeRemaining = _interval;
    // The timer does not start automatically
    isActive = false;
    isPaused = true;
    timeElapsed = 0;
  }
  
  // Pause the timer
  void pause() {
    isActive = false;
    isPaused = true;
  }
  
  // Resume the timer
  void resume() {
    isActive = true;
    isPaused = false;
    time = millis() - timeElapsed;
  }
  
  // Update info
  void update() {
    if(!isPaused) {
      timeElapsed = millis() - time;
    }
    else {
      time = millis();
    }
    timeRemaining = interval - timeElapsed;
  }
  
  // Display the remaining time
  void display() {
    // Calculate remaining min and sec
    int min = timeRemaining / 60000;
    int sec = (timeRemaining % 60000) / 1000;
    
    // Convert remaining min and sec to a string and display it
    String str = "";
    if(min < 10) {
       str += "0" + min + ":";
    }
    else {
      str += min + ":";
    }
    if(sec < 10) {
      str += "0" + sec;
    }
    else {
      str += sec;
    }
    textSize(30);
    text(str, 10, 40);
  }
}
