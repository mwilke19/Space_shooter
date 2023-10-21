ArrayList <Enemy> enemy_list = new ArrayList<Enemy>();
float last_enemy = 0;
float enemy_timer = 5000;
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
  }
  boolean check_distance(Bullet bullet_list) {
    PVector enemy = new PVector(this.x, this.y);
    PVector bullet = new PVector(bullet_list.x, bullet_list.y);
    float dist = PVector.dist(bullet, enemy)-(this._length + bullet_list._length);
    return(dist <= 0);
  }
  boolean hit() {
    hit = false;
    for (Bullet bullet : bullet_list) {
      if (check_distance(bullet)) {
        hit = true;
        //println("you are hit");
      }
    }
    return hit;
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
    rect(x, y, _length, _width);
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
  float c_time, d_time;
  c_time = millis();
  d_time = c_time - last_enemy;
  if (last_enemy == 0 || d_time >= enemy_timer) {
    color enemy_color = color(255, 255, 0);
    Enemy enemy = new Enemy()
      .setPosition(int(width), int(random(height)))
      .setDimension(50, 50)
      .setSpeed(2, 0)
      .setColor(enemy_color);
    enemy_list.add(enemy);
    enemy_count++;
    last_enemy = c_time;
  }
  //println("enemy_count......" + enemy_count + '\n');
}
