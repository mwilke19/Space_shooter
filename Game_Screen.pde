class Game {
  int g_start, g_play, g_over, g_play_again, state;
  float efficiency, DELAY;

  Game() {
    g_start = 0;
    g_play = 10;
    g_over = 20;
    state = g_start;
  }
  void run() {
    //ship is the first index of actors ArrayList
    //It is added in setup
    boolean ship_dead = actors.get(0).is_dead();

    if (state == g_start) {
      game_start();
    }
    if (state == g_play) {
      game_play();
    }
    if (state == g_over) {
      game_over();
    }

    if (mousePressed) {
      if (cursor == 3) {
        state = g_play;
      }
      if (cursor < 3) {
        text("YOU MUST ENTER YOUR INITIALS TO PLAY", width/2, height/2-100);
      }
    }
    if (ship_dead == true) {
      state = g_over;
      if (key == 's') {
        record_score_data();
      }
      if (key == 'a') {
        add_new_data();
      }
      if (key == 'y') {
        game_reset();
      }
      if (key == 'q') {
        exit();
      }
    }
    //println("state.........." + state);
    //println("ship_dead......" + ship_dead);
  }
  void load_score_data() {
    score_data = loadTable("score_data.csv", "header");
  }
  void save_score_data() {
    saveTable(score_data, "data/score_data.csv");
  }
  void add_new_data() {
    int c_num_of_rows = score_data.getRowCount()-1;
    int MAX = 4 ;
    if (c_num_of_rows <= MAX) {
      String name = "ABC";
      float num_of_kills = random(100);
      TableRow new_score = score_data.addRow();
      new_score.setString("NAME", name);
      new_score.setFloat("SCORE", num_of_kills);
      println(score_data.getRowCount());
    }
    save_score_data();
    println("add_new_data executed");
  }
  void record_score_data() {
    score_data = new Table();

    String name = new String(initials);

    float num_of_kills = enemies_killed;

    score_data.addColumn("NAME");
    score_data.addColumn("SCORE");

    TableRow newRow = score_data.addRow();

    newRow.setString("NAME", name);
    newRow.setFloat ("SCORE", num_of_kills);

    save_score_data();
    println("save_score_data executed");
  }
  void display_score_data() {
    load_score_data();
    //println(score_data.getRowCount() + " total rows in table");
    fill(255, 255, 0);
    for (int i = 0; i < score_data.getRowCount(); i++) {
      TableRow row = score_data.getRow(i);
      String name = row.getString("NAME");
      int score = row.getInt("SCORE");
       textSize(25);
      fill(255, 255, 0);
      text("TOP SCORES", width/2, height/2);
      stroke(255, 0, 0);
      //strokeWeight(5);
      line(width/4, height/2+5, 900, height/2+5);
      noFill();
      stroke(255, 255, 0);
      rect(50, 50, 1200, 900);

      int y = height/2 + 50 + (50 * i);
      text(name, width/4 + 250, y);
      text(score, width/4 + 400, y);
    }
  }
  void game_start() {
    float row_1, row_2, row_3, row_4, row_5;
    int title_color, text_color;
    int outer_gap = 525; // 500px of space on left and right
    int inner_gap = 30;  // 30px between letters
    int total_width = width - (outer_gap * 2);
    int line_width = (total_width - (inner_gap * 4)) /3;

    DELAY = 1000;

    row_1 = height/4 + 100;
    row_2 = height/4 + 150;
    row_3 = height/2;
    row_4 = height/4 + 200;
    row_5 = height/2 + 50;

    title_color = color(0, 255, 0);
    text_color  = 255;

    background(0);

    fill(title_color);
    textFont(game_font);
    textAlign(CENTER);
    textSize(125);
    fill(175);
    textFont(title_font);
    if (floor(millis()/DELAY) % 2 == 0) {
      fill(0, 0, 255);
    }
    text("SPACE SHOOTER", width/2, height/4-100);

    textSize(50);
    textFont(game_font);
    fill(0, 100, 255);
    text("CLICK TO START", width/2, height/4);

    fill(text_color);
    textSize(25);
    text("ARROW KEYS FOR DIRECTIONAL CONTROL", width/2, height/4+50);
    text("SPACEBAR = FIRE", width/2, row_1);
    fill(0, 255, 0);
    text("PLEASE ENTER YOUR INITIALS", width/2, row_2);

    for (int i = 0; i < 3; i++) {
      int x = outer_gap + (line_width + inner_gap) * i;
      int y = height/2-75;

      fill(255, 175, 125);
      textSize(65);
      if (cursor > i)
        text(initials[i], x + line_width/2, y);
    }

    display_score_data();
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
    add_star();
    add_asteroid();
    add_enemy();
    remove_dead_star(stars);
    remove_dead_burst(burst);
    remove_dead_asteroid(actors);
    remove_dead_s_bullet(s_bullet_list);
    remove_dead_e_bullet(e_bullet_list);
    remove_dead_enemy(enemy_list);
    remove_hit_enemy(enemy_list);
    asteroid_difficulty();
    show_statistics();
    //println("play has executed.........");
  }
  void game_reset() {
    Ship ship = (Ship) actors.get(0);
    state = g_play;
    game.efficiency = 0;
    ship.c_health = 100;
    enemies_killed = 0;
    enemy_list.clear();
    println("enemy_list............." + enemy_list.size());
    //actors.clear();
  }
  void game_over() {
    float column_1, column_2, row_1, row_2, row_3;
    int title_color, text_color;

    title_color = color(255, 0, 0);
    text_color = 255;

    efficiency = (enemies_killed/enemy_count)*100;

    column_1 = width/4;
    column_2 = width* .75-100;
    row_1 = height/2 - 200;
    row_2 = height/2 - 150;
    row_3 = height/2 - 100;

    background(0);

    fill(title_color);
    textFont(game_font);
    textAlign(CENTER);
    text("GAME OVER", width/2, 250);
    fill(0, 0, 255);
    text("PRESS S TO SAVE OR Q TO QUIT", width/2, 350);
    fill(text_color);
    textSize(25);
    textAlign(LEFT);
    text("ENEMIES KILLED", column_1, row_2);
    text(int(enemies_killed), column_2, row_2);
    text("EFFICIENCY", column_1, row_3);
    text(int(efficiency), column_2, row_3);
    text(" % ", column_2 + 50, row_3);
  }
}
