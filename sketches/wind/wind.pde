
float next;
float initial;

int bgColor = 100;
int colorRange = 0;
int colorVal = 15;

int randomMax = 1;

IntList points;

int[][] vectors;
int vectorSize = 300;

boolean building = true;
boolean rendering = false;
boolean adding = true;

void setup(){
  size(600,600);
  colorMode(HSB,100);
  frameRate(30);

  fill(bgColor);
  noStroke();
  background(bgColor);
  //blendMode(ADD);

  initial = next = 0;

  vectors = new int[int(width*height/sq(vectorSize))][2];
  println();

  int x, y;

  for(int i=0; i<int(width*height/sq(vectorSize)); i++){
    //x = (hundredTo(50) ? -1 : 1);
    //y = (hundredTo(50) ? -1 : 1);
    x = (i % 2 == 0 ? 1 : -1);
    //y = x;
    y = (floor(i/2) == 0 ? 1 : -1);
    //x = (hundredTo(80) ? 1 : -1);
    //y = (hundredTo(80) ? 1 : -1);
    vectors[i][0] = x;
    vectors[i][1] = y;
  }

  //bgSeed();

}

void bgSeed(){

  loadPixels();
  for(int i=0; i<pixels.length; i++){
    if(hundredTo(2))
      pixels[i] = getColor();//color(50, getColor(), 85);
    //println(pixels[i]);
    //colorRange = (colorRange + 1) % 7;
    //colorVal = 50 + colorRange;
  }
  updatePixels();

}

void flow(){

  loadPixels();

  int val;

  for(int i=0; i<pixels.length; i++){

    val = getTileIndex(i%width,floor(i/width));

    pixelDirection(i, vectors[val][0], vectors[val][1] );

    if(adding){
      if(hundredTo(.1)){
        pixels[i] = getColor();
      }
    }else{
      if(hundredTo(2)){
        pixels[i] = color(100,0,100);
      }
    }
  }

  updatePixels();
}

int getTileIndex(int x, int y){

  return floor(y/vectorSize) * floor(width/vectorSize) + floor(x/vectorSize);
}

//x and y -1 to 1
void pixelDirection(int ind, int x, int y){

  float xd = map(x, -1, 1, 20, 80);
  float yd = map(y, -1, 1, 20, 80);

  if(ind>randomMax && ind< pixels.length-randomMax && hundredTo( abs(x*20) )){
    pixels[ind] = pixels[ind+randomMod(xd)];
  }
  if(ind>width*randomMax && ind<pixels.length-width*randomMax && hundredTo( abs(x*20) )){
    pixels[ind] = pixels[ind+randomMod(yd)*width];
  }
}

void draw(){
  if(building){
    flow();
    rect(0,0,width,randomMax);
    rect(0,0,randomMax,height);
    rect(width-randomMax,0,randomMax,height);
    rect(0,height-randomMax,width,randomMax);
    //bgSeed();
  }

  if(rendering && frameCount%5==0){
    saveFrame("4up/img-####.tga");
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

  float sat = 90;
  float brt = 85;

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
  bgSeed();
}

void keyPressed() {
  //enter
  if(keyCode == 10){
    adding = !adding;
  }
  if(keyCode == 32){
    rendering = !rendering;
  }
}

boolean hundredTo(float comparison){
  if(comparison >= random(0,100)){
    return true;
  }
  return false;
}

int randomSign(float prob){
  if(hundredTo(prob)){
    return 1;
  }
  return -1;
}

int randomMod(float prob){
  int base = int(random(1,randomMax));
  return randomSign(prob)*base;
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