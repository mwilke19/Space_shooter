ArrayList <Actor> actors = new ArrayList<Actor>();
float last_asteroid = 0;
float last_increase = 0;
float asteroid_timer = 6000;
float game_timer = 0;
int asteroid_count = 0;
class Asteroid extends Actor {
  Asteroid() {
    super();
  }
  void move(ArrayList<Actor> actors) {
    x += x_speed;
    //y += y_speed;
  }
  //Draws asteroid to the screen
  void render() {
    push();
    if (collision) {
      fill(color(145));
    } else {
      stroke(0);
      strokeWeight(2);
      fill(_color);
    }
    circle(x, y, size);
    pop();
  }
  //Test to see if the asteroid has left the screen
  boolean is_dead() {
    if (x <= -200) {
      //println("asteroid is dead");
      return true;
    } else {
      return false;
    }
  }
}
//Methods outside the class
void remove_dead_asteroid(ArrayList<Actor> actors) {
  int last_index = actors.size() - 1;
  for (int i = last_index; i > 0; i--) {
    if (actors.get(i).is_dead() == true) {
      actors.remove(i);
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
    color _color = color(145);
    Actor asteroid = new Asteroid()
      .set_position(int(width), int(random(height)))
      .setSize(int(random(10, 75)))
      .setSpeed(-2, 2)
      .set_color(_color);
    actors.add(asteroid);
    last_asteroid = c_time;
  }
}
void asteroid_difficulty() {  
  if (asteroid_count%2==0) {
    asteroid_timer-=2;
    //I do not want the timer to go below 200 for max difficulty
    if(asteroid_timer<=200)asteroid_timer = 250;
  }
  //println(asteroid_timer);
}
