import processing.serial.*; // imports library for serial communication
import java.awt.event.KeyEvent; // imports library for reading the data from the serial port
import java.io.IOException;
Serial myPort;
float roboX, roboY, sensorAngle=0, distance, smr=64, roboSpeed=0, roboAngularVel=0;
float roboAngle=0;
float ot=0, nt=0, i=1, j=1, l=20;
int pixel1[][]=new int[1280][640];
long iTime;
int iAngle = 0;
int first=1,second=1;

int move_time=6150, flag=0, flag2=0, nt_move, ot_move, rotate_time=3500;

void setup()
{
  size(1280,640,P2D);
  background(51);
  stroke(0,0,0);
  myPort = new Serial(this,"COM11", 9600); // starts the serial communication
  myPort.bufferUntil('.');
  roboX = width/2.0;
  roboY = height/2.0;
  for (int i=0;i<1280;i++)
  for (int j=0;j<640;j++)
  pixel1[i][j]=0; 
  ot=millis();
 
}

void draw()
{
  int nice=millis();
  background(0,0,0);
  drawObstacle();
  drawRobot();
  drawLine();
  if (flag==1)
  {
    if (flag2==0)
    {
      ot_move=millis();
      flag2=1;
    }
    if ((millis()-ot_move)>move_time)
    {
      flag=0;
      roboSpeed=0;
      roboAngularVel=0;
      flag2=0;
      first=1;
      second=1;
    }
  }
  if (flag==2)
  {
    if (flag2==0)
    {
      ot_move=millis();
      flag2=1;
    }
    if ((millis()-ot_move)>rotate_time)
    {
      flag=0;
      roboSpeed=0;
      roboAngularVel=0;
      flag2=0;
      first=1;
      second=1;
    }
  }
  values_update();
  int f=millis();
  fill(128,0,255);
  textSize(20);
  text(str(f-nice),100,600);
}

void drawRobot()
{
  stroke(255,0,0);
  line(roboX, roboY, roboX + (l*cos(radians(45+roboAngle))), roboY + (l*sin(radians(45+roboAngle))));
  line(roboX, roboY, roboX - (l*cos(radians(45-roboAngle))), roboY + (l*sin(radians(45-roboAngle))));
}
void drawObstacle()
{
  distance = iTime * 0.034 / 2.0;
  distance = distance * 0.64;
  int i1;
  int j1;
  float x=roboX+3.84*(sin(radians(roboAngle))); 
  float y=roboY-3.84*(cos(radians(roboAngle)));
  i1=int(x+(distance*cos(radians(roboAngle-sensorAngle))));
  j1=int(y+(distance*sin(radians(roboAngle-sensorAngle))));
  if ((second==1)&&(first==1)) 
  if ((distance<smr)&&(((i1>0)&&(i1<1280))&&((j1>0)&&(j1<640))))
  pixel1[i1][j1]=1;
  loadPixels();
  for (int i=0;i<1280;i++)
  for (int j=0;j<640;j++)
  if (pixel1[i][j]==1)
  {
    int a = 1280*j+i;
    pixels[a]=color(255,255,255);
  }
  updatePixels();
}
void drawLine()
{
  float x=roboX+3.84*(sin(radians(roboAngle))); 
  float y=roboY-3.84*(cos(radians(roboAngle)));
  stroke(0,255,0);
  line(x, y, x+(smr*cos(radians(roboAngle-sensorAngle))), y+(smr*sin(radians(roboAngle-sensorAngle))));
}

void roboMove()
{
  nt=millis();
  float len1=(nt-ot)*roboSpeed;
  roboX=roboX+(len1*sin(radians(roboAngle)));
  roboY=roboY-(len1*cos(radians(roboAngle)));
  roboAngle=roboAngle+((nt-ot)*roboAngularVel);
  ot=nt;
}

void values_update()
{
  roboMove();
  sensorAngle=iAngle;
  
}

void keyPressed()
{
  if ((key==CODED)&&(flag==0))
  {
    if (keyCode==UP)
    {
     myPort.write('F');
     roboSpeed=0.00218;
     flag=1;
    }
    if (keyCode==DOWN)
    {
      roboSpeed=-0.00218;
      flag=1;
      myPort.write('B');
    }
    if (keyCode==RIGHT)
    {
      myPort.write('R');
      roboAngularVel=0.0257;
      flag=2;
    }
    if (keyCode==LEFT)
    {
      roboAngularVel=-0.0257;
      myPort.write('L');
      flag=2;
    }
    first=0;
    second=0;
  }
}



void serialEvent(Serial myPort)
{
  String data = myPort.readStringUntil('.');
  data = data.substring(0,data.length()-1);
  int index1 = data.indexOf(","); 
  String angle= data.substring(0, index1); 
  String time= data.substring(index1+1, data.length());   
  iAngle = int(angle);
  iTime = int(time);
  first = 1;
}
