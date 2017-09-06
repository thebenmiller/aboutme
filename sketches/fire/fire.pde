float next;
float initial;

int bgColor = 0;
int colorRange = 0;
int colorVal = 80;

IntList points;
boolean building = true;
boolean rendering = false;

void setup(){
  size(480,640);
  colorMode(HSB,100);
  frameRate(120);

  background(bgColor);

  initial = next = 40;

}

void draw(){

   blendMode(BLEND);
  noStroke();
   fill(bgColor, 01);
   rect(0,0,width,height);

  blendMode(ADD);
  loadPixels();

  //pixels = subset(pixels,pixels.length); //concat(blank, subset(pixels, pixels.length-width));

  //println(pixels[1], pixels[641]);


  for(int i=0; i<pixels.length; i++){
    if(i>=pixels.length-width){
      pixels[i] = color(bgColor);
    }else{
      pixels[i] = pixels[i+width];
    }
    if(i>randomMax && i< pixels.length-randomMax && hundredTo(20)){
      pixels[i] = pixels[i+randomMod()];
    }
    if(i>width*2 && i<pixels.length-width*2 && hundredTo(40)){
      pixels[i] = pixels[i+randomSign(30)*width];
    }
    if(hundredTo(3)){
      pixels[i] = 0;
    }
  }

  updatePixels();

  //stroke(0);


  //fill(getColor());
  fill(color(4, 85, 85));

  //polygon(width-200, 150, 1, 100, 3);
  //polygon(200, 150, 1, 100, 25);

  if(building){
  ellipse(width/2, 400, 400, 400);
  blendMode(BLEND);
  //fill(colorVal,100,100);
  fill(0);
  ellipse(width/2, 401, 399, 399);
  //polygon(width-200, 145, 1, 95, 3);

  colorRange = (colorRange + 1) % 7;
  colorVal = 50 + colorRange;
}

}

IntList seeds = new IntList();

int seeded(int val, int seedMin, int seedMax){
  if(seeds.size()>val){
    return seeds.get(val);
  }else{
    seeds.set(val, int(random(seedMin, seedMax)));
    return seeds.get(val);
  }
}

color getColor(){

  float sat = 85;
  float brt = 15;

  next += 1.61803398875;
  next %= 100;

  return color(next, sat, brt);
}

void mouseClicked(){
  //seeds = new IntList();
  //randomMax++;
  //bgColor = 100 - bgColor;
  //colorMod++;
  //building = !building;
  //saveFrame("flame-###.png");
  //rendering = !rendering;
}

boolean hundredTo(float comparison){
  if(comparison >= random(0,100)){
    return true;
  }
  return false;
}

//int randomMax = 32;
int randomMax = 3;

int randomSign(float prob){
  if(hundredTo(prob)){
    return 1;
  }
  return -1;
}

int randomMod(){
  int base = int(random(1,randomMax));
  return randomSign(50)*base;
}

void polygon(float x, float y, float z, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}