ArrayList <Actor> asteroid_list = new ArrayList<Actor>();
float last_asteroid = 0;
float last_increase = 0;
float asteroid_timer = 6000;
float game_timer = 0;
int asteroid_count = 0;
class Asteroid extends Actor {
  Asteroid() {
    super();
  }
  void move(ArrayList<Actor> asteroid_list) {
    x += x_speed;
    //y += y_speed;
  }

  void render() {
    push();
    stroke(0);
    strokeWeight(2);
    fill(ASTEROID_GREY);

    circle(x, y, size);
    pop();
  }
  boolean is_dead() {
    if (x <= -200) {
      //println("asteroid is dead");
      return true;
    } else {
      return false;
    }
  }
}
void remove_dead_asteroid(ArrayList<Actor> asteroid_list) {
  int last_index = asteroid_list.size() - 1;
  for (int i = last_index; i > 0; i--) {
    if (asteroid_list.get(i).is_dead() == true) {
      asteroid_list.remove(i);
      asteroid_count++;
      //println("asteroid was removed........" + asteroid_count);
    }
  }
}
void add_asteroid() {
  float c_time, d_time;
  c_time = millis();
  d_time = c_time - last_asteroid;

  if (last_asteroid == 0 || d_time >= asteroid_timer) {
    Actor asteroid = new Asteroid()
      .set_position(int(width), int(random(height)))
      .set_size(int(random(10, 75)))
      .set_speed(-2, 2)
      .set_color(ASTEROID_GREY);
    asteroid_list.add(asteroid);
    last_asteroid = c_time;
  }
}
void asteroid_difficulty() {
  if (asteroid_count%2==0) {
    asteroid_timer-=2;
    //I do not want the timer to go below 200 for max difficulty
    if (asteroid_timer<=200)asteroid_timer = 250;
  }
  //println(asteroid_timer);
}
