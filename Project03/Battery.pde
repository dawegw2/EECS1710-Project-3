class Battery {
  PVector position;
  float battSize = 15;

  boolean collected = false;
  boolean collectable = false;

  Battery(float x, float y) {
    position = new PVector(x, y);
  }

  void update() {
    if (collected) {
      //shrinks size when collected
      if (battSize > 0) {
        battSize = battSize - 1;
      }
    }
  }

  void draw() {
    float d = dist(position.x, position.y, player.position.x, player.position.y);
    if (d < lightSize) {
      fill(169, 255, 0);
      ellipse(position.x, position.y, battSize, battSize);      
    }

    if (d < 25) {
      collectable = true;
      fill(255);
      textSize(25);
      text("Press z to use", width/2, height - 50);

      if (keyPressed) {
        if (key == 'z' || key == 'Z') {
          collected = true;
        }
      }
    } else {
      collectable = false;
    }
  }
  
  void run() {
    update();
    draw();
  }
}
