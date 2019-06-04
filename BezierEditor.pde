ArrayList<Point>point;

void setup()
{
  size(1280,720);
  point = new ArrayList<Point>();
}

void draw()

{
  background(255);
  for(int i=0; i<point.size(); i+=4)
  {
    float x1,x2,x3,x4;
    float y1,y2,y3,y4;
    x1=point.get(i).x;
    x2=point.get(i+1).x;
    x3=point.get(i+2).x;
    x4=point.get(i+3).x;
    y1=point.get(i).y;
    y2=point.get(i+1).y;
    y3=point.get(i+2).y;
    y4=point.get(i+3).y;
    stroke(0,255,255);
    strokeWeight(5);
    fill(255,255,255,0);
    bezier(x1,y1,x2,y2,x3,y3,x4,y4);
  }
  for(int i=0; i<point.size(); i++)
  {
    point.get(i).draw();
  }
  println(point.size());
}

void keyReleased()
{
  if(key=='p')
  {
    point.add(new Point(mouseX,mouseY));
    point.add(new Point(mouseX+80,mouseY+20));
    point.add(new Point(mouseX+120,mouseY+40));
    point.add(new Point(mouseX+60,mouseY+60));
    delay(100);
  }
}

class Point
{
  float x;
  float y;
  float d;
  
  Point(float x,float y)
  {
    this.x = x;
    this.y = y;
    this.d = 10;
  }
  
  void draw()
  {
    fill(255,0,0);
    noStroke();
    ellipse(x,y,d,d);
  }
}