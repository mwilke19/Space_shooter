PFont thirteen_pixel, twenty_five_pixel,seventy_five_pixel,one_hundred_pixel,fifty_pixel;
Game_Window game_window;
Actor ship;
Planets planet;
PImage asteroid,earth,mars,jupiter,saturn,uranus,neptune,ship_image,enemy_image,title_image;
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

void setup() {
  fullScreen(P2D);
  //size(800, 800,P2D);
  background(0);
  
  textAlign(CENTER, BOTTOM);
  imageMode(CENTER);
  add_fonts();
  
  game_window = new Game_Window();
  
  x_center = width/2;
  y_center = height/2;
  
  add_ship();
  add_planets();
  add_game_images();
  
  game_window.load_score_data();
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
