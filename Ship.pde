class Ship extends Actor {
  float c_health, p_health;
  float bar_width, g_bar_length, r_bar_length;
  float ship_length, nose_x, nose_y, ship_top, ship_bottom;
  boolean hit, shot;
  Ship() {
    super();
    c_health = 150;
    p_health = 0;
  }
  void move(ArrayList<Actor> actors) {
    //Moves ship
    if (keyPressed) {
      switch(key) {
      case 'w':
      case 'W'://north
        y -= y_speed;
        break;
      case 's':
      case 'S'://south
        y += y_speed;
        break;
      case 'a':
      case 'A'://east
        x -= x_speed;
        break;
      case 'd':
      case 'D':
        ;//west
        x += x_speed;
        break;
      case 'q':
      case 'Q'://northwest
        x -= x_speed;
        y -= y_speed;
        break;
      case 'e':
      case 'E'://northeast
        x += x_speed;
        y -= y_speed;
        break;
      case 'z':
      case 'Z'://northwest
        x -= x_speed;
        y += y_speed;
        break;
      case 'c':
      case 'C'://northwest
        x += x_speed;
        y += y_speed;
        break;
      case 'x':
      case 'X':
        //add_E_bullet();//Test button to make the enemy fire a bullet
        break;
      case ' '://fire s_bullet
        add_S_bullet();
        break;
      }
    }
  }
  void screen_boundary() {
    //Stops ship on the edge of screen
    if (x < 100)x = 100;
    if (x > width)x = width;

    //Allows ship to exit screen and wrap to the opposite side
    if (y > height || y < 0) {
      if (y < 0) {
        y = height;
      } else {
        y = 0;
      }
    }
  }
  boolean check_E_distance(Enemy enemy_list) {
    float ship_x = actors.get(0).x;
    float ship_y = actors.get(0).y;
    float ship_length = actors.get(0).size;
    PVector ship = new PVector(ship_x, ship_y);
    PVector enemy = new PVector(enemy_list.x, enemy_list.y);
    float dist = PVector.dist(ship, enemy)-(ship_length/10 + enemy_list._length);
    //println("distance........" + dist);
    return(dist <= 0);
  }
  boolean check_E_bullet_distance(Bullet e_bullet_list) {
    float ship_x = actors.get(0).x;
    float ship_y = actors.get(0).y;
    float ship_length = actors.get(0).size;
    PVector ship = new PVector(ship_x, ship_y);
    PVector enemy_bullet = new PVector(e_bullet_list.x, e_bullet_list.y);
    float dist = PVector.dist(ship, enemy_bullet)-(ship_length/10 + e_bullet_list._length);
    //println("enemy_bullet distance.........." + dist);
    return(dist<=0);
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
    //Name triangle vertices
    ship_length = x - 100;
    nose_x = x;
    nose_y = y;
    ship_top = y - 10;
    ship_bottom = y + 10;
    //Draw ship to the screen
    push();
    if (collision || hit || shot) {
      fill(color(255, 0, 0));
    } else {
      fill(_color);
    }
    triangle(ship_length, ship_bottom, nose_x, nose_y, ship_length, ship_top);
    pop();
  }
  void health() {
    //Decreases health when a collision is occuring
    if (collision || hit || shot) {
      c_health--;
      p_health = c_health;
      //println("Your health went down");
      //println("Current health..........." + c_health);
    }
  }
  boolean isDead() {
    //Test to see if the ship health has run out
    if (c_health<=0) {
      //println("the ship is dead");
      return true;
    } else {
      return false;
    }
  }
  void renderHealthBar() {
    //Draws health bars to the screen
    g_bar_length = c_health;
    r_bar_length = 150;
    bar_width = 10;
    fill(255);
    textFont(font, 12.5);
    text("HEALTH:", 45, 25);
    fill(255, 0, 0);
    rect(115, 15, r_bar_length, bar_width);
    fill(0, 255, 0);
    rect(115, 15, g_bar_length, bar_width);
  }
}
