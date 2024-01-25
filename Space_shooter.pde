PFont thirteen_pixel, twenty_five_pixel,seventy_five_pixel,one_hundred_pixel,fifty_pixel;
Game_Window game_window;
Actor ship;
PImage asteroid,earth,mars,mercury,saturn;
Table score_data;

float col_1, col_2; 
float row_1, text_row_1, row_3, row_4, row_5;
float x_center,y_center;
int[] score_array = new int[4];
char[]  initials = new char[3];
int cursor = 0;

final color RED = color(255,0,0);
final color WHITE = color(255);
final color BLUE = color(0,0,255);
final color GREEN = color(0,255,0);
final color YELLOW = color(255,255,0);
final color ASTEROID_GREY = color(145);
final color PLANET_RANDOM = color(0,random(125,255),random(125,255));
void setup() {
  fullScreen(P2D);
  //size(displayWidth, displayHeight,P3D);
  background(0);
  
  textAlign(CENTER, BOTTOM);
  imageMode(CENTER);
  
  thirteen_pixel = createFont("Arial",13);
  twenty_five_pixel = createFont("Arial", 25);
  one_hundred_pixel = createFont("Arial Black", 100);
  seventy_five_pixel = createFont("Arial",75);
  fifty_pixel = createFont("Arial Black",50);
  
  game_window = new Game_Window();
  
  ship = new Ship()
    .set_position(400, 400)
    .set_speed(4, 5)
    .set_color(WHITE)
    .set_size(100);
  
  game_window.load_score_data();
  mars = loadImage("Mars.png");
  mercury = loadImage("Mercury.png");
  earth = loadImage("Earth.png");
  asteroid = loadImage("Meteor.png");
  saturn = loadImage("Saturn.png");
  score_array = int(score_data.getFloatColumn("SCORE"));
  //Uncomment the following two lines to see the available fonts
  //String[] fontList = PFont.list();
  //printArray(fontList);
}
void draw() {
  smooth();
  background(0);
  game_window.run();
  //printArray(score_array);
}
void keyReleased() {
  boolean ship_dead = ship.is_dead();

  if (ship_dead) {
    if (key == 's' || key == 'S') {
      game_window.add_new_score();
    }
    if (key == 'q' || key == 'Q') {
      exit();
    }
  }
}
void keyPressed() {
  if (keyCode == BACKSPACE && cursor > 0) {
    cursor -= 1;
    initials[cursor] = 0;
  } else if (cursor < 3) {
    char initial = Character.toUpperCase(key);
    if (initial == constrain(initial, 'A', 'Z')) {
      initials[cursor] = initial;
      cursor += 1;
    }
  }
}
void show_statistics() {
  push();
  fill(WHITE);
  textFont(thirteen_pixel);
  text("SCORE:", 45, 50);
  text(int(enemies_killed), 120, 50);
  pop();
  ship.render_health_bar();
  
}
