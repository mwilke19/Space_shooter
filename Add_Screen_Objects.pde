void add_ship() {
  ship = new Ship()
    .set_position(400, 200)
    .set_speed(4, 5)
    .set_color(WHITE)
    .set_size(100);
}
void add_planets() {
  int planet_start_position = width + 1200;
  planet = new Planets()
    .set_position(planet_start_position, y_center)
    .set_diameter(200)
    .set_velocity(-1.5, 0)
    .set_acceleration(.99)
    .set_friction(.99);
  planet_list.add(planet);
}
void add_game_images() {
  earth = loadImage("Earth_0.png");
  mars = loadImage("Mars.png");
  jupiter = loadImage("planet_0.png");
  saturn = loadImage("Saturn.png");
  uranus = loadImage("Uranus.png");
  neptune = loadImage("Neptune.png");
  asteroid = loadImage("Meteor.png");
  ship_image = loadImage("Fighter_09.png");
  enemy_image = loadImage("enemy_0.png");
  title_image = loadImage("Planetary_Defense.png");
  game_over_image  =  loadImage("Game_Over.png");
}
void add_fonts() {
  thirteen_pixel = createFont("Arial",13);//used on statistics
  twenty_five_pixel = createFont("Arial", 25);//used on basic screen text
  one_hundred_pixel = createFont("Arial Black", 100);//used on main title text
  seventy_five_pixel = createFont("Arial",75);//used on initials
  fifty_pixel = createFont("Arial Black",50);//used on secondary tite text
}
void add_asteroid() {
  float c_time, d_time;
  c_time = millis();
  d_time = c_time - last_asteroid;

  if (last_asteroid == 0 || d_time >= asteroid_timer) {
    Actor asteroid = new Asteroid()
      .set_position(int(width), int(random(height)))
      .set_size(int(random(20, 100)))
      .set_speed(-2, 2)
      .set_color(0);
    asteroid_list.add(asteroid);
    last_asteroid = c_time;
  }
}
void add_S_bullet() {
  float ship_x = ship.x;
  float ship_y = ship.y;
  int bullet_offset = 10;
  s_bullet = new Bullet()
    .set_position(ship_x, ship_y-bullet_offset)
    .setDimension(9, 9)
    .set_speed(15, 0)
    .set_color(s_bullet_color);
  s_bullet_list.add(s_bullet);
}
void add_enemy() {
  //println("enemy_list.........." + enemy_list.size());
  float c_time, d_time, random_x_speed;

  c_time = millis();
  d_time = c_time - last_enemy;
  random_x_speed = random(2, 7);

  if (last_enemy == 0 || d_time >= enemy_timer) {
    color enemy_color = RED;
    Enemy enemy = new Enemy()
      .set_position(int(width), int(random(height)))
      .setDimension(178, 350)
      .set_speed(int(random_x_speed), 0)
      .set_color(enemy_color);
    enemy_list.add(enemy);
    enemy_count++;
    last_enemy = c_time;
  }
  //println("enemy_count......" + enemy_count + '\n');
}
void add_E_bullet() {
  int last_index = enemy_list.size() - 1;
  for (int i = last_index; i >= 0; i--) {
    float enemy_x = enemy_list.get(i).x;
    float enemy_y = enemy_list.get(i).y;
    e_bullet = new Bullet()
      .set_position(enemy_x, enemy_y)
      .setDimension(9, 9)
      .set_speed(-8, 0)
      .set_color(e_bullet_color);
    e_bullet_list.add(e_bullet);
    //println("e_bullet_list size.........." +e_bullet_list.size());
  }
}
void add_explosion(float enemy_x, float enemy_y) {
  int MAX_SIZE = 500;

  while (explosion_list.size() <= MAX_SIZE) {
    noStroke();
    Particle red_explosion = new Explosion()
      .set_position(enemy_x, enemy_y)
      .set_length(20)
      .set_width(20)
      .set_velocity(-1, 1)
      .set_acceleration(1)
      .set_friction(.77)
      .set_color(RED)
      .set_lifespan(150);
    Particle yellow_explosion = new Explosion()
      .set_position(enemy_x, enemy_y)
      .set_length(20)
      .set_width(20)
      .set_velocity(-1, 1)
      .set_acceleration(1)
      .set_friction(.88)
      .set_color(YELLOW)
      .set_lifespan(150);
    explosion_list.add(red_explosion);
    explosion_list.add(yellow_explosion);
  }
}
void add_star() {
  float c_time, d_time;
  c_time = millis();
  d_time = c_time-last_star;

  if (last_star == 0 || d_time >= star_timer) {
    //println(star_list.size());
    Particle star = new Particle()
      .set_position(random(width), random(height))
      .set_diameter(int(random(1, 5)))
      .set_velocity(-1, 1)
      .set_acceleration(.5)
      .set_friction(.99)
      .set_color(WHITE)
      .set_lifespan(500);
    star_list.add(star);
    last_star = c_time;
  }
}
