class Game_Window {
  int g_start, g_play, g_over, g_play_again, state;
  int test_score;
  float x_center, y_center;
  float efficiency, one_second_delay, half_second_delay;
  float current_score, previous_score;
  boolean is_high_score;
  int outer_gap = 425; // 475px of space on left and right
  int inner_gap = 30;  // 30px between letters
  int total_width = width - (outer_gap * 2);
  int line_width = (total_width - (inner_gap * 4)) /3;

  Game_Window() {
    g_start = 0;
    g_play = 10;
    g_over = 20;
    x_center = width/2;
    y_center = height/2;
    state = g_start;
    one_second_delay = 1000;
    half_second_delay = 500;
    is_high_score = false;
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
        text("YOU MUST ENTER YOUR INITIALS TO PLAY", width/2, height/2+50);
        pop();
      }
    }
    if (ship_dead == true) {
      state = g_over;
    }
    //println("state.........." + state);
    //println("ship_dead......" + ship_dead);
  }
  boolean is_it_a_high_score() {
    current_score = enemies_killed;
    for (int i = 0; i<score_array.length; i++) {
      int high_score = score_array[0];
      if (high_score<current_score) {
        is_high_score = true;
      } else {
        is_high_score = false;
      }
    }
    return (is_high_score);
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
    //println(score_data.getRowCount());

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
      int y = height/2 + 200 + (50 * i);

      push();
      textAlign(CENTER);
      textFont(twenty_five_pixel);
      text(name, x_center - 50, y);
      text(score, x_center + 50, y);
      pop();
    }
  }
  void game_start() {
    int image_height = height;
    int image_width = width;
    
    background(0);
    push();
    imageMode(CORNER);
    image(title_image,-50,0,image_width,image_height);
    pop();
    render_start_screen_text();
  }
  void game_over() {
    background(0);
    is_it_a_high_score();
    render_game_over_text();
  }
  void game_play() {
    for (Particle star : star_list) {
      star.run();
    }
    for (Planets planet : planet_list) {
      planet.run();
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
    for (Particle explosion : explosion_list) {
      explosion.run();
    }
    add_star();
    add_asteroid();
    add_enemy();
    ship.run();
    remove_dead_star(star_list);
    remove_dead_explosion(explosion_list);
    remove_dead_asteroid(asteroid_list);
    remove_dead_planet(planet_list);
    remove_dead_s_bullet(s_bullet_list);
    remove_dead_e_bullet(e_bullet_list);
    remove_dead_enemy(enemy_list);
    remove_hit_enemy(enemy_list);
    asteroid_difficulty();
    render_statistics();
    //println("play has executed.........");
  }
  void render_initials() {
    int outer_gap = 700; // 700px of space on left and right
    int inner_gap = 30;  // 30px between letters
    int total_width = width - (outer_gap * 2);
    int line_width = (total_width - (inner_gap * 4)) /3;

    for (int i = 0; i < 3; i++) {//draws the initials and cursor

      int x = outer_gap + (line_width + inner_gap) * i;
      int y = height/2+75;

      fill(WHITE);
      textFont(seventy_five_pixel);
      if (cursor > i)
        text(initials[i], x + line_width/2, y);
      if (cursor == i && floor(millis() / half_second_delay) % 2 == 0)
        fill(0, 255, 0);
      rect(x, y - 5, line_width, 10);
    }
  }
  void render_statistics() {
    push();
    fill(WHITE);
    textFont(thirteen_pixel);
    text("SCORE:", 45, 50);
    text(int(enemies_killed), 120, 50);
    pop();
    ship.render_health_bar();
  }
  void render_start_screen_text() {
    
    float text_row_1, text_row_2, text_row_3, text_row_4;
   
    text_row_1 = height/4 + 150;
    text_row_2 = height/4+ 200;
    text_row_3 = height/4 + 250;
    text_row_4 = height/4;

    push();
    textFont(fifty_pixel);
    fill(GREEN);
    text("CLICK TO START", x_center, text_row_1);
    pop();

    push();
    fill(WHITE);
    textFont(twenty_five_pixel);
    text("ARROW KEYS FOR DIRECTIONAL CONTROL", x_center, text_row_2);
    text("SPACEBAR = FIRE", x_center, text_row_3);
    pop();

    push();
    fill(255, 255, 0);
    textFont(fifty_pixel);
    text("TOP SCORES", x_center, y_center+175);
    stroke(255, 0, 0);
    pop();
    render_initials();
    display_score_data();
  }
  void render_game_over_text() {
    float name_col, data_col;
    float text_row_1, high_score_output_row;
    float one_sec_delay = 1000;
    int image_width   = width;
    int image_height = height;
    efficiency = (enemies_killed/enemy_count)*100;

    name_col = width/4;
    data_col = width* .75-100;
    high_score_output_row = height/2-75;
    text_row_1 = height/2 ;
    row_3 = height/2 + 100;

    push();
    imageMode(CORNER);
    image(game_over_image,0,0,image_width,image_height);
    pop();

    if (is_high_score == true) {
      push();
      textFont(fifty_pixel);
      fill(GREEN);
      if (floor(millis()/one_sec_delay) % 2 == 0) {
      fill(YELLOW);
      }
      text("YOU ROCK!! THIS IS A HIGH SCORE", x_center, high_score_output_row);
      pop();
    }
    if (is_high_score == false) {
      push();
      textFont(fifty_pixel);
      fill(RED);
      if (floor(millis()/one_sec_delay) % 2 == 0) {
      fill(BLUE);
    }
      text("GOOD TRY!! DONT GIVE UP", x_center, high_score_output_row);
      pop();
    }

    push();
    fill(WHITE);
    textAlign(LEFT, BOTTOM);
    text("ENEMIES KILLED", name_col, text_row_1);
    text(int(enemies_killed), data_col, text_row_1);
    text("EFFICIENCY", name_col, row_3);
    text(int(efficiency), data_col, row_3);
    text(" % ", data_col + 65, row_3);
    pop();
  }
}
