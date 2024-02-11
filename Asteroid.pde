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
    image(asteroid,x,y,size,size);
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
void asteroid_difficulty() {
  if (asteroid_count%4==0) {
    asteroid_timer-=2;
    //I do not want the timer to go below 200 for max difficulty
    if (asteroid_timer<=200)asteroid_timer = 500;
  }
  //println(asteroid_timer);
}
