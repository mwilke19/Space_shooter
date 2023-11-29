class Game {
  int init, play;
  float efficiency, final_time;
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
  void save_score() {
    score = new Table();

    String name = "Michael";
    float time = game.final_time;
    float efficiency = game.efficiency;
    float num_of_kills = enemies_killed;

    score.addColumn("NAME");
    score.addColumn("TIME");
    score.addColumn("EFFICIENCY");
    score.addColumn("KILLS");

    TableRow newRow = score.addRow();

    newRow.setString("NAME", name);
    newRow.setFloat ("TIME", time);
    newRow.setFloat ("EFFICIENCY", efficiency);
    newRow.setFloat ("KILLS", num_of_kills);

    saveTable(score, "data/SCORES.csv");
  }
  void display_score() {
    score = loadTable("SCORES.csv", "header");
    //println(score.getRowCount() + " total rows in table");
    for (TableRow score : score.rows()) {
      String Name = score.getString("NAME");
      int Time = score.getInt("TIME");
      int Efficiency = score.getInt("EFFICIENCY");
      int Enemies_killed = score.getInt("KILLS");
      text("Last Recorded Game Statistics", width/2,height/2);
      stroke(255,0,0);
      strokeWeight(5);
      line(width/4,height/2+5,900,height/2+5);
      noStroke();
      text(Name, width/4, height/2 + 100);
      text("Time: " + Time, width/4 + 150, height/2 + 100);
      text("Efficiency: " + Efficiency, width/4 + 350, height/2 + 100);
      text("Number of enemies killed: " + Enemies_killed, width/4 + 650, height/2 + 100);
    }
  }
  void init() {
    float row_1, row_2, row_3, row_4, row_5;
    int title_color, text_color;

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
    text("ARROW KEYS FOR DIRECTIONAL CONTROL", width/2, height/4+50);
    text("SPACEBAR = FIRE", width/2, row_1);
    display_score();
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
    for (Bullet e_bullet : e_bullet_list) {
      e_bullet.run();
    }
    for (Enemy enemy : enemy_list) {
      enemy.run();
    }
    addStar();
    addAsteroid();
    addEnemy();
    removeDeadStars(stars);
    removeDeadAsteroids(actors);
    remove_dead_s_bullet(s_bullet_list);
    remove_dead_e_bullet(e_bullet_list);
    removeDeadEnemy(enemy_list);
    removeHitEnemy(enemy_list);
    asteroid_difficulty();
    show_statistics();
  }
  void game_over() {
    float column_1, column_2, row_1, row_2, row_3;
    int title_color, text_color;

    title_color = color(255, 0, 0);
    text_color = 255;

    final_time = game_timer;//game_timer is a global variable
    efficiency = (enemies_killed/enemy_count)*100;

    column_1 = width/4;
    column_2 = width* .75-100;
    row_1 = height/2 - 200;
    row_2 = height/2 - 150;
    row_3 = height/2 - 100;

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

    save_score();
  }
}
