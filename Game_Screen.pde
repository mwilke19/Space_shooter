
class Game {
  int init, play;
  Game() {
    init = 1;
    play = 0;
  }
  void run() {
    if (init == 1)init();
    if (mousePressed) {
      play = 1;
      init = 0;
    }
    if (play == 1)play();
    if (actors.get(0).isDead() == true) {
      play = 0;
      over();
    }
  }
  void init() {
    background(0);
    textAlign(CENTER);
    textSize(100);
    text("CLICK TO START", 500, 250);

    textAlign(CENTER);
    textSize(50);
    text("USE THE FOLLOWING KEY COMMANDS", 500, 300);

    textAlign(CENTER);
    textSize(25);
    text("W = UP", 350, 350);

    textAlign(CENTER);
    textSize(25);
    text("S = DOWN", 350, 400);

    textAlign(CENTER);
    textSize(25);
    text("A = LEFT", 600, 350);

    textAlign(CENTER);
    textSize(25);
    text("D = RIGHT", 600, 400);

    textAlign(CENTER);
    textSize(25);
    text("Q = UP/LEFT", 350, 450);

    textAlign(CENTER);
    textSize(25);
    text("E = UP/RIGHT", 350, 500);

    textAlign(CENTER);
    textSize(25);
    text("Z = DOWN/LEFT", 600, 450);

    textAlign(CENTER);
    textSize(25);
    text("C = DOWN/RIGHT", 600, 500);
  }
  void play() {
    for (Star star : stars) {
      star.run();
    }
    for (Actor actor : actors) {
      actor.run();
    }
    for (Bullet bullet : bullet_list) {
      bullet.run();
    }
    for (Enemy enemy : enemy_list) {
      enemy.run();
    }
    addStar();
    renderGameTime();
    addAsteroid();
    addEnemy();
    removeDeadStars(stars);
    removeDeadAsteroids(actors);
    removeDeadBullets(bullet_list);
    removeDeadEnemy(enemy_list);
    increaseDifficulty();
  }
  void over() {
    float final_time = game_timer;
    background(0);
    textAlign(CENTER);
    textSize(100);
    text("GAME OVER", width/2, height/2);
    textSize(100);
    text(int(final_time), width/2, 600);
  }
}
