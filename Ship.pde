class Ship extends Actor {
  float c_health, p_health;
  float bar_width, g_bar_length, r_bar_length;
  Ship() {
    super();
    c_health = 100;
    p_health = 0;
  }
  void move(ArrayList<Actor> actors) {
    //Moves ship
    if (keyPressed) {
      switch(key) {
      case 'w': case 'W'://north
        y -= y_speed;
        break;
      case 's': case 'S'://south
        y += y_speed;
        break;
      case 'a':case 'A'://east
        x -= x_speed;
        break;
      case 'd':case 'D':;//west
        x += x_speed;
        break;
     case 'q':case 'Q'://northwest
        x -= x_speed;
        y -= y_speed;
        break;
     case 'e':case 'E'://northeast
        x += x_speed;
        y -= y_speed;
        break;
     case 'z':case 'Z'://northwest
        x -= x_speed;
        y += y_speed;
        break;
     case 'c':case 'C'://northwest
        x += x_speed;
        y += y_speed;
        break;
     case ' '://fire bullet
         addBullet();
        break;
      }
    }
  }
  void screen_boundary() {
    //Stops ship on the edge of screen
    if (x < 100)x = 100;
    if (x > width)x = width;

    //Allows ship to exit screen and wrap to the opposite side
    if (y > height || y < 0) {
      if (y < 0) {
        y = height;
      } else {
        y = 0;
      }
    }
  }

  void render() {
    float ship_length, nose_x, nose_y, ship_top, ship_bottom;
    //Name triangle vertices
    ship_length = x - 100;
    nose_x = x;
    nose_y = y;
    ship_top = y - 10;
    ship_bottom = y + 10;
    //Draw ship to the screen
    push();
    if (collision) {
      fill(color(255, 0, 0));
    } else {
      fill(_color);
    }
    triangle(ship_length, ship_bottom, nose_x, nose_y, ship_length, ship_top);
    pop();
  }
  void health() {
    //Decreases health when a collision is occuring
    if (collision) {
      c_health--;
      p_health = c_health;
      //println("Your health went down");
      //println("Current health..........." + c_health);
    } 
  }
  boolean isDead(){
    //Test to see if the ship health has run out
    if (c_health<=0){
      //println("the ship is dead");
    return true;
  }
    else{return false;}
  }
  void renderHealthBar() {
    //Draws health bars to the screen
    g_bar_length = c_health;
    r_bar_length = 100;
    bar_width = 10;
    fill(255);
    textSize(15);
    text("HEALTH", 50, 25);
    fill(255, 0, 0);
    rect(75, 15, r_bar_length, bar_width);
    fill(0, 255, 0);
    rect(75, 15, g_bar_length, bar_width);
  }
}
