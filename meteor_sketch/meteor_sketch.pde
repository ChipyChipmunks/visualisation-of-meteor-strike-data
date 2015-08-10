
import processing.pdf.*;

PShape basemap;
String[] csv;
String[][] data;
ArrayList<Impact> impacts;
PFont f;
int count = 1;

void setup(){
  size(1200, 600);
  smooth();
  basemap = loadShape("WorldMap.svg");
  csv = loadStrings("MeteorStrikes.csv");
  data = new String[csv.length][6];
  f = createFont("Avenir-Medium", 12);
  for (int i = 0; i < csv.length; i++){
   data[i] = csv[i].split(","); 
  }
  impacts = new ArrayList<Impact>();
  getData();
  shape(basemap, 0, 0, width, height);
  ellipseMode(CENTER);
}

void getData(){
  String[] d = new String[6];
  for (int i = 0; i < csv.length/4; i++){
    for (int j = 0; j < d.length/4; j++){
     d = csv[i].split(",");
    }
   Impact m = new Impact(d[0], float(d[3]), float(d[4]), float(d[2]));
   impacts.add(m);
  }
}

void draw(){
  beginRecord(PDF, "meteorStrikes.pdf");
  shape(basemap, 0, 0, width, height);
  for (Impact m : impacts){
   m.render(); 
  }
  endRecord();
}

public class Impact{
 String location;
 float graphLong, graphLat, mass, markerSize, x, y; 
 boolean focus = false;
 
 public Impact(String l, float gLong, float gLat, float mass){
  this.location = l;
  this.graphLong = gLong;
  this.graphLat = gLat;
  this.mass = mass;
  this.x = map(gLong, -180, 180, 0, width);
  this.y = map(gLat, 90, -90, 0, height);
  this.markerSize = sqrt(mass)/PI * 0.04;
 }
 
 public void render(){
  fill(0, 175, 175, 75);
  stroke(0, 200, 200, 75);
  ellipse(x, y, markerSize, markerSize);
 }
}
