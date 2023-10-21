PFont font;
Game game;
Actor ship;
void setup() {
  size(1600, 1000);
  background(0);
  textAlign(CENTER);
  font = createFont("Elephant", 50);
  game = new Game();
   ship = new Ship()
    .setPosition(400, 400)
    .setSpeed(3, 3)
    .setColor(255)
    .setSize(100);
  actors.add(ship);
}
void draw() {
  smooth();
  background(0);
  game.run();
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
