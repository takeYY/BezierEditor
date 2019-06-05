ArrayList<Point>point;

void setup()
{
  size(1280,720);
  point = new ArrayList<Point>();
}

void draw()
{
  background(255);
  drawBezier();
  for(int i=0; i<point.size(); i++)
  {
    point.get(i).draw(i);
  }
  println(point.size());
}

void drawBezier()
{
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
}

void keyReleased()
{
  //3次ベジェ曲線追加
  if(key=='p')
  {
    point.add(new Point(mouseX,mouseY));
    point.add(new Point(mouseX+80,mouseY+20));
    point.add(new Point(mouseX+120,mouseY+40));
    point.add(new Point(mouseX+60,mouseY+60));
    delay(100);
  }
  //制御点の座標を保存
  if(key=='s')
  {
    String[] str = new String[point.size()];
    for(int i=0; i<point.size(); i++)
    {
      str[i] = "("+point.get(i).x+","+point.get(i).y+")";
    }
    saveStrings("BezierPoint.txt",str);
  }
}

void mouseDragged()
{
  for(int i=0; i<point.size();i++)
  {
    float distance = dist(mouseX,mouseY,point.get(i).x,point.get(i).y);
    if(distance <= 50)
    {
      point.set(i,new Point(mouseX,mouseY));
      if(i%4==0 && i!=0)
      {
        float dis = dist(mouseX,mouseY,point.get(i-1).x,point.get(i-1).y);
        if(dis <= 50)
        {
          point.set(i-1,new Point(mouseX,mouseY));
        }
      }
      if(i%4==3 && point.size()!=i+1)
      {
        float dis = dist(mouseX,mouseY,point.get(i+1).x,point.get(i+1).y);
        if(dis <= 50)
        {
          point.set(i+1,new Point(mouseX,mouseY));
        }
      }
      break;
    }
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
  
  void draw(int i)
  {
    fill(85*(i%4),0,255-(85*(i%4)));
    noStroke();
    ellipse(x,y,d,d);
  }
}