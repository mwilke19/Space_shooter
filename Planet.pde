ArrayList<Planets> planet_list = new ArrayList<Planets>();
float last_planet = 0; 
class Planets {
  float x, y;
  float x_velocity, y_velocity, friction, acceleration;
  float earth_x,mars_x,jupiter_x,saturn_x;
  float earth_y,mars_y,jupiter_y,saturn_y;
  int base_diameter;
  PImage[]solar_system = {earth,earth,jupiter,saturn};
  color _color = color(WHITE);

  Planets() {
  }
  Planets set_position(float x_, float y_) {
    x = x_;
    y = y_;
    return this;
  }
  Planets set_diameter(int base_diameter_) {
    base_diameter = base_diameter_;
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
    render_jupiter();
    render_saturn();
    move(planet_list);
  }
  void move(ArrayList<Planets> planet_list) {
    x += x_velocity;
    //y += y_vel;
    //lifespan-=1.0;
  }
  void render_earth(){
    earth_x = x;
    earth_y = y;
    pushMatrix();
    image(earth, earth_x, earth_y,base_diameter,base_diameter);
    popMatrix();
  }
  void render_mars() {
    mars_x = x + 2000;
    mars_y = y - 100;
    pushMatrix();
    image(mars, mars_x, mars_y, base_diameter/2, base_diameter/2);
    popMatrix();
  }

  void render_jupiter() {
    jupiter_x = x + 4000;
    jupiter_y = y - 200;
    pushMatrix();
    image(jupiter, jupiter_x, jupiter_y, base_diameter*2.5, base_diameter*2.5);
    popMatrix();
  }
  void render_saturn(){
    saturn_x = x + 6000;
    saturn_y = y + 100;
    pushMatrix();
    image(saturn, saturn_x, saturn_y, base_diameter*1.5, base_diameter*1.5);
    popMatrix();}
}
