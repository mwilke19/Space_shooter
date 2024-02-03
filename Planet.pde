ArrayList<Planets> planet_list = new ArrayList<Planets>();
float last_planet = 0; 
class Planets {
  float x, y;
  float x_velocity, y_velocity, friction, acceleration;
  float x_offset,y_offset;
  int diameter;
  PImage[]solar_system = {earth,earth,saturn};
  color _color = color(WHITE);

  Planets() {
  }
  Planets set_position(float x_, float y_) {
    x = x_;
    y = y_;
    return this;
  }
  Planets set_diameter(int diameter_) {
    diameter = diameter_;
    return this;
  }
  Planets set_velocity(float x_velocity_, float y_velocity_) {
    x_velocity = x_velocity_;
    y_velocity = y_velocity_;
    return this;
  }
  Planets set_acceleration(float acceleration_) {
    acceleration = acceleration_;
    return this;
  }
  Planets set_friction(float friction_) {
    friction = friction_;
    return this;
  }

  void run() {
    render_earth();
    render_mars();
    render_saturn();
    move(planet_list);
  }
  void move(ArrayList<Planets> planet_list) {
    x += x_velocity;
    //y += y_vel;
    //lifespan-=1.0;
  }
  void render_earth(){
    pushMatrix();
    image(earth, x, y,diameter*2,diameter*2);
    popMatrix();
  }
  void render_mars() {
    x_offset = x + 1200;
    y_offset = y + 300;
    pushMatrix();
    image(mars, x_offset, y_offset, diameter, diameter);
    popMatrix();
  }

  void render_saturn() {
    x_offset = x + 4800;
    y_offset = y - 200;
    pushMatrix();
    image(saturn, x_offset, y_offset, diameter*4, diameter*4);
    popMatrix();
  }
}
