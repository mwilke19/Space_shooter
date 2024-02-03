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
