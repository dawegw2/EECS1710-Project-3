class Battery {

  PVector position;
  float battSize = 15;

  float lightX = 75;
  float lightY = 75;
  float shineAmount = 75;
  float shineIncrement = 1;

  boolean collected = false;
  boolean collectable = false;


  Battery(float x, float y) {
    position = new PVector(x, y);
  }

  void update() {
    if (collected) {
      if (battSize > 0) {
        battSize = battSize - 1;
      }
    }
  }


  void draw() {
    float d = dist(position.x, position.y, player.position.x, player.position.y);
    if (d < lightSize) {
      //fill(255, 255, 255, shineAmount);
     // noStroke();
     // ellipse(position.x, position.y, lightX, lightY);

      fill(169, 255, 0);
      ellipse(position.x, position.y, battSize, battSize);
      //image(gem, position.x, position.y, artSize, artSize);
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
    //println(collectable);
  }


  void run() {
    update();
    draw();
  }
}
