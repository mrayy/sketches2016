

float fan2phi(int fan, int fans)
{
  return PI * 2 * fan / fans;
}

PVector polar(float phi, float l)
{
  float sn = sin(phi);
  float cs = cos(phi);
  return new PVector(
    (cs * l + 1) * 0.5 * width,
    (sn * l + 1) * 0.5 * height
  );
}

void drawRing(float l0, float l1, int fans)
{
  for (int fan = 0; fan < fans; fan += 2)
  {
    float phi0 = fan2phi(fan, fans);
    float phi1 = fan2phi(fan + 1, fans);
    float phi2 = fan2phi(fan + 2, fans);
    PVector v0 = polar(phi0, l0);
    PVector v1 = polar(phi1, l1);
    PVector v2 = polar(phi2, l0);
//    line(v0.x, v0.y, v1.x, v1.y);
//    line(v1.x, v1.y, v2.x, v2.y);
    bezier(v0.x, v0.y, v1.x, v1.y, v1.x, v1.y, v2.x, v2.y);
  }
}



float x1=0;
float x2=0;
float x3=0;

void setup()
{
  size(500, 500);
  frameRate(30);
  
  smooth();
  strokeWeight(0.5);
  noFill();
  stroke(0);
  
  x1=random(0,1);
  x2=random(0,1);
  x3=random(0,1);
}

float pnoise(float x,float min,float max)
{
  return noise(x)*(max-min)+min;
}


void draw()
{
  background(255);

  int fans = 50;
  int lines = 20;

  for (int i = 0; i < lines; i++)
  {
    float l0 = pnoise(x1+i*2/(float)lines,0.1,pnoise(x3,0.5,0.8));
    float l1=abs(l0+pnoise(x1+i*2/(float)lines,-0.3,0.3));
    drawRing(l0, l1, fans);
  }

  for (int i = 0; i < lines * 2; i++)
  {
    float l0=pnoise(x2+i*2/(float)lines,pnoise(x3+i/(float)lines,0.2,1),1.5);
    float l1=abs(l0+pnoise(x2+i*2/(float)lines,-0.15,0.15));
    drawRing(l0, l1, fans * 2);
  }
  
  x1+=0.01f;
  x2+=0.015f;
  x3+=0.02f;
 // saveFrame();
}