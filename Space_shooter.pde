PFont game_statistic_font, primary_text_font,primary_title_font,secondary_title_font;
Game game;
Actor ship;

Table score_data;
float col_1, col_2, row_1, row_2, row_3, row_4, row_5;
char[]  initials = new char[3];
int cursor = 0;
void setup() {
  size(1300, 1200);
  background(0);
  
  textAlign(CENTER, BOTTOM);
  game_statistic_font = createFont("Arial",12.5);
  primary_text_font = createFont("Arial", 25);
  primary_title_font = createFont("Arial Black", 100);
  secondary_title_font = createFont("Arial Black",50);
  
  game = new Game();
  
  ship = new Ship()
    .set_position(400, 400)
    .setSpeed(4, 5)
    .set_color(255)
    .setSize(100);
  actors.add(ship);
  
  game.load_score_data();

  //Uncomment the following two lines to see the available fonts
  //String[] fontList = PFont.list();
  //printArray(fontList);
}
void draw() {
  smooth();
  background(0);
  game.run();
}
void keyReleased() {
  boolean ship_dead = actors.get(0).is_dead();

  if (ship_dead) {
    if (key == 's' || key == 'S') {
      game.add_new_score();
    }
    if (key == 'y' || key == 'Y') {
      game.game_reset();
    }
    if (key == 'q' || key == 'Q') {
      exit();
    }
  }
}
void keyPressed() {
  if (keyCode == BACKSPACE && cursor > 0) {
    cursor = cursor - 1;
    initials[cursor] = 0;
  } else if (cursor < 3) {
    char initial = Character.toUpperCase(key);
    if (initial == constrain(initial, 'A', 'Z')) {
      initials[cursor] = initial;
      cursor = cursor + 1;
    }
  }
}
void show_statistics() {
  push();
  fill(255);
  textAlign(LEFT,BOTTOM);
  textFont(game_statistic_font);
  text("SCORE:", 45, 50);
  text(int(enemies_killed), 125, 50);
  pop();
  ship.render_health_bar();
  
}
