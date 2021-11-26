import processing.sound.*;
SoundFile click, keyNoise, gameMusic;

Player player;
Timer timer;
StartPage startScreen;
EndPage endScreen;

ArrayList<Dot> dots;
ArrayList<Key> keys = new ArrayList<Key>();
ArrayList<Battery> battery = new ArrayList<Battery>();
ArrayList<PVector> keySpawnPos, batterySpawnPos; 

PImage maze, itemSpawnMap;
PVector reset;

int numKeys = 5;
int numBatteries = 3;
int s = 0;
int st = millis();

int dotScaler = 25;
int threshold = 200;
int numKeysCollected = 0;
int numBattsCollected = 0;

float lightSize = 900;
float lightInc = 60;

color dotCol = color(255, 0, 0); 

boolean hitWall = false;
boolean gameRunning = false;
boolean gameOver = false;
boolean startMenu = true;
boolean move = false;
boolean keysCollected = false;

void setup() {
  size(800, 800);

  reset = new PVector(width/2, 10);
  player = new Player(reset.x, reset.y, dotCol, reset);
  timer = new Timer(s, st);
  startScreen = new StartPage();
  endScreen = new EndPage();

  maze = loadImage("maze.png");
  itemSpawnMap = loadImage("artifactmap.png");
  itemSpawnMap.loadPixels();

  click = new SoundFile(this, "sound/click.wav");
  keyNoise = new SoundFile(this, "sound/keys.wav");
  gameMusic = new SoundFile(this, "sound/gamemusic.wav");

  gameMusic.loop();

  keySpawnPos = new ArrayList<PVector>();
  batterySpawnPos = new ArrayList<PVector>();

  for (int x = 0; x< itemSpawnMap.width; x++) {
    for (int y = 0; y< itemSpawnMap.height; y++) {
      int loc = x + y * width;
      color col = itemSpawnMap.pixels[loc];
      if (red(col) > 200) {
        batterySpawnPos.add(new PVector(x, y));
      }
      if (blue(col) > 200) {
        keySpawnPos.add(new PVector(x, y));
      }
    }
  }

  for (int i=0; i < numKeys; i++) {
    int index = int(random(keySpawnPos.size()));
    PVector spawnPos = keySpawnPos.get(index);
    keys.add(new Key(spawnPos.x, spawnPos.y));
  }

  for (int i=0; i < numBatteries; i++) {
    int index = int(random(batterySpawnPos.size()));
    PVector spawnPos = batterySpawnPos.get(index);
    battery.add(new Battery(spawnPos.x, spawnPos.y));
  }

  loadPixels();
}

void draw() { 
  //Light
  maze.loadPixels();
  itemSpawnMap.loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int index = x + y*width;

      float rMaze = red(maze.pixels[index]);
      float gMaze = green(maze.pixels[index]);
      float bMaze = blue(maze.pixels[index]);

      float rKey = red(itemSpawnMap.pixels[index]);
      float gKey = green(itemSpawnMap.pixels[index]);
      float bKey = blue(itemSpawnMap.pixels[index]);

      color colKey = itemSpawnMap.pixels[index];

      float d = dist(player.position.x, player.position.y, x, y);
      float factor = map(d, 0, lightSize, 5, 0);

      pixels[index] = color(rMaze*factor, gMaze*factor, bMaze*factor);

      if (blue(colKey) > 200) {
        //pixels[index] = color(0, gArt*factor, 0);
      }
      //dots.add(new Dot(x, y, maze.pixels[index]));
    }
  }
  updatePixels();

  //reset player when they hit a wall
  int loc = int(player.position.x) + int(player.position.y) * maze.width;
  float b = brightness(maze.pixels[loc]);
  if (b > 100) {
    player.target = reset.copy();
    hitWall = true;
  } else {
    hitWall = false;
  }

  //draws the player dot
  player.run();

  //creates the keys to collect
  for (int i = 0; i < keys.size(); i++) {
    keys.get(i).run();
  }

  //removes the keys out the arraylist once collected 
  for (int i = keys.size()-1; i >= 0; i--) {
    Key k = keys.get(i);

    if (numKeysCollected >= 3) {
      keys.remove(i);
    }
    if (k.keySize <= 0 && k.collected && numKeysCollected < 3) {
      keyNoise.play();
      keys.remove(i);
      numKeysCollected += 1;
      numKeys -= 1;
    }
  }

  //println(keys.size());

  //spawn batteries
  for (int i = 0; i < battery.size(); i++) {
    battery.get(i).run();
  }

  //removes the batteries out the arraylist once collected 
  for (int i = battery.size()-1; i >= 0; i--) {
    Battery batt = battery.get(i);
    if (batt.battSize <= 0 && batt.collected) { //numBatteries == 3
      click.play();
      battery.remove(i);
      //numBattsCollected += 1;
      if (battery.size() >= 1) {
        lightSize += lightSize*0.50;
      } else {
        lightSize += lightSize*0.75;
      }
    }

    if (numKeysCollected == 3) {
      //lightSize += 50;
      battery.remove(i);
    }
  }

  if (gameRunning) {
    //runs the timer once game is ready to play
    timer.run();
    move = true;
    if (numKeysCollected == 3) {
      fill(127);
      textSize(20);
      text("Now find the Exit", width - 90, height - 20);
    }
    fill(127);
    textSize(30);
    text("Keys: " + numKeysCollected + "/3", width - 68, 65);

    fill(255, 215, 0);
    ellipse(10, 10, 15, 15);
    fill(169, 255, 0);
    ellipse(10, 30, 15, 15);

    fill(127);
    textSize(15);
    text(" : Key", 38, 15);
    text(" : Battery", 48, 35);
  } else {
    if (lightSize > lightInc && !gameRunning) {
      lightSize = lightSize - 3;
    }
  }
  //start screens
  if (startMenu) {
    startScreen.screen();
    startScreen.display();
  }
  //end screen
  if (player.escaped && numKeysCollected >= 3) {
    //gameRunning = false; 
    endScreen.display(timer.seconds);
    gameMusic.stop();
  }

  surface.setTitle("" + frameRate);
}

//controls
void mousePressed() {
  if (mouseButton == RIGHT) {
    if (move) {
      player.target = new PVector(mouseX, mouseY);
    }
  }

  if (!gameRunning && lightSize <= lightInc) {
    gameRunning = true;
    startMenu = false;
    gameMusic.loop();
  }

  if (gameOver) {
    gameRunning = false;
    gameOver = false;
    startMenu = true;

    hitWall = false;
    move = false;
    keysCollected = false;

    numKeys = 5;
    numBatteries = 3;

    dotScaler = 25;
    threshold = 200;
    lightSize = 900;
    lightInc = 60;
    numKeysCollected = 0;
    s = 0;
    st = millis();

    dotCol = color(255, 0, 0); 

    setup();
    loop();
  }
}
