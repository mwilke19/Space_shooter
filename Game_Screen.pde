class Game {
  boolean g_start, g_play,g_over;
  float efficiency, final_time;
  Game() {
    g_start = true;
    g_play = false;
    g_over = false;
  }
  void run() {
    //ship is the first index of actors ArrayList
    //It is added in setup
    boolean ship_dead = actors.get(0).isDead();

    if (g_start == true)game_start();
    if (g_play == true)game_play();
    if (g_over == true)game_over();
    
    if (mousePressed) {
      if(cursor == 3){
      g_play = true;
      g_start = false;
      }
      if(cursor < 3){
        text("YOU MUST ENTER YOUR INITIALS TO PLAY",width/2,height/2-100);
        initials[cursor] = 0;
      }      
    }
    if (ship_dead == true) { 
      g_play = false;
      g_over = true;
    }
  }
  void save_score() {
    score = new Table();

    String name = new String(initials);
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
      textSize(25);
      fill(255,255,0);
      text("Last Recorded Game Statistics", width/2, height/2);
      stroke(255, 0, 0);
      strokeWeight(5);
      line(width/4, height/2+5, 900, height/2+5);
      noFill();
      stroke(255, 255, 0);
      rect(50, 50, 1200, 900);
      noStroke();
      text(Name, 275, height/2 + 100);
      text("Time: " + Time, width/4 + 150, height/2 + 100);
      text("Efficiency: " + Efficiency, width/4 + 350, height/2 + 100);
      text("Number of enemies killed: " + Enemies_killed, width/4 + 650, height/2 + 100);
    }
  }
  void game_start() {
    float row_1, row_2, row_3, row_4, row_5;
    int title_color, text_color;
    int outer_gap = 525; // 500px of space on left and right
    int inner_gap = 30;  // 30px between letters
    int total_width = width - (outer_gap * 2);
    int line_width = (total_width - (inner_gap * 4)) /3;

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
    fill(0, 100, 255);
    text("CLICK TO START", width/2, height/4);

    fill(text_color);
    textSize(25);
    text("ARROW KEYS FOR DIRECTIONAL CONTROL", width/2, height/4+50);
    text("SPACEBAR = FIRE", width/2, row_1);
    fill(0,255,0);
    text("PLEASE ENTER YOUR INITIALS", width/2, row_2);

    for (int i = 0; i < 3; i++) {
      int x = outer_gap + (line_width + inner_gap) * i;
      int y = height/2-75;
      
      fill(255,175,125);
      textSize(65);
      if (cursor > i)
        text(initials[i], x + line_width/2, y);
    }

    display_score();
  }
  void game_play() {
    for (Particle explosion : burst) {
      explosion.run();
    }
    for (Particle star : stars) {
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
    addBurst();
    addAsteroid();
    addEnemy();
    removeDeadStar(stars);
    removeDeadBurst(burst);
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
