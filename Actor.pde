class Actor extends PVector {
  int size, x_speed, y_speed;
  color _color = WHITE;
  boolean collision = false;

  Actor() {
  }
  Actor set_position(int x_, int y_) {
    x = x_;
    y = y_;
    return this;
  }
  Actor set_speed(int x_speed_, int y_speed_) {
    x_speed = x_speed_;
    y_speed = y_speed_;
    return this;
  }
  Actor set_color(color c) {
    _color = c;
    return this;
  }
  Actor set_size(int size_) {
    size = size_;
    return this;
  }
  boolean actor_distance(Actor opponent) {
    float dist = PVector.dist(this, opponent) - (this.size/4 + opponent.size/4);
    //println("opponent distance..........." + dist);
    return(dist <= 0);
  }
  void run() {
    move(asteroid_list);
    render();
    health();
    render_health_bar();
    screen_boundary();
    collision(asteroid_list);
    check_distance();
    hit();
    shot();
    is_dead();
  }
  void collision(ArrayList<Actor> asteroid_list) {
    collision = false;

    for ( Actor Actor : asteroid_list) {
      if (Actor == this) {
        continue;
      }
      if (!collision && actor_distance(Actor)) {
        collision = true;
      }
    }
  }
  boolean is_dead() {
    return true;
  }
  void move(ArrayList<Actor> asteroid_list) {
  }
  boolean check_distance() {
    return true;
  }
  boolean hit() {
    return true;
  }
  boolean shot() {
    return true;
  }
  void render() {
  }
  void health() {
  }
  void render_health_bar() {
  }
  void screen_boundary() {
  }
}
