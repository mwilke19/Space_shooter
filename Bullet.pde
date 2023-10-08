ArrayList <Bullet> bullet_list = new ArrayList<Bullet>();
Bullet bullet;
color bullet_color = color(255);
class Bullet extends PVector {
  int _length, _width, x_speed, y_speed, bullet_color;
  float x, y;
  boolean hit_target = false;
  PVector bullet = new PVector();
  PVector enemy = new PVector();
  Bullet() {
    super();
  }
  Bullet setPosition(float x_, float y_) {
    x = x_;
    y = y_;
    return this;
  }
  Bullet setDimension(int _length_, int _width_) {
    _length = _length_;
    _width = _width_;
    return this;
  }
  Bullet setSpeed(int x_speed_, int y_speed_) {
    x_speed = x_speed_;
    y_speed = y_speed_;
    return this;
  }
  Bullet setColor(color c) {
    bullet_color = c;
    return this;
  }
  void run() {
    move(bullet_list);
    render();
    //hit_target(enemy_list);
  }
  //Draws asteroid to the screen
  void render() {
    push();
    if (hit_target) {
      fill(color(255, 0, 0));
    } else {
      fill(bullet_color);
    }
    ellipse(x, y, _length, _width);
    pop();
  }
   void move(ArrayList<Bullet> bullet_list) {
    x += x_speed;
    //y += y_speed;
  }
  //Tests for a collision between bullet and an enemy
  //boolean check_collision(Enemy enemy_list) {
  //  PVector bullet = new PVector(this.x,this.y);
  //  PVector enemy = new PVector(enemy_list.x,enemy_list.y);
  //  float dist = PVector.dist(bullet,enemy)-(this._length +enemy_list._length);
  //  return(dist <= 0);
  //}
  // void hit_target(ArrayList<Enemy> enemy_list) {
  //  hit_target = false;
  //    for (Enemy Enemy : enemy_list) {
  //      if (check_collision(Enemy)){
  //        hit_target = true;
  //        println("Enemy has been hit");
  //      }
  //    }
    
  //}
  //Test to see if the bullet has left the screen
  boolean isDead() {
    if (x >= width + _length) {
      //println("bullet is dead");
      return true;
    } else {
      return false;
    }
  }
}
//Methods outside the class
void removeDeadBullets(ArrayList<Bullet> bullet_list) {
  int lastIndex = bullet_list.size() - 1;
  for (int i = lastIndex; i > 0; i--) {
    if (bullet_list.get(i).isDead() == true) {
      bullet_list.remove(i);
      println("bullet was removed........");
    }
  }
}
void addBullet() {
  bullet = new Bullet()
    .setPosition(actors.get(0).x, actors.get(0).y)
    .setDimension(9, 9)
    .setSpeed(15, 0)
    .setColor(255);
  bullet_list.add(bullet);
}
