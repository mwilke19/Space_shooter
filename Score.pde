 void save_score() {
  score = new Table();
  
  String name = "Michael";
  float time = game.final_time;
  float efficiency = game.efficiency;
  float num_of_kills = enemies_killed;
  
  high_score.addColumn("NAME");
  high_score.addColumn("TIME");
  high_score.addColumn("EFFICIENCY");
  high_score.addColumn("KILLS");
  
  TableRow newRow = high_score.addRow();
  
  newRow.setString("NAME", name);
  newRow.setFloat ("TIME", time);
  newRow.setFloat ("EFFICIENCY",efficiency);
  newRow.setFloat ("KILLS",num_of_kills);
  
  saveTable(high_score, "data/SCORES.csv");
}
void load_previous_score() {
  high_score = loadTable("SCORES.csv", "header");
  //println(high_score.getRowCount() + " total rows in table");
 for (TableRow high_score : high_score.rows()) {
    String Name = high_score.getString("NAME");
    float Time = high_score.getFloat("TIME");
    float Efficiency = int(high_score.getFloat("EFFICIENCY"));
    float Enemies_killed = high_score.getFloat("KILLS");
    println(Name + ": Last game time was " + Time + " seconds with an kill efficiency of " + Efficiency + "%");
    println("You killed " + Enemies_killed);
 }
}
