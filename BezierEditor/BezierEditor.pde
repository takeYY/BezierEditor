ArrayList<Point>point;
boolean isSelected;
int selectedNum;

void setup()
{
  size(640,640);
  point = new ArrayList<Point>();
  String[] input = loadStrings("BezierPoint.txt");
  for(int i=0; i<input.length; i++)
  {
    String[] str = input[i].split(",");
    float x = float(str[0].substring(1));
    float y = float(str[1].substring(0,str[1].length()-1));
    point.add(new Point(x,y));
  }
  isSelected = false;
  selectedNum = -1;
}

void draw()
{
  background(255);
  drawBezier();
  for(int i=0; i<point.size(); i++)
  {
    point.get(i).draw(i);
  }
  changePoint(selectedNum);
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

void changePoint(int i)
{
  if(isSelected)
  {
    //マウスに近い制御点が始点ならば
    if(i%4==0)
    {
      //選んだ制御点が最前列でなければ
      if(i!=0)
      {
        float dis = dist(mouseX,mouseY,point.get(i-1).x,point.get(i-1).y);
        if(dis <= 50)
        {
          point.set(i,point.get(i-1));
        }else
        {
          point.set(i,new Point(mouseX,mouseY));
        }
      }else
      {
        float dis = dist(mouseX,mouseY,point.get(point.size()-1).x,point.get(point.size()-1).y);
        if(dis <= 50)
        {
          point.set(i,point.get(point.size()-1));
        }else
        {
          point.set(i,new Point(mouseX,mouseY));
        }
      }
    }
    //マウスに近い制御点が終点ならば
    else if(i%4==3)
    {
      //選んだ制御点が最後列でなければ
      if(point.size() != i+1)
      {
        float dis = dist(mouseX,mouseY,point.get(i+1).x,point.get(i+1).y);
        if(dis <= 50)
        {
          point.set(i,point.get(i+1));
        }else
        {
          point.set(i,new Point(mouseX,mouseY));
        }
      }else
      {
        float dis = dist(mouseX,mouseY,point.get(0).x,point.get(0).y);
        if(dis <= 50)
        {
          point.set(i,point.get(0));
        }else
        {
          point.set(i,new Point(mouseX,mouseY));
        }
      }
    }
    else
    {
      point.set(i,new Point(mouseX,mouseY));
    }
  }
}

void keyReleased()
{
  //3次ベジェ曲線追加
  if(key=='p')
  {
    point.add(new Point(mouseX,mouseY));
    point.add(new Point(mouseX+80,mouseY-20));
    point.add(new Point(mouseX+120,mouseY+40));
    point.add(new Point(mouseX+60,mouseY+80));
    delay(100);
  }
  //制御点の座標を保存
  else if(key=='s')
  {
    String[] str = new String[point.size()];
    for(int i=0; i<point.size(); i++)
    {
      str[i] = "("+point.get(i).x+","+point.get(i).y+")";
    }
    saveStrings("BezierPoint.txt",str);
  }
  //表示されている画面の保存
  else if(key=='g')
  {
    save("Bezier.png");
  }
  //制御点の全削除
  else if(key=='c')
  {
    point.clear();
  }
  //制御点のラスト削除
  else if(key=='d')
  {
    for(int i=0; i<4 && point.size()!=0; i++)
    {
      int last = point.size()-1;
      point.remove(last);
    }
  }
}

void mouseDragged()
{
  for(int i=0; i<point.size() && !isSelected;i++)
  {
    float distance = dist(mouseX,mouseY,point.get(i).x,point.get(i).y);
    //マウスと制御点の距離が50以下なら
    if(distance <= 50)
    {
      isSelected = true;
      selectedNum = i;
    }
  }
}

void mouseReleased()
{
  isSelected = false;
  selectedNum = -1;
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