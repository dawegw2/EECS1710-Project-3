class Points {
  PVector position, target, target2, target3;
  color col;
  float speed;
  float pointSize;
  float ran = 0;

  float rot = 0;
  float rotInc = 0.5;

  float margin = 75;

  boolean move = false;
  boolean still = false;
  boolean newTarget = false;
  boolean bothered = false;

  Points(float x, float y, color _col) {
    position = new PVector(x, y);
    //target2 = new PVector(random(width), random(height));
    target3 = new PVector(random(width - margin), random(height - margin));

    col = _col;

    speed = random(0.005, 0.01); 
    pointSize = 15; 
  }

  void update() {
    target = new PVector(mouseX, mouseY);
    //moveToNewPos();

    shakeDot();

    if (bothered) {
      position.lerp(target3, speed);
    }
  }

  void draw() {

    stroke(col);
    strokeWeight(pointSize);
    point(position.x + ran, position.y + ran);
  }

  void shakeDot() {
    if (still) {
      ran = random (-2, 2);
    } else {
      ran = 0;
    }
  }

  void moveDot() {
    if (mousePressed) {
      still = true;   
      bothered = false;
      newTarget = true;

      position.lerp(target, speed);
      target2 = new PVector(random(width), random(height));

      changeCol();

      if (pointSize > 5) {
        pointSize -= 0.1;
      }
    } else {
      // bothered = true;

      if (newTarget) {
        position.lerp(target2, speed);
      }

      if (pointSize < 15) {
        pointSize += 0.1;
      }
      still = false;
    }
  }

  void checkMouseDistance() { 
    float d = dist(position.x, position.y, mouseX, mouseY); 
    if (d < 20) { 
      bothered = true;
      println(bothered);
    }
  }

  void moveToNewPos() {
    target3 = new PVector(random(margin, width-margin), random(margin, height-margin));
  }

  void changeCol() {
    float d = dist(mouseX, mouseY, position.x, position.y);

    color c = img.get(int(position.x), int(position.y));
    //pointSize = map(brightness((c)), 0, 255, 15, 5);
    //col = int(map(d, 0, 20, 2, 200));

    float factor = map(d, 60, 200, 0, 20); 

    float r = red(col);
    float g = green(col);
    float b = blue(col);
    //color newCol = color(int(map(col, 0, 255, 15, d)), 100);
    //col = color(r*factor, g*facto, b);
    //col = lerpColor(col, newCol, 1);

    float val = random(1);
    color newCol;

    if (val > 0.5) {
      newCol = color(r, g*factor, b, (random(0, 255)));
    } else {
      newCol = color(r*factor, g, b, (random(0, 255)));
    }

    if (d < 20) {
      col = newCol;
    } 
    if (d > 50) {
      col = color(r, g, b);
    }
  }

  void run() {
    update();
    draw();
    checkMouseDistance();
    moveDot();
  }
}
