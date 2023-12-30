PFont game_font;
PFont title_font;
Game game;
Actor ship;

Table score_data;
float col_1, col_2, row_1, row_2, row_3, row_4, row_5;
char[]  initials = new char[3];
int cursor = 0;
void setup() {
  size(1300, 1200);
  background(0);
  textAlign(CENTER,BOTTOM);
  game_font = createFont("Arial", 50);
  title_font = createFont("arial black",100);
  game = new Game();
   ship = new Ship()
    .setPosition(400, 400)
    .setSpeed(4, 5)
    .setColor(255)
    .setSize(100);
  actors.add(ship);
   //Uncomment the following two lines to see the available fonts 
  //String[] fontList = PFont.list();
  //printArray(fontList);
  
}
void draw() {
  smooth();
  background(0);
  game.run();
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
  fill(255);
  textAlign(LEFT);
  textFont(game_font, 12.5);
  text("SCORE:", 45, 50);
  text(int(enemies_killed), 125, 50);
  ship.render_health_bar();
}
