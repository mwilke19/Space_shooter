ArrayList<Particle> star_list = new ArrayList<Particle>();
float last_star = 0;
float star_timer = 15;
class Particle {
  float x, y;
  float x_vel, y_vel, frict, accel;
  int d, _length, _width, lifespan;
  color _color = color(WHITE);

  Particle() {
  }
  Particle set_position( float x_, float y_) {
    x = x_;
    y = y_;
    return this;
  }
  Particle set_diameter(int d_) {
    d = d_;
    return this;
  }
  Particle set_length (int length_) {
    _length = length_;
    return this;
  }
  Particle set_width ( int width_) {
    _width = width_;
    return this;
  }
  Particle set_velocity(float x_vel_, float y_vel_) {
    x_vel = x_vel_;
    y_vel = y_vel_;
    return this;
  }
  Particle set_acceleration(float accel_) {
    accel = accel_;
    return this;
  }
  Particle set_friction(float frict_) {
    frict = frict_;
    return this;
  }
  Particle set_color(color c) {
    _color = c;
    return this;
  }
  Particle set_lifespan(int lifespan_) {
    lifespan = lifespan_;
    return this;
  }
  void run() {
    move(star_list);
    render();
    is_dead();
    //accel();
    //frict();
    //bounce();
  }
  void accel(){
    //x_vel += accel;
    y_vel += accel;
  }
  void frict(){
    //x_vel *= frict;
    y_vel *= frict;
  }
  void bounce(){
    if (x <= d/2 || x >= width-d/2)x_vel*=-1;
    if (y <= d/2 || y >= height-d/2)y_vel*=-1;
  }
  void move(ArrayList<Particle> star_list) {
    x += x_vel;
    //y += y_vel;
    lifespan-=1.0;
  }
  void render() {
    push();
    fill(_color, lifespan);
    circle(x, y, d);
    pop();
  }
  boolean is_dead() {
    if (lifespan <= 0) {
      //println("Particle is dead");
      //println(frameCount + "......." + star_list.size());
      return true;
    } else {
      return false;
    }
  }
}
