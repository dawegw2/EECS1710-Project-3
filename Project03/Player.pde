class Player {
  PVector position, target;
  color col;
  float speed;
  float playerSize;
  boolean ready;
  boolean escaped = false;

  Player(float x, float y, color _col, PVector _target) {
    position = new PVector(x, y);
    col = _col;
    target = _target;
    speed = 0.1;
    playerSize = 20;
    ready = false;
  }

  void update() {
    position.lerp(target, speed);
    ready = position.dist(target) < 5;

    if (hitWall) {
      player.col = color(0, 127, 255);
    } else {
      player.col = color(255, 0, 0);
    }
  }

  void draw() {
    ellipseMode(CENTER);
    noStroke();
    fill(col);
    //flashlight();
    ellipse(position.x, position.y, playerSize, playerSize);
  }


  void checkWin() {
    if (position.y > 775 && !hitWall) {
      escaped = true;
      if (numKeysCollected < 3) {
        int keysLeft = keys.size() - 2;
        textSize(25);
        text("Looks like you need " + keysLeft + " more key(s) to escape", width/2, height/2);
      } 
      //println("You Win");
    } else {
      escaped = false; 
      //println("You Lose");
    }
  }

  void run() {
    update();
    draw();
    checkWin();
  }
}
