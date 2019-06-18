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
        this.col = color(r,g,b);
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
        this.col = color(r,g,b);
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