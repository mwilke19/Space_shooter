Game game;
void setup() {
  size(1000, 1000);
  background(0);
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
