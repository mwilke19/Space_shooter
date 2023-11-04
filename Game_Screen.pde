class Game {
  int init, play;
  Game() {
    init = 1;
    play = 0;
  }
  void run() {
    //ship is the first index of actors ArrayList
    //It is added in setup
    boolean ship_dead = actors.get(0).isDead();

    if (init == 1)init();
    if (play == 1)play();

    if (mousePressed) {
      play = 1;
      init = 0;
    }
    if (ship_dead == true) {
      play = 0;
      game_over();
    }
  }
  void init() {
    float column_1, column_2, row_1, row_2, row_3, row_4, row_5;
    int title_color, text_color;

    column_1 = width/4+100;
    column_2 = width*.750-250;

    row_1 = height/4 + 100;
    row_2 = height/4 + 150;
    row_3 = height/2;
    row_4 = height/4 + 200;
    row_5 = height/2 + 50;

    title_color = color(0, 255, 0);
    text_color  = 255;

    background(0);

    fill(title_color);
    textFont(font);
    textAlign(CENTER);
    text("CLICK TO START", width/2, height/4);

    fill(text_color);
    textSize(25);
    text("USE THE FOLLOWING KEY COMMANDS", width/2, height/4+50);
    text("SPACEBAR = FIRE", width/2, row_5);

    textAlign(LEFT);
    text("W = UP", column_1, row_1);
    text("S = DOWN", column_1, row_2);
    text("A = LEFT", column_2, row_1);
    text("D = RIGHT", column_2, row_2);
    text("Q = UP/LEFT", column_1, row_4);
    text("E = UP/RIGHT", column_1, row_3);
    text("Z = DOWN/LEFT", column_2, row_4);
    text("C = DOWN/RIGHT", column_2, row_3);
  }
  void play() {
    for (Star star : stars) {
      star.run();
    }
    for (Actor actor : actors) {
      actor.run();
    }
    for (Bullet s_bullet : s_bullet_list) {
      s_bullet.run();
    }
    for (Enemy enemy : enemy_list) {
      enemy.run();
    }
    addStar();
    addAsteroid();
    addEnemy();
    removeDeadStars(stars);
    removeDeadAsteroids(actors);
    removeDeadBullets(s_bullet_list);
    removeDeadEnemy(enemy_list);
    removeHitEnemy(enemy_list);
    asteroid_difficulty();
    show_statistics();
  }
  void game_over() {
    float final_time, column_1, column_2, row_1, row_2, row_3, efficiency,text_width;
    int title_color, text_color;
    
    title_color = color(255, 0, 0);
    text_color = 255;
  
  
    final_time = game_timer;//game_timer is a global variable
    column_1 = width/4;
    column_2 = width* .75-100;
    row_1 = height/2 - 200;
    row_2 = height/2 - 150;
    row_3 = height/2 - 100;
    
    efficiency = (enemies_killed/enemy_count)*100;

    background(0);

    fill(title_color);
    textFont(font);
    textAlign(CENTER);
    text("GAME OVER", width/2, 250);

    fill(text_color);
    textSize(25);
    textAlign(LEFT);
    text("FINAL TIME", column_1, row_1);
    text(int(final_time), column_2, row_1);
    text("ENEMIES KILLED", column_1, row_2);
    text(int(enemies_killed), column_2, row_2);
    text("EFFICIENCY", column_1, row_3);
    text(int(efficiency), column_2, row_3);
    text(" % ", column_2 + 50, row_3);
  }
}
