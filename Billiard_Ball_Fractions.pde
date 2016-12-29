ArrayList<table> tables = new ArrayList<table>();
boolean creating = false;
int newx, newy = 0;
void setup() {
  size(500, 500);
}
void draw() {
  strokeWeight(1);
  background(240, 255, 240);
  noFill();
  stroke(0);
  for (int i = 0; i<tables.size(); i++) {
    tables.get(i).draw();
    if (tables.get(i).wid == 0 || tables.get(i).hig == 0) {
      tables.remove(i);
      print("remove");
    }
  }
  stroke(200);
  for (int i = 0; i<50; i++) {
    line(i*10, 0, i*10, 500);
    line(0, i*10, 500, i*10);
  }
  stroke(0);
  for (int i = 0; i<tables.size(); i++)tables.get(i).run();
  stroke(0);
  strokeWeight(3);
  if (creating) {
    rect(newx, newy, mouseX-newx, mouseY-newy);
    fill(100);
    text(abs(mouseX-newx)/10, newx+(mouseX-newx)/2, newy-12*sign((mouseY-newy)));
    text(abs(mouseY-newy)/10, newx-22*sign(mouseX-newx), newy+(mouseY-newy)/2);
    noFill();
  }
}
void mousePressed() {
  boolean hitTable = false;
  for (int i = 0; i<tables.size(); i++) {
    if (between(mouseX, tables.get(i).xpos, tables.get(i).xpos+tables.get(i).wid) && 
      between(mouseY, tables.get(i).ypos, tables.get(i).ypos+tables.get(i).hig)) {
      if (tables.get(i).dead)tables.remove(i);
      else tables.get(i).drawn++;
      hitTable = true;
    }
  }
  if (!hitTable) {
    if (creating) {
      tables.add(new table(newx, newy, floor((int)((mouseX-newx)/10.0)*10), floor((int)((mouseY-newy)/10.0)*10)));
    } else {
      newx = (int)(mouseX/10.0)*10;
      newy = (int)(mouseY/10.0)*10;
    }
    creating = !creating;
  }
}
boolean between(float x, float a, float b) {
  return (x<a && x>b) || (x>a && x<b);
}
class vect {
  int x1, y1, x2, y2;
  vect(int X1, int Y1, int X2, int Y2) {
    x1 = X1;
    y1 = Y1;
    x2 = X2;
    y2 = Y2;
  }
  void draw() {
    line(x1, y1, x2, y2);
  }
}
class table {
  ArrayList<vect> lines = new ArrayList<vect>();
  boolean dead = false;
  int xpos, ypos, wid, hig = 1;
  int drawn;
  table(int x, int y, int Width, int Height) {
    xpos = x;
    ypos = y;
    if (Width != 0)wid = Width;
    if (Height != 0)hig = Height;
    if (!(wid == 0 || hig == 0))startLines();
  }
  void draw() {
    strokeWeight(3);
    fill(255);
    stroke(0);
    rect(xpos, ypos, wid, hig);
    fill(0);
    strokeWeight(1);
  }
  void run() {
    strokeWeight(3);
    noFill();
    stroke(0);
    rect(xpos, ypos, wid, hig);
    fill(0);
    text(abs(wid)/10, xpos+wid/2, ypos-12*sign(hig));
    text(abs(hig)/10, xpos-22*sign(wid), ypos+hig/2);
    strokeWeight(1);
    stroke(100);
    fill(0);
    if (drawn<=lines.size()) {
      for (int i = 0; i<drawn; i++)lines.get(i).draw();
    } else dead = true;
    noFill();
  }
  void startLines() {
    drawLines(xpos, ypos, wid, hig);
  }
  void drawLines(int x, int y, int w, int h) {
    println(x, y, w, h);
    if (abs(w) > abs(h)) {
      lines.add(new vect(x, y, x+sign(w)*abs(h), y+h));
      drawLines(x+sign(w)*abs(h), y+h, w-sign(w)*abs(h), -abs(hig)*sign(h));
    } else if (abs(h) > abs(w)) {
      lines.add(new vect(x, y, x+w, y+sign(h)*abs(w)));
      drawLines(x+w, y+sign(h)*abs(w), -abs(wid)*sign(w), h-sign(h)*abs(w));
    } else {
      lines.add(new vect(x, y, x+w, y+h));
      lines.add(new vect(0, 0, 0, 0));
      lines.add(new vect(0, 0, 0, 0));
      lines.add(new vect(0, 0, 0, 0));
      lines.add(new vect(0, 0, 0, 0));
    }
  }
}
int sign(int n) {
  int toReturn = 0;
  if (n != 0)toReturn = abs(n)/n;
  return toReturn;
}