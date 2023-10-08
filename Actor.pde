class Actor extends PVector {
  int size, x_speed, y_speed;
  color _color = color(255);
  boolean collision = false;

  Actor() {
  }
  //Set actor properties
  Actor setPosition(int x_, int y_) {
    x = x_;
    y = y_;
    return this;
  }
  Actor setSpeed(int x_speed_, int y_speed_) {
    x_speed = x_speed_;
    y_speed = y_speed_;
    return this;
  }
  Actor setColor(color c) {
    _color = c;
    return this;
  }
  Actor setSize(int size_){
    size = size_;
    return this;
  }
  //Tests for a collision between Actors
  boolean checkCollision(Actor opponent) {
    float dist = PVector.dist(this, opponent) - (this.size/4 + opponent.size/4);
    //println("opponent distance..........." + dist);
    return(dist <= 0);
  }
  void run(){
    move(actors);
    render();
    health();
    renderHealthBar();
    screen_boundary();
    collision(actors);
    isDead();
  }
  void screen_boundary(){
  }
  //Checks for a collision between actors
  void collision(ArrayList<Actor> Actors){
     collision = false;
    
    for ( Actor Actor : Actors) {
      if (Actor == this) {
        continue;
      }
      if (!collision && checkCollision(Actor)) {
        collision = true;
      }
    }
  }
  //Test to see if the particle is dead
  boolean isDead() {
    return true;
  }
  void move(ArrayList<Actor> Actors) {
  }
  void render() {
  }
  void health(){
  }
   void renderHealthBar(){
  }
}
