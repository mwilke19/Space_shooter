PFont font;
Game game;
void setup() {
  size(1600, 1000);
  background(0);
  textAlign(CENTER);
  font = createFont("Elephant",50);
  game = new Game();
  Actor ship = new Ship()
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
 void show_score(){
    fill(255);
    textFont(font,12.5);
    text("SCORE:", 40, 50);
    text(int(enemies_killed),125,50);
  }
