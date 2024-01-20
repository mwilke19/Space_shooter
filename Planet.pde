ArrayList<Particle> planet_list = new ArrayList<Particle>();
float last_planet = 0;
float planet_timer = 30000;

void add_planet() {
  float c_time, d_time;
  c_time = millis();
  d_time = c_time-last_planet;

  if (last_planet == 0 || d_time >= planet_timer) {
    //println(planet_list.size());
    Particle planet = new Particle()
      .set_position(1400, height/2)
      .set_diameter(400)
      .set_velocity(-1, 0)
      .set_acceleration(.1)
      .set_friction(.99)
      .set_color(PLANET_RANDOM)
      .set_lifespan(3000);
    planet_list.add(planet);
    last_planet = c_time;
  }
}
void remove_dead_planet(ArrayList<Particle> planet_list) {
  int last_index = planet_list.size() - 1;
  for (int i = last_index; i >= 0; i--) {
    println("planet.x......" + planet_list.get(i).x);
    if (planet_list.get(i).x <= planet_list.get(i).d*-1) {
      planet_list.remove(i);
      println("planet was removed");
    }
  }
}
