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
void remove_dead_s_bullet(ArrayList<Bullet> s_bullet_list) {
  int last_index = s_bullet_list.size() - 1;
  for (int i = last_index; i > 0; i--) {
    if (s_bullet_list.get(i).is_dead() == true) {
      s_bullet_list.remove(i);
    //println("s_bullet was removed........");
    }
  }
}
void remove_dead_enemy(ArrayList<Enemy> enemy_list) {
  int last_index = enemy_list.size() - 1;
  for (int i = last_index; i > 0; i--) {
    if (enemy_list.get(i).is_dead() == true) {
      enemy_list.remove(i);
      //println("enemy was removed");
    }
  }
  //println("removeDeadEnemy has executed");
}
void remove_hit_enemy(ArrayList<Enemy> enemy_list) {
  int last_index = enemy_list.size() - 1;
  for (int i = last_index; i >= 0; i--) {
    if (enemy_list.get(i).hit() == true) {
      
      float enemy_x = enemy_list.get(i).x;
      float enemy_y = enemy_list.get(i).y;

      enemy_list.remove(i);
      add_explosion(enemy_x,enemy_y);
      enemies_killed++;
      //println("enemies_killed......." + enemies_killed + '\n');
    }
  }
}

void remove_dead_e_bullet(ArrayList<Bullet> e_bullet_list) {
  int last_index = e_bullet_list.size() - 1;
  for (int i = last_index; i > 0; i--) {
    if (e_bullet_list.get(i).is_dead() == true) {
      e_bullet_list.remove(i);
      //println("e_bullet was removed........");
    }
  }
}
void remove_dead_explosion(ArrayList<Particle> explosion_list) {
  int last_index = explosion_list.size() - 1;
  for (int i = last_index; i > 0; i--) {
    if (explosion_list.get(i).is_dead() == true) {
      explosion_list.remove(i);
      //println("explosion_list was removed");
    }
  }
}
void remove_dead_planet(ArrayList<Planets> planet_list) {
  int last_index = planet_list.size() - 1;
  for (int i = last_index; i >= 0; i--) {
    if (planet_list.get(i).x <= -10000) {
      planet_list.remove(i);
      println("planet was removed");
    }
  }
}
void remove_dead_star(ArrayList<Particle> star_list) {
  int last_index = star_list.size() - 1;
   for (int i = last_index; i > 0; i--) {
    if (star_list.get(i).is_dead() == true) {
      star_list.remove(i);
      //println("star was removed");
    }
  }
}
