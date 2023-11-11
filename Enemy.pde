ArrayList <Enemy> enemy_list = new ArrayList<Enemy>();
float last_enemy = 0;
float enemy_timer = 5000;
float last_burst = 0;
float enemy_fire_interval = 1000;
float enemies_killed = 0;
float enemy_count = 0;

class Enemy extends PVector {
  int _length, _width, x_speed, y_speed, enemy_color;
  float x, y;
  boolean hit;
  Enemy() {
  }
  Enemy setPosition(float x_, float y_) {
    x = x_;
    y = y_;
    return this;
  }
  Enemy setDimension(int _length_, int _width_) {
    _length = _length_;
    _width = _width_;
    return this;
  }
  Enemy setSpeed(int x_speed_, int y_speed_) {
    x_speed = x_speed_;
    y_speed = y_speed_;
    return this;
  }
  Enemy setColor(color c) {
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
  boolean enemy_fire() {
    float c_time = millis();
    float d_time = c_time - last_burst;
    boolean state = false;
    if (last_burst == 0 || d_time >= enemy_fire_interval) {
      state = !state;
      last_burst = c_time;
    }
    println("led state is.........." + state);
    return state;
  }

  void move() {
    x -= x_speed;
    //println("enemy.move has executed");
  }
  void render() {
    push();
    if (hit) {
      fill(color(255, 0, 0));
    } else {
      fill(enemy_color);
    }
    rectMode(CENTER);
    rect(x, y, _length, _width);
    fill(255, 0, 0);
    ellipse(x, y, _length-5, _width-5);
    pop();
    //println("enemy.render has executed");
  }

  boolean isDead() {
    if (x <= _length*-1) {
      //println("enemy is dead");
      return true;
    } else {
      return false;
    }
  }
  boolean ship_in_range() {
    return true;
  }
}
void removeDeadEnemy(ArrayList<Enemy> enemy_list) {
  int lastIndex = enemy_list.size() - 1;
  for (int i = lastIndex; i > 0; i--) {
    if (enemy_list.get(i).isDead() == true) {
      enemy_list.remove(i);
      //println("enemy was removed");
    }
  }
  //println("removeDeadEnemy has executed");
}
void removeHitEnemy(ArrayList<Enemy> enemy_list) {
  int lastIndex = enemy_list.size() - 1;
  for (int i = lastIndex; i >= 0; i--) {
    if (enemy_list.get(i).hit() == true) {
      enemy_list.remove(i);
      enemies_killed++;
      //println("enemies_killed......." + enemies_killed + '\n');
    }
  }
}
void addEnemy() {
  //println("enemy_list.........." + enemy_list.size());
  float c_time, d_time, random_x_speed;

  c_time = millis();
  d_time = c_time - last_enemy;
  random_x_speed = random(2, 7);

  if (last_enemy == 0 || d_time >= enemy_timer) {
    color enemy_color = color(255, 255, 0);
    Enemy enemy = new Enemy()
      .setPosition(int(width), int(random(height)))
      .setDimension(50, 50)
      .setSpeed(int(random_x_speed), 0)
      .setColor(enemy_color);
    enemy_list.add(enemy);
    enemy_count++;
    last_enemy = c_time;
  }
  //println("enemy_count......" + enemy_count + '\n');
}
void remove_dead_e_bullet(ArrayList<Bullet> e_bullet_list) {
  int lastIndex = e_bullet_list.size() - 1;
  for (int i = lastIndex; i > 0; i--) {
    if (e_bullet_list.get(i).isDead() == true) {
      e_bullet_list.remove(i);
      //println("e_bullet was removed........");
    }
  }
}
void add_E_bullet() {
  int lastIndex = enemy_list.size() - 1;
  for (int i = lastIndex; i >= 0; i--) {
    if (enemy_list.get(i).enemy_fire() == true) {
      float enemy_x = enemy_list.get(i).x;
      float enemy_y = enemy_list.get(i).y;
      e_bullet = new Bullet()
        .setPosition(enemy_x, enemy_y)
        .setDimension(9, 9)
        .setSpeed(-15, 0)
        .setColor(e_bullet_color);
      e_bullet_list.add(e_bullet);
      //println("e_bullet_list size.........." +e_bullet_list.size());
    }
  }
}
