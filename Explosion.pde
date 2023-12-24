ArrayList<Particle> burst = new ArrayList<Particle>();
float last_burst = 0;
float burst_timer = 1;
class Explosion extends Particle {
  Explosion() {
    super();
  }
  void run() {
    move(burst);
    render();
    isDead();
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
  //Bounce is used with velocity, acceleration and friction
  void bounce() {
    if (x <= d/2 || x >= width-d/2)x_vel*=-1;
    if (y <= d/2 || y >= height-d/2)y_vel*=-1;
  }
  //Moves Particle and decrements lifespan
  void move(ArrayList<Particle> burst) {
    float rot = random(0, TWO_PI);
    x += x_vel*sin(rot);
    y -= y_vel*cos(rot);
    lifespan-=1.0;
  }
  //Draws Particle to the screen
  void render() {
    push();
    stroke(1);
    fill(_color, lifespan);
    ellipse(x, y, _width, _length);
    pop();
  }
  //Test to see if the Particle is dead
  boolean isDead() {
    if (lifespan <= 0) {
      //println("Burst is dead");
      //println(frameCount + "......." + stars.size());
      return true;
    } else {
      return false;
    }
  }
}
void removeDeadBurst(ArrayList<Particle> burst) {
  int lastIndex = burst.size() - 1;
  for (int i = lastIndex; i > 0; i--) {
    if (burst.get(i).isDead() == true) {
      burst.remove(i);
      //println("burst was removed");
    }
  }
}
