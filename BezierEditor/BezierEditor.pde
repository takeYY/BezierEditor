ArrayList<Point>point;
boolean isSelected;
boolean smooth;
boolean hidden;
int selectedNum;

void setup()
{
  size(640, 640);
  textAlign(CENTER,CENTER);
  textSize(10);
  point = new ArrayList<Point>();
  String[] input = loadStrings("BezierPoint.txt");
  for (int i=0; i<input.length; i++)
  {
    String[] str = input[i].split(",");
    int x = int(str[0].substring(1));
    int y = int(str[1].substring(0, str[1].length()-1));
    color c = color(0);
    switch(point.size()%4)
    {
      case 0:
      c = color(255, 0, 0);
      break;
      case 1:
      case 2:
      c = color(0, 255, 0);
      break;
      case 3:
      c = color(0, 0, 255);
      break;
    }
    point.add(new Point(x, y, c));
  }
  isSelected = false;
  smooth = true;
  hidden = false;
  selectedNum = -1;
}

void draw()
{
  background(255);
  drawBezier();
  for (int i=0; i<point.size() && !hidden; i++)
  {
    point.get(i).draw(i);
  }
  if (isSelected)
  {
    changePoint(selectedNum);
  }
  if(frameCount<90)
  {
    drawText();
  }
  println(point.size()+","+smooth);
}

void drawBezier()
{
  for (int i=0; i<point.size(); i+=4)
  {
    float x1, x2, x3, x4;
    float y1, y2, y3, y4;
    x1=point.get(i).x;
    x2=point.get(i+1).x;
    x3=point.get(i+2).x;
    x4=point.get(i+3).x;
    y1=point.get(i).y;
    y2=point.get(i+1).y;
    y3=point.get(i+2).y;
    y4=point.get(i+3).y;
    stroke(0, 255, 255);
    strokeWeight(5);
    fill(255, 255, 255, 0);
    bezier(x1, y1, x2, y2, x3, y3, x4, y4);
  }
}

void changePoint(int i)
{
  //マウスに近い制御点が始点ならば
  if (i%4==0)
  {
    //選んだ制御点が最前列でなければ
    if (i!=0)
    {
      float dis = dist(mouseX, mouseY, point.get(i-1).x, point.get(i-1).y);
      if (dis <= 50)
      {
        point.set(i, point.get(i-1));
      } else
      {
        point.set(i, new Point(mouseX, mouseY, point.get(i).col));
      }
    } else
    {
      float dis = dist(mouseX, mouseY, point.get(point.size()-1).x, point.get(point.size()-1).y);
      if (dis <= 50)
      {
        point.set(i, point.get(point.size()-1));
      } else
      {
        point.set(i, new Point(mouseX, mouseY, point.get(i).col));
      }
    }
  }
  //マウスに近い制御点がP2ならば
  else if(i%4==1)
  {
    if(0<i-2)
    {
      int px = point.get(i-1).x;
      int py = point.get(i-1).y;
      int ppx = point.get(i-2).x;
      int ppy = point.get(i-2).y;
      //選んだ制御点の始点が連結していれば
      if(px == ppx && py == ppy && smooth)
      {
        int dx = point.get(i).x - px;
        int dy = point.get(i).y - py;
        point.set(i-3,new Point(ppx - dx,ppy - dy,point.get(i-3).col));
      }
    }else if(4<point.size())
    {
      int fx = point.get(point.size()-1).x;
      int fy = point.get(point.size()-1).y;
      int x = point.get(0).x;
      int y = point.get(0).y;
      //選んだ制御点の始点が連結していれば
      if(fx == x && fy == y && smooth)
      {
        int dx = point.get(i).x - x;
        int dy = point.get(i).y - y;
        point.set(point.size()-2,new Point(x - dx, y - dy, point.get(point.size()-2).col));
      }
    }
    point.set(i, new Point(mouseX, mouseY, point.get(i).col));
  }
  //マウスに近い制御点がP3ならば
  else if(i%4==2)
  {
    if(i+2<point.size())
    {
      int fx = point.get(i+1).x;
      int fy = point.get(i+1).y;
      int ffx = point.get(i+2).x;
      int ffy = point.get(i+2).y;
      //選んだ制御点の終点が連結していれば
      if(fx == ffx && fy == ffy && smooth)
      {
        int dx = fx - point.get(i).x;
        int dy = fy - point.get(i).y;
        point.set(i+3,new Point(ffx + dx,ffy + dy,point.get(i+3).col));
      }
    }else if(4<point.size())
    {
      int fx = point.get(i+1).x;
      int fy = point.get(i+1).y;
      int x = point.get(0).x;
      int y = point.get(0).y;
      //選んだ制御点の終点が連結していれば
      if(fx == x && fy == y && smooth)
      {
        int dx = fx - point.get(i).x;
        int dy = fy - point.get(i).y;
        point.set(1,new Point(x + dx, y + dy, point.get(1).col));
      }
    }
    point.set(i, new Point(mouseX, mouseY, point.get(i).col));
  }
  //マウスに近い制御点が終点ならば
  else if (i%4==3)
  {
    //選んだ制御点が最後列でなければ
    if (point.size() != i+1)
    {
      float dis = dist(mouseX, mouseY, point.get(i+1).x, point.get(i+1).y);
      if (dis <= 50)
      {
        point.set(i, point.get(i+1));
      } else
      {
        point.set(i, new Point(mouseX, mouseY, point.get(i).col));
      }
    } else
    {
      float dis = dist(mouseX, mouseY, point.get(0).x, point.get(0).y);
      if (dis <= 50)
      {
        point.set(i, point.get(0));
      } else
      {
        point.set(i, new Point(mouseX, mouseY, point.get(i).col));
      }
    }
  } else
  {
    point.set(i, new Point(mouseX, mouseY, point.get(i).col));
  }
}

void drawText()
{
  fill(0);
  String str = "Off";
  if(smooth)
  {
    str = "On";
  }
  textSize(30);
  text("smooth"+str,80,20);
  textSize(10);
}

void keyReleased()
{
  switch(key)
  {
    //3次ベジェ曲線追加
    case 'a':
    point.add(new Point(mouseX, mouseY, color(255, 0, 0)));
    point.add(new Point(mouseX+80, mouseY-20, color(0, 255, 0)));
    point.add(new Point(mouseX+120, mouseY+40, color(0, 255, 0)));
    point.add(new Point(mouseX+60, mouseY+80, color(0, 0, 255)));
    delay(100);
    break;
    
    //制御点の座標を保存
    case 's':
    String[] str = new String[point.size()];
    for (int i=0; i<point.size(); i++)
    {
      str[i] = "("+point.get(i).x+","+point.get(i).y+")";
    }
    saveStrings("BezierPoint.txt", str);
    break;
    
    //制御点のラスト削除
    case 'd':
    for (int i=0; i<4 && point.size()!=0; i++)
    {
      int last = point.size()-1;
      point.remove(last);
    }
    break;
    
    //連結した曲線が滑らかになるよう自動調整されるかどうか
    case 'f':
    smooth = !smooth;
    frameCount = 0;
    break;
    
    //表示されている画面の保存
    case 'g':
    save("Bezier.png");
    break;
    
    //制御点を見えなくする
    case 'h':
    hidden = !hidden;
    break;
    
    //制御点の全削除
    case 'c':
    point.clear();
    break;
  }
}

void mouseDragged()
{
  for (int i=0; i<point.size() && !isSelected; i++)
  {
    float distance = dist(mouseX, mouseY, point.get(i).x, point.get(i).y);
    //マウスと制御点の距離が50以下なら
    if (distance <= 50)
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
  int x;
  int y;
  int d;
  color col;

  Point(int x, int y, color col)
  {
    this.x = x;
    this.y = y;
    this.col = col;
    this.d = 10;
  }

  void draw(int i)
  {
    int textX = 0;
    int textY = 0;
    switch(i%4)
    {
      case 0:
      this.col = color(255,0,0);
      textX = 10;
      textY = -10;
      if(0<i-1 && point.get(i-1).x == x && point.get(i-1).y == y)
      {
        this.col = color(0,255,255);
      }
      break;
      case 1:
      this.col = color(0,255,0);
      textX = -10;
      textY = -10;
      break;
      case 2:
      this.col = color(0,255,0);
      textX = -10;
      textY = 10;
      break;
      case 3:
      this.col = color(0,0,255);
      textX = 10;
      textY = 10;
      if(i+2<point.size() && point.get(i+1).x == x && point.get(i+1).y == y)
      {
        this.col = color(0,255,255);
      }
      break;
    }
    fill(this.col);
    noStroke();
    ellipse(x, y, d, d);
    fill(0);
    text(i+1,x+textX,y+textY);
  }
}