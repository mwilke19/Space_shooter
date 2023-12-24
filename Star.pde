ArrayList<Particle> stars = new ArrayList<Particle>();
float last_star = 0;
float star_timer = 15;
class Particle {
  float x, y;
  float x_vel, y_vel, frict, accel;
  int d, _length, _width, lifespan;
  color _color = color(255);

  Particle() {
  }
  //Set Particle properties
  Particle setPosition( float x_, float y_) {
    x = x_;
    y = y_;
    return this;
  }
  Particle setDiameter(int d_) {
    d = d_;
    return this;
  }
  Particle setLength (int length_) {
    _length = length_;
    return this;
  }
  Particle setWidth ( int width_) {
    _width = width_;
    return this;
  }
  Particle setVelocity(float x_vel_, float y_vel_) {
    x_vel = x_vel_;
    y_vel = y_vel_;
    return this;
  }
  Particle setAcceleration(float accel_) {
    accel = accel_;
    return this;
  }
  Particle setFriction(float frict_) {
    frict = frict_;
    return this;
  }
  Particle setColor(color c) {
    _color = c;
    return this;
  }
  Particle setLifespan(int lifespan_) {
    lifespan = lifespan_;
    return this;
  }
  void run() {
    move(stars);
    render();
    isDead();
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
  //Bounce is used with velocity, acceleration and friction
  void bounce(){
    if (x <= d/2 || x >= width-d/2)x_vel*=-1;
    if (y <= d/2 || y >= height-d/2)y_vel*=-1;
  }
  //Moves Particle and decrements lifespan
  void move(ArrayList<Particle> stars) {
    x += x_vel;
    //y += y_vel;
    lifespan-=1.0;
  }
  //Draws Particle to the screen
  void render() {
    push();
    fill(_color, lifespan);
    circle(x, y, d);
    pop();
  }
  //Test to see if the Particle is dead
  boolean isDead() {
    if (lifespan <= 0) {
      //println("Particle is dead");
      //println(frameCount + "......." + stars.size());
      return true;
    } else {
      return false;
    }
  }
}
//Methods outside the class
void removeDeadStar(ArrayList<Particle> stars) {
  int lastIndex = stars.size() - 1;
   for (int i = lastIndex; i > 0; i--) {
    if (stars.get(i).isDead() == true) {
      stars.remove(i);
      //println("star was removed");
    }
  }
}
void addStar(){
  float c_time,d_time;
  c_time = millis();
  d_time = c_time-last_star;
  
  if (last_star == 0 || d_time >= star_timer) {
    //println(stars.size());
    color _color = color(random(255),random(255),random(255));
    Particle star = new Particle()
      .setPosition(random(width), random(height))
      .setDiameter(int(random(1, 3)))
      .setVelocity(-1, 1)
      .setAcceleration(.5)
      .setFriction(.99)
      .setColor(_color)
      .setLifespan(500);
    stars.add(star);
    last_star = c_time;
  }
}
