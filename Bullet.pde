ArrayList <Bullet> bullets = new ArrayList<Bullet>();
Bullet bullet;
//color bullet_color = color(255);
class Bullet extends PVector {
  int _length, _width, x_speed, y_speed, bullet_color;
  float x, y;
  boolean hit_target = false;
  Bullet() {
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
  //Tests for a collision between bullet and an enemy
  boolean checkHit(Enemy enemies) {
    float dist = PVector.dist(this, enemies)-(this._length + enemies._length);
    println("enemy dist................." + dist);
    println(this._length - enemies._length);
    return(dist <= 0);
  }
  void run() {
    move(bullets);
    show();
    hitTarget(bullets);
  }
  void move(ArrayList<Bullet> bullets) {
    x += x_speed;
    //y += y_speed;
  }
  //Draws asteroid to the screen
  void show() {
    push();
    if (hit_target) {
      fill(color(255, 0, 0));
    } else {
      fill(bullet_color);
    }
    ellipse(x, y, _length, _width);
    pop();
  }
  void hitTarget(ArrayList<Bullet> bullets) {
    hit_target = false;

    for ( Bullet Bullet : bullets) {
      if (Bullet == this) {
        continue;
      }
      for (Enemy Enemy : enemies) {
        if (!hit_target && checkHit(Enemy)) {
          hit_target = true;
          println("bullet has hit a target");
        }
      }
    }
  }
  //Test to see if the asteroid has left the screen
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
void removeDeadBullets(ArrayList<Bullet> bullets) {
  int lastIndex = bullets.size() - 1;
  for (int i = lastIndex; i > 0; i--) {
    if (bullets.get(i).isDead() == true) {
      bullets.remove(i);
      //println("bullet was removed........");
    }
  }
}
void addBullet() {
  bullet = new Bullet()
    .setPosition(actors.get(0).x, actors.get(0).y)
    .setDimension(9, 9)
    .setSpeed(15, 0)
    .setColor(255);
  bullets.add(bullet);
}
