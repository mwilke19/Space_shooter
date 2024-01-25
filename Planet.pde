ArrayList<Particle> planet_list = new ArrayList<Particle>();
float last_planet = 0;
float planet_timer = 10000;
class Planets extends Particle {

  PImage[]solar_system = {earth, saturn, mars};
  Planets() {
    super();
  }
  void render() {
    pushMatrix();
    for (int i = 0; i < solar_system.length; i++) {
      image(solar_system[i], x, y, d, d);
    }
    popMatrix();
  }
}

void add_planet() {
  float c_time, d_time;
  c_time = millis();
  d_time = c_time-last_planet;
  int y_center = height/2;
  if (d_time >= planet_timer) {
    //println(planet_list.size());
    Particle planet = new Planets()
      .set_position(width + 550, y_center)
      .set_diameter(525)
      .set_velocity(-4.5, 0)
      .set_acceleration(.99)
      .set_friction(.99)
      .set_color(0)
      .set_lifespan(3000);
    planet_list.add(planet);
    last_planet = c_time;
  }
}
void remove_dead_planet(ArrayList<Particle> planet_list) {
  int last_index = planet_list.size() - 1;
  for (int i = last_index; i >= 0; i--) {
    //println("planet.x......" + planet_list.get(i).x);
    if (planet_list.get(i).x <= planet_list.get(i).d*-1) {
      planet_list.remove(i);
      println("planet was removed");
    }
  }
}
