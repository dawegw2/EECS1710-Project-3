PImage img;
ArrayList<Lines> lines;
ArrayList<Points> dots;
int lineScalar = 30; 
int dotScaler = 30;

Points line;

void setup() {
  size(50, 50, P2D);  
  img = loadImage("image2.jpg");
  surface.setSize(img.width, img.height);

  img.loadPixels();
  lines = new ArrayList<Lines>();
  dots = new ArrayList<Points>();

  for (int x = 0; x < img.width; x += lineScalar) {
    for (int y = 0; y < img.height; y += lineScalar) {
      int index = x + y * (img.width);
      lines.add(new Lines(x, y, img.pixels[index]));
    }
  }

  for (int x = 0; x < img.width; x += dotScaler) {
    for (int y = 0; y < img.height; y += dotScaler) {
      int index2 = x + y * (img.width);

      float r = red(img.pixels[index2]);
      float g = red(img.pixels[index2]);
      float b = red(img.pixels[index2]);

      //dots.add(new Points(x, y, img.pixels[index2]));
      
    }
  }
}

void draw() { 
  background(0);

  for (Lines line : lines) {
    line.run();
  }

  for (Points dot : dots) {
    dot.run();
  }
  surface.setTitle("" + frameRate);
}
