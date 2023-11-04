ArrayList <Bullet> e_bullet_list = new ArrayList<Bullet>();
ArrayList <Bullet> s_bullet_list = new ArrayList<Bullet>();
Bullet e_bullet;
Bullet s_bullet;

color s_bullet_color = color(0,255,0);
color e_bullet_color = color(255,0,0);

class Bullet extends PVector {
  int _length, _width, x_speed, y_speed, s_bullet_color;
  float x, y;
  boolean hit_target = false;
  PVector s_bullet = new PVector();
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
    s_bullet_color = c;
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
      fill(s_bullet_color);
    }
    ellipse(x, y, _length, _width);
    pop();
  }
   void move() {
    x += x_speed;
    //y += y_speed;
  }
  
  //Test to see if the s_bullet has left the screen
  boolean isDead() {
    if (x >= width + _length) {
      //println("s_bullet is dead");
      return true;
    } else {
      return false;
    }
  }
}
//Methods outside the class
void removeDeadBullets(ArrayList<Bullet> s_bullet_list) {
  int lastIndex = s_bullet_list.size() - 1;
  for (int i = lastIndex; i > 0; i--) {
    if (s_bullet_list.get(i).isDead() == true) {
      s_bullet_list.remove(i);
      //println("bullet was removed........");
    }
  }
}
void add_S_bullet() {
  float ship_x = actors.get(0).x;
  float ship_y = actors.get(0).y;
  s_bullet = new Bullet()
    .setPosition(ship_x, ship_y)
    .setDimension(9, 9)
    .setSpeed(15, 0)
    .setColor(s_bullet_color);
  s_bullet_list.add(s_bullet);
}
