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
    move();
    render();
    
  }
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
   void move() {
    x += x_speed;
    //y += y_speed;
  }
  
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
      //println("bullet was removed........");
    }
  }
}
void addBullet() {
  float ship_x = actors.get(0).x;
  float ship_y = actors.get(0).y;
  bullet = new Bullet()
    .setPosition(ship_x, ship_y)
    .setDimension(9, 9)
    .setSpeed(15, 0)
    .setColor(255);
  bullet_list.add(bullet);
}
