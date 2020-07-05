//ユーザーのキー入力
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
    
    //最後に選択された制御点に関わる曲線を削除
    case 'd':
    int num = (lastSelectedNum/4)*4;
    println("num="+num);
    for(int i=0; i<4 && point.size()!=0 && 0<=lastSelectedNum; i++)
    {
      point.remove(num);
    }
    lastSelectedNum = -1;
    break;
    
    //連結した曲線が滑らかになるよう自動調整されるかどうか
    case 'f':
    smooth = !smooth;
    frameCount = 0;
    s = "smooth";
    break;
    
    //表示されている画面の保存
    case 'p':
    save(year()+"年"+month()+"月"+day()+"日"+
      hour()+"時"+minute()+"分"+second()+"秒Bezier.png");
    break;
    
    //制御点を見えなくする
    case 'h':
    hidden = !hidden;
    break;
    
    //制御点の全削除
    case 'c':
    point.clear();
    break;
    
    //曲線の赤成分を変更
    case 'r':
    frameCount = 0;
    s = "color";
    r += 100;
    if(r == 300)
    {
      r = 255;
    }
    else if(255<r)
    {
      r = 0;
    }
    break;
    
    //曲線の緑成分を変更
    case 'g':
    frameCount = 0;
    s = "color";
    g += 100;
    if(g == 300)
    {
      g = 255;
    }
    else if(255<g)
    {
      g = 0;
    }
    break;
    
    //曲線の青成分を変更
    case 'b':
    frameCount = 0;
    s = "color";
    b += 100;
    if(b == 300)
    {
      b = 255;
    }
    else if(255<b)
    {
      b = 0;
    }
    break;
  }
}

//マウス入力
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

//マウスボタン入力
void mouseReleased()
{
  lastSelectedNum = selectedNum;
  isSelected = false;
  selectedNum = -1;
}
