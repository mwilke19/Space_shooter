ArrayList <Enemy> enemies = new ArrayList<Enemy>();
float last_enemy = 0;
float enemy_timer = 10000;
int enemy_count = 0;

class Enemy extends PVector {
  int _length, _width, x_speed, y_speed, enemy_color;
  float x, y;
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
    move(enemies);
    show();
  }
  void move(ArrayList<Enemy> enemies) {
    x -= x_speed;
    //println("enemy.move has executed");
  }
  void show() {
    push();
    fill(enemy_color);
    rect(x, y, _length, _width);
    pop();
    //println("enemy.show has executed");
  }
  boolean isDead() {
    if (x <= _length) {
      println("enemy is dead");
      return true;
    } else {
      return false;
    }
  }
}
void removeDeadEnemy(ArrayList<Enemy> enemies) {
  int lastIndex = enemies.size() - 1;
  for (int i = lastIndex; i > 0; i--) {
    if (enemies.get(i).isDead() == true) {
      enemies.remove(i);
      println("enemy was removed");
    }
  }
  //println("removeDeadEnemy has executed");
}
void addEnemy() {
  //println("enemies.........." + enemies.size());
  float c_time, d_time;
  c_time = millis();
  d_time = c_time - last_enemy;
  if (last_enemy == 0 || d_time >= enemy_timer) {
    color enemy_color = color(255,255,0);
    Enemy enemy = new Enemy()
      .setPosition(int(width), int(random(height)))
      .setDimension(50,50)
      .setSpeed(2,0)
      .setColor(enemy_color);
    enemies.add(enemy);
    last_enemy = c_time;
  }
  //println("addEnemy has executed");
}
