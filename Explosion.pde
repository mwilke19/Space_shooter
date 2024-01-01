ArrayList<Particle> burst_list = new ArrayList<Particle>();
float last_burst = 0;
float burst_timer = 1;
class Explosion extends Particle {
  Explosion() {
    super();
  }
  void run() {
    move(burst_list);
    render();
    is_dead();
    accel();
    frict();
    bounce();
  }
  void accel() {
    x_vel += accel;
    y_vel += accel;
  }
  void frict() {
    x_vel *= frict;
    y_vel *= frict;
  }
  void bounce() {
    if (x <= d/2 || x >= width-d/2)x_vel*=-1;
    if (y <= d/2 || y >= height-d/2)y_vel*=-1;
  }
  void move(ArrayList<Particle> burst_list) {
    float rot = random(0, TWO_PI);
    x += x_vel*sin(rot);
    y -= y_vel*cos(rot);
    lifespan-=1.0;
  }
  void render() {
    push();
    fill(_color, lifespan);
    ellipse(x, y, _width, _length);
    pop();
  }
  boolean is_dead() {
    if (lifespan <= 0) {
      //println("burst_list is dead");
      //println(frameCount + "......." + star_list.size());
      return true;
    } else {
      return false;
    }
  }
}
void remove_dead_burst(ArrayList<Particle> burst_list) {
  int last_index = burst_list.size() - 1;
  for (int i = last_index; i > 0; i--) {
    if (burst_list.get(i).is_dead() == true) {
      burst_list.remove(i);
      //println("burst_list was removed");
    }
  }
}
void add_burst(float enemy_x, float enemy_y) {
  int MAX_SIZE = 500;
  
  while (burst_list.size() <= MAX_SIZE) {
    noStroke();
    Particle red_explosion = new Explosion()
      .set_position(enemy_x, enemy_y)
      .set_length(20)
      .set_width(20)
      .set_velocity(-1, 1)
      .set_acceleration(1)
      .set_friction(.77)
      .set_color(RED)
      .set_lifespan(150);
    Particle yellow_explosion = new Explosion()
      .set_position(enemy_x, enemy_y)
      .set_length(20)
      .set_width(20)
      .set_velocity(-1, 1)
      .set_acceleration(1)
      .set_friction(.88)
      .set_color(YELLOW)
      .set_lifespan(150);
    burst_list.add(red_explosion);
    burst_list.add(yellow_explosion);
  }
}
