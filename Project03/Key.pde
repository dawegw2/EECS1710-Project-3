class Key {
  PVector position;
  float keySize = 15;

  float lightX = 75;
  float lightY = 75;
  float shineAmount = 75;
  float shineIncrement = 1;

  boolean collected = false;
  boolean collectable = false;

  Key(float x, float y) {
    position = new PVector(x, y);
    imageMode(CENTER);
  }

  void update() {
    if (collected) {
      if (keySize > 0) {
        keySize = keySize - 1;
      }
    }
  }

  void draw() {
    float d = dist(position.x, position.y, player.position.x, player.position.y);
    if (d < lightSize) {
      fill(255, 228, 0, shineAmount);
      noStroke();
      ellipse(position.x, position.y, lightX, lightY);
      
      fill(255, 215, 0);
      ellipse(position.x, position.y, keySize, keySize);      
    }

    if (d < 25 && numKeysCollected < 3) {
      collectable = true;
      fill(255);
      textSize(25);
      text("Press z to collect", width/2, height - 50);

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


  void sunLight() { //code taken from my excersise 2
    if (lightX != -25) { //expands the emitted light when the width is not -220
      lightX = lightX + 1;
      lightY = lightY + 1;
      shineAmount = shineAmount + shineIncrement; //increases or decreases the opacity of the light circle as it changes size by shineIncrement which is either 1 or -1
    } else {              //resets width and height of the lighter circle to positive 220 when the width is -220
      lightX = lightX * -1;
      lightY = lightY * -1;
      shineIncrement = 1;
    }
    if (lightX > 50) { //decreases width and height of the lighter circle  
      lightX = lightX * -1;
      lightY = lightY * -1;
      shineIncrement = -1;
    }
  }
  void run() {
    update();
    sunLight();
    draw();
  }
}
