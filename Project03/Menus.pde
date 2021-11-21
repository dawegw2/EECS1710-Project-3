class StartPage {
  PFont font;
  String message = ("Collect 3 Keys to Escape");
  String message2 = ("Left Mouse Button to move");
  String message3 = ("click anywhere to begin");

  StartPage() {
  }
  void screen() {
    fill(0);
    rect(800, 800, width/2, height/2);
  }
  void display() {
    fill(255);
    font = createFont("Arial", 100);
    textFont(font);
    textSize(30);
    text(message, width/2, height - 200);
    if (lightSize <= lightInc) {
      textSize(20);
      text(message2, width/2, height - 150);
      text(message3, width/2, height - 100);
    }
  }

  void run() {
    screen();
  }
} 


class EndPage {
  PFont messagefont;
  String message = ("CONGRAGULATIONS!");
  String message2;
  String message3 = ("Click anywhere to play again");

  int time;

  EndPage() {
    //score = _score;
  }

  void display(int _time) {

    time = _time;
    fill(255);
    //messagefont = createFont("Arial", 25);
    textSize(50);
    text(message, width/2, height/2);

    textSize(40);
    message2 = ("It took you " + time + " seconds to escape!");
    text(message2, width/2, height/2 + 50);

    textSize(20);
    text(message3, width/2, height/2 + 100);

    gameOver = true;
    noLoop();
  }
} 
