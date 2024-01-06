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
    boolean ship_dead = ship.is_dead();

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
        push();
        textFont(twenty_five_pixel);
        fill(RED);
        text("YOU MUST ENTER YOUR INITIALS TO PLAY", width/2, height/2-100);
        pop();
      }
    }
    if (ship_dead == true) {
      state = g_over;
    }
    //println("state.........." + state);
    //println("ship_dead......" + ship_dead);
  }
  void load_score_data() {
    score_data = loadTable("score_data.csv", "header");
    score_data.setColumnType("SCORE", Table.FLOAT);
    score_data.sortReverse(1);
  }
  void save_score_data() {
    saveTable(score_data, "data/score_data.csv");
  }
  void add_new_score() {
    TableRow new_score = score_data.addRow();
    String name = new String(initials);
    float score = enemies_killed;

    new_score.setString("NAME", name);
    new_score.setFloat("SCORE", score);
    println(score_data.getRowCount());

    save_score_data();
    //println("add_new_data executed");
  }
  void create_score_table() {
    score_data = new Table();
    score_data.addColumn("NAME");
    score_data.addColumn("SCORE");
  }
  void display_score_data() {
    //println(score_data.getRowCount() + " total rows in table");
    for (int i = 0; i < score_data.getRowCount(); i++) {
      TableRow row = score_data.getRow(i);
      String name = row.getString("NAME");
      int score = row.getInt("SCORE");
      int y = height/2 + 50 + (50 * i);

      push();
      textFont(twenty_five_pixel);
      text(name, width/4 + 250, y);
      text(score, width/4 + 400, y);
      pop();
    }
  }
  void game_start() {
    background(0);
    render_start_screen_text();
  }
  void game_over() {
    background(0);
    render_game_over_text();
  }
  void game_play() {
    for (Particle explosion : burst_list) {
      explosion.run();
    }
    for (Particle star : star_list) {
      star.run();
    }
    for (Actor actor : asteroid_list) {
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
    ship.run();
    remove_dead_star(star_list);
    remove_dead_burst(burst_list);
    remove_dead_asteroid(asteroid_list);
    remove_dead_s_bullet(s_bullet_list);
    remove_dead_e_bullet(e_bullet_list);
    remove_dead_enemy(enemy_list);
    remove_hit_enemy(enemy_list);
    asteroid_difficulty();
    show_statistics();
    //println("play has executed.........");
  }
  void render_initials() {
    int outer_gap = 425; // 475px of space on left and right
    int inner_gap = 30;  // 30px between letters
    int total_width = width - (outer_gap * 2);
    int line_width = (total_width - (inner_gap * 4)) /3;

    for (int i = 0; i < 3; i++) {//draws the initials and cursor
      int x = outer_gap + (line_width + inner_gap) * i;
      int y = height/2-75;

      fill(WHITE);
      textFont(fifty_pixel);
      if (cursor > i)
        text(initials[i], x + line_width/2, y);
      if (cursor == i && floor(millis() / DELAY) % 2 == 0)
        fill(0, 255, 0);
      rect(x, y - 5, line_width, 10);
    }
  }
  void render_start_screen_text(){
    float row_1, row_2, row_3, row_4, row_5;

    DELAY = 1000;

    row_1 = height/4 + 100;
    row_2 = height/4 + 150;
    row_3 = height/2;
    row_4 = height/4 + 200;
    row_5 = height/2 + 50;
    
     push();
    fill(GREEN);
    textFont(twenty_five_pixel);
    textAlign(CENTER);
    fill(BLUE);
    textFont(one_hundred_pixel);
    if (floor(millis()/DELAY) % 2 == 0) {
      fill(RED);
    }
    text("SPACE SHOOTER", width/2, height/4-100);
    pop();

    push();
    textFont(fifty_pixel);
    fill(GREEN);
    text("CLICK TO START", width/2, height/4);
    pop();

    push();
    fill(WHITE);
    textFont(twenty_five_pixel);
    text("ARROW KEYS FOR DIRECTIONAL CONTROL", width/2, height/4+50);
    text("SPACEBAR = FIRE", width/2, row_1);
    fill(GREEN);
    text("PLEASE ENTER YOUR INITIALS", width/2, row_2);
    pop();

    push();
    fill(255, 255, 0);
    textFont(fifty_pixel);
    text("TOP SCORES", width/2, height/2);
    stroke(255, 0, 0);
    line(width/4, height/2+5, 900, height/2+5);
    noFill();
    stroke(255, 255, 0);
    rect(50, 50, 1200, 900);
    noStroke();
    pop();
    
    render_initials();
    display_score_data();
  }
  void render_game_over_text(){
    
     float column_1, column_2, row_1, row_2, row_3;

    efficiency = (enemies_killed/enemy_count)*100;

    column_1 = width/4;
    column_2 = width* .75-100;
    row_1 = height/2 - 200;
    row_2 = height/2 - 150;
    row_3 = height/2 - 100;
    push();
    fill(RED);
    textFont(one_hundred_pixel);
    if (floor(millis()/DELAY) % 2 == 0) {
      fill(YELLOW);
    }
    text("GAME OVER", width/2, 250);
    pop();

    push();
    textFont(twenty_five_pixel);
    fill(BLUE);
    text("PRESS 'S' TO SAVE OR 'Q' TO QUIT", width/2, 350);
    fill(WHITE);
    textAlign(LEFT, BOTTOM);
    text("ENEMIES KILLED", column_1, row_2);
    text(int(enemies_killed), column_2, row_2);
    text("EFFICIENCY", column_1, row_3);
    text(int(efficiency), column_2, row_3);
    text(" % ", column_2 + 50, row_3);
    pop();
  }
}
