ArrayList <Bullet> e_bullet_list = new ArrayList<Bullet>();
ArrayList <Bullet> s_bullet_list = new ArrayList<Bullet>();
Bullet e_bullet;
Bullet s_bullet;

color s_bullet_color = color(120,0,255);
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
  Bullet set_position(float x_, float y_) {
    x = x_;
    y = y_;
    return this;
  }
  Bullet setDimension(int _length_, int _width_) {
    _length = _length_;
    _width = _width_;
    return this;
  }
  Bullet set_speed(int x_speed_, int y_speed_) {
    x_speed = x_speed_;
    y_speed = y_speed_;
    return this;
  }
  Bullet set_color(color c) {
    s_bullet_color = c;
    return this;
  }
  void run() {
    move();
    render();
  }
  void render() {
    push();    
    fill(s_bullet_color);
    ellipse(x, y, _length, _width);
    pop();
  }
   void move() {
    x += x_speed;
  }
  boolean is_dead() {
    if (x >= width + _length || x <= _length) {
      //println("s_bullet is dead");
      return true;
    } else {
      return false;
    }
  }
}
