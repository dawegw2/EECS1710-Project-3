class Lines {
  PVector position, target, target2;
  color col;
  float speed;
  float lineSize;
  float lineLength = 15;
  float ran = 0;

  float rot = 0.5;
  float minRotSpeed = 0.5;
  float minRotSpeed2 = -0.5;
  float rotSpeed = 15;
  float minSpeed = 0.1;
  float maxSpeed = 15;

  boolean move = false;
  boolean still = false;
  boolean counterClockwise;
  boolean slowDown;

  boolean speedUp = false;

  Lines(float x, float y, color _col) {
    position = new PVector(x, y);
    target2 = new PVector(random(width), random(height));

    //init();
    col = _col;

    speed = random(0.001, 0.01); 
    lineSize = 2;       
  }

  void init() {
    int ranVal = int(random(1));
    if (ranVal > 0.5) {
      counterClockwise = true;
    } else {
      counterClockwise = false;
    }
  }

  void draw() {
    stroke(col);
    strokeWeight(lineSize);

    if (slowDown) {
      if (rotSpeed > minRotSpeed) {
        rotSpeed -= 0.05;
      }
      if (rotSpeed < minRotSpeed2) {
        rotSpeed += 0.05;
      }
    }

    if (speedUp) {
      //slowDown = false;
      rotSpeed = 30;
    }

    if (rotSpeed < minSpeed && rotSpeed > 0) {
      rotSpeed = minSpeed;
      slowDown = false;
    }

    if (rotSpeed >= maxSpeed) {
      slowDown = true;
      speedUp = false;
    }

    rot += rotSpeed;

    pushMatrix();
    translate(position.x, position.y);

    if (!counterClockwise) {
      rotate(radians(rot));
    } else {
      rotate(radians(-rot));
    }

    line(0, 0, lineLength, lineLength);
    line(0, 0, -lineLength, -lineLength);
    //strokeWeight(8);
    //point(0, 0);
    popMatrix();
  }


  void update() {
    target = new PVector(mouseX, mouseY);
    shakeLine();
    flip();
    //shrinkLine();
  }

  void shakeLine() {
    if (still) {
      ran = random (-2, 2);
    } else {
      ran = 0;
    }
  }

  void shrinkLine() {
    if (mousePressed) {
      lineLength -= 1;
    } else {
      if (lineLength < 15) {
        lineLength += 1;
      }
    }
  }

  void moveLine() {
    if (mousePressed) {
      position.lerp(target, speed);
      still = true; 
      move = false;
      //slowDown = true;
      speedUp = true;
    } else {
      still = false;
      position.lerp(target2, speed);
      //slowDown = true;
      //if (slowDown && rotSpeed > 0.5) {
      // rotSpeed -= 0.05;
      // }
    }
  }

  void checkMouseDistance() { 
    float d = dist(position.x, position.y, mouseX, mouseY); 
    if (d < 10) { 
      counterClockwise = true;
      println(counterClockwise);
    } else {
      counterClockwise = false;
    }
  }

  void flip() {
    if (counterClockwise) {
      rotSpeed = -10;
    }
  }

  void run() {
    update();
    draw();
    checkMouseDistance();
    //moveLine();
    //println(rotSpeed);
  }
}
