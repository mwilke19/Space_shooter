PFont font;
Game game;
Actor ship;
Table score;
float col_1, col_2, row_1, row_2, row_3, row_4, row_5;
char[]  initials = new char[3];
int cursor = 0;
void setup() {
  size(1300, 1200);
  background(0);
  textAlign(CENTER,BOTTOM);
  font = createFont("Elephant", 50);
  game = new Game();
   ship = new Ship()
    .setPosition(400, 400)
    .setSpeed(4, 5)
    .setColor(255)
    .setSize(100);
  actors.add(ship);
  
}
void draw() {
  smooth();
  background(0);
  game.run();
  printArray(initials);
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
  game_timer = millis()/1000;
  fill(255);
  textAlign(LEFT);
  textFont(font, 12.5);
  text("SCORE:", 45, 50);
  text(int(enemies_killed), 125, 50);
  text("GAME TIME:", 45, 70);
  text(int(game_timer), 155, 70);
  ship.renderHealthBar();
}
