ArrayList <Enemy> enemy_list = new ArrayList<Enemy>();
float last_enemy = 0;
float enemy_timer = 5000;
int fire_interval = 75;
int burst_interval = 1000;
float enemies_killed = 0;
float enemy_count = 0;

class Enemy extends PVector {
  int _length, _width, x_speed, y_speed, enemy_color;
  float x, y;
  int last_burst, last_fire;
  int bullet_count = 5;
  boolean hit;

  Enemy() {
    bullet_count = 0;
    last_burst = 0;
    last_fire = 0;
  }
  Enemy set_position(float x_, float y_) {
    x = x_;
    y = y_;
    return this;
  }
  Enemy setDimension(int _length_, int _width_) {
    _length = _length_;
    _width = _width_;
    return this;
  }
  Enemy set_speed(int x_speed_, int y_speed_) {
    x_speed = x_speed_;
    y_speed = y_speed_;
    return this;
  }
  Enemy set_color(color c) {
    enemy_color = c;
    return this;
  }
  void run() {
    move();
    render();
    hit();
    enemy_fire();
  }
  boolean check_distance(Bullet s_bullet_list) {
    PVector enemy = new PVector(this.x, this.y);
    PVector s_bullet = new PVector(s_bullet_list.x, s_bullet_list.y);
    float dist = PVector.dist(s_bullet, enemy)-(this._length + s_bullet_list._length);
    return(dist <= 0);
  }
  boolean hit() {
    hit = false;
    for (Bullet s_bullet : s_bullet_list) {
      if (check_distance(s_bullet)) {
        hit = true;
        //println("you are hit");
      }
    }
    return hit;
  }
  void enemy_fire() {
    int c_time = millis();
    int burst_d_time = c_time - last_burst;
    int fire_d_time = c_time - last_fire;
    //println("Millis:", c_time, "Last burst:", last_burst, "D Time:", burst_d_time);
    if (burst_d_time < burst_interval) {
      if (fire_d_time > fire_interval && bullet_count > 0) {
        last_fire = c_time;
        add_E_bullet();
        --bullet_count;
        //println(bullet_count);
      }
    } else {
      last_burst = c_time;
      bullet_count = 3;
    }
  }

  void move() {
    x -= x_speed;
    //println("enemy.move has executed");
  }
  void render() {
    push();
    stroke(3);
    fill(YELLOW);
    rectMode(CENTER);
    rect(x, y, _length, _width);
    fill(RED);
    ellipse(x, y, _length-5, _width-5);
    pop();
    //println("enemy.render has executed");
  }

  boolean is_dead() {
    if (x <= _length*-1) {
      //println("enemy is dead");
      return true;
    } else {
      return false;
    }
  }
}
void remove_dead_enemy(ArrayList<Enemy> enemy_list) {
  int last_index = enemy_list.size() - 1;
  for (int i = last_index; i > 0; i--) {
    if (enemy_list.get(i).is_dead() == true) {
      enemy_list.remove(i);
      //println("enemy was removed");
    }
  }
  //println("removeDeadEnemy has executed");
}
void remove_hit_enemy(ArrayList<Enemy> enemy_list) {
  int last_index = enemy_list.size() - 1;
  for (int i = last_index; i >= 0; i--) {
    if (enemy_list.get(i).hit() == true) {
      
      float enemy_x = enemy_list.get(i).x;
      float enemy_y = enemy_list.get(i).y;

      enemy_list.remove(i);
      add_burst(enemy_x,enemy_y);
      enemies_killed++;
      //println("enemies_killed......." + enemies_killed + '\n');
    }
  }
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
      .setDimension(50, 50)
      .set_speed(int(random_x_speed), 0)
      .set_color(enemy_color);
    enemy_list.add(enemy);
    enemy_count++;
    last_enemy = c_time;
  }
  //println("enemy_count......" + enemy_count + '\n');
}
void remove_dead_e_bullet(ArrayList<Bullet> e_bullet_list) {
  int last_index = e_bullet_list.size() - 1;
  for (int i = last_index; i > 0; i--) {
    if (e_bullet_list.get(i).is_dead() == true) {
      e_bullet_list.remove(i);
      //println("e_bullet was removed........");
    }
  }
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
