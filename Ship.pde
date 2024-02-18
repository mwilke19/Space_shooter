class Ship extends Actor {
  float c_health, p_health;
  float bar_width, g_bar_length, r_bar_length;
  float ship_length,ship_height, ship_x, ship_y;
  boolean hit, shot, collsion;
  Ship() {
    super();
    c_health = 100;
    p_health = 0;
  }
  void run() {
    move();
    screen_boundary();
    render();
    render_health_bar();
    hit();
    collision();
    shot();
    health();
  }
  void move() {
    if (keyPressed) {
      if (key == CODED) {
        if (keyCode == UP) {
          y -= y_speed;
        }
        if (keyCode == DOWN) {
          y += y_speed;
        }
        if (keyCode == LEFT) {
          x -= x_speed;
        }
        if (keyCode == RIGHT) {
          x += x_speed;
        }
      }

      switch(key) {
      case 'x':
      case 'X':
        //spare button
        break;
      case ' '://fire s_bullet
        add_S_bullet();
        break;
      }
    }
  }
  void screen_boundary() {
    if (x < 100)x = 100;
    if (x > width)x = width;

    if (y > height || y < 0) {
      if (y < 0) {
        y = height;
      } else {
        y = 0;
      }
    }
  }
  boolean check_A_distance(Actor asteroid_list) {
    float ship_x = ship.x;
    float ship_y = ship.y;
    float ship_length = ship.size;
    PVector ship = new PVector(ship_x, ship_y);
    PVector asteroid = new PVector(asteroid_list.x, asteroid_list.y);
    float dist = PVector.dist(ship, asteroid)-(ship_length/10 + asteroid_list.size);
    //println("distance........" + dist);
    return (dist <= 0);
  }
  boolean check_E_distance(Enemy enemy_list) {
    float ship_x = ship.x;
    float ship_y = ship.y;
    float ship_length = ship.size;
    PVector ship = new PVector(ship_x, ship_y);
    PVector enemy = new PVector(enemy_list.x, enemy_list.y);
    float dist = PVector.dist(ship, enemy)-(ship_length/10 + enemy_list._length);
    //println("distance........" + dist);
    return(dist <= 0);
  }
  boolean check_E_bullet_distance(Bullet e_bullet_list) {
    float ship_x = ship.x;
    float ship_y = ship.y;
    float ship_length = ship.size;
    PVector ship = new PVector(ship_x, ship_y);
    PVector enemy_bullet = new PVector(e_bullet_list.x, e_bullet_list.y);
    float dist = PVector.dist(ship, enemy_bullet)-(ship_length/10 + e_bullet_list._length);
    //println("enemy_bullet distance.........." + dist);
    return(dist<=0);
  }
  boolean collision() {
    collision = false;
    for (Actor asteroid : asteroid_list) {
      if (check_A_distance(asteroid)) {
        collision = true;
      }
    }
    return collision;
  }
  boolean hit() {
    hit = false;
    for (Enemy enemy : enemy_list) {
      if (check_E_distance(enemy)) {
        hit = true;
        //println("you are hit");
      }
    }
    return hit;
  }
  boolean shot() {
    shot = false;
    for (Bullet e_bullet : e_bullet_list) {
      if (check_E_bullet_distance(e_bullet)) {
        shot = true;
        //println("you are shot");
      }
    }
    return shot;
  }
  void render() {
    ship_length = 500;
    ship_height = 500;
    ship_x = x;
    ship_y = y;
    push();
    if (collision || hit || shot) {
      fill(RED);
    } else {
      stroke(2);
      fill(WHITE);
    }
    image(ship_image,ship_x,ship_y,ship_length,ship_height);
    pop();
  }
  void health() {
    if (collision || hit || shot) {
      c_health-=1;
      p_health = c_health;
      //println("Your health went down");
      //println("Current health..........." + c_health);
    }
  }
  boolean is_dead() {
    if (c_health<=0) {
      //println("the ship is dead");
      return true;
    } else {
      return false;
    }
  }
  void render_health_bar() {
    g_bar_length = c_health;
    r_bar_length = 100;
    bar_width = 10;
    push();
    fill(WHITE);
    textFont(thirteen_pixel);
    text("HEALTH:", 45, 25);
    fill(RED);
    rect(115, 15, r_bar_length, bar_width);
    fill(GREEN);
    rect(115, 15, g_bar_length, bar_width);
    pop();
  }
}
