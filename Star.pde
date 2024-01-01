ArrayList<Particle> star_list = new ArrayList<Particle>();
float last_star = 0;
float star_timer = 15;
class Particle {
  float x, y;
  float x_vel, y_vel, frict, accel;
  int d, _length, _width, lifespan;
  color _color = color(255);

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
//Methods outside the class
void remove_dead_star(ArrayList<Particle> star_list) {
  int last_index = star_list.size() - 1;
   for (int i = last_index; i > 0; i--) {
    if (star_list.get(i).is_dead() == true) {
      star_list.remove(i);
      //println("star was removed");
    }
  }
}
void add_star(){
  float c_time,d_time;
  c_time = millis();
  d_time = c_time-last_star;
  
  if (last_star == 0 || d_time >= star_timer) {
    //println(star_list.size());
    Particle star = new Particle()
      .set_position(random(width), random(height))
      .set_diameter(int(random(1, 4)))
      .set_velocity(-1, 1)
      .set_acceleration(.5)
      .set_friction(.99)
      .set_color(WHITE)
      .set_lifespan(500);
    star_list.add(star);
    last_star = c_time;
  }
}
