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
      fill(_color);
    }
    circle(x, y, size);
    pop();
  }
  //Test to see if the asteroid has left the screen
  boolean isDead() {
    if (x <= -200) {
      //println("asteroid is dead");
      return true;
    } else {
      return false;
    }
  }
}
//Methods outside the class
void removeDeadAsteroids(ArrayList<Actor> actors) {
  int lastIndex = actors.size() - 1;
  for (int i = lastIndex; i > 0; i--) {
    if (actors.get(i).isDead() == true) {
      actors.remove(i);
      asteroid_count++;
      //println("asteroid was removed........" + asteroid_count);
    }
  }
}
void addAsteroid() {
  float c_time, d_time;
  c_time = millis();
  d_time = c_time - last_asteroid;

  if (last_asteroid == 0 || d_time >= asteroid_timer) {
    color _color = color(145);
    Actor asteroid = new Asteroid()
      .setPosition(int(width), int(random(height)))
      .setSize(int(random(10, 75)))
      .setSpeed(-2, 2)
      .setColor(_color);
    actors.add(asteroid);
    last_asteroid = c_time;
  }
}
void asteroid_difficulty() {
  if (asteroid_count < 10) {
    asteroid_timer = 1000;
    return;
  }
  if (asteroid_count < 20) {
    asteroid_timer = 500;
    return;
  }
  if (asteroid_count < 40) {
    asteroid_timer = 250;
    return;
  }
  if (asteroid_count < 80) {
    asteroid_timer = 125;
    return;
  }
}
void renderGameTime(){
  game_timer = millis()/1000;
  fill(255);
  textSize(15);
  text("GAME TIME:",60,70); 
  fill(255);
  textSize(15);
  text(int(game_timer),115,70);
}
