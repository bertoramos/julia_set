
PGraphics img;

float cx, cy;

int maxIt;

void setup() {
  size(900, 900);
  img = createGraphics(width, height);
  img.beginDraw();
  
  //cx = -0.5599;
  //cy = -0.48;
  
  maxIt = 300;
}

color hsv2rgb(float h, float s, float v) {
  float c = v * s;
  float x = c * (1 - abs(((h/60) % 2) - 1));
  float m = v - c;
 
  float r, g, b;
  if (h < 60) {
    r = c;
    g = x;
    b = 0;
  } else if (h < 120) {
    r = x;
    g = c;
    b = 0;
  } else if (h < 180) {
    r = 0;
    g = c;
    b = x;
  } else if (h < 240) {
    r = 0;
    g = x;
    b = c;
  } else if (h < 300) {
    r = x;
    g = 0;
    b = c;
  } else {
    r = c;
    g = 0;
    b = x;
  }
 
  int ri = round((r + m) * 255);
  int gi = round((g + m) * 255);
  int bi = round((b + m) * 255);
  
  return color(ri, gi, bi);
}

void updateSet() {
  for(int i = 0; i < width; i++) {
    for(int j = 0; j < height; j++) {
      float zx = 1.5 * (i - width / 2) / (0.5 * width);
      float zy = (j - height / 2) / (0.5 * height);
      
      float it = maxIt;
      while(zx * zx + zy * zy < 4 && it > 0) {
        
        float xtemp = zx * zx - zy * zy + cx;
        zy = 2.0 * zx * zy + cy;
        zx = xtemp;
        
        it -= 1;
      }
      
      float hue = it/maxIt * 360;
      int saturation = 1;
      int value = it > 1 ? 1 : 0;
      
      img.pixels[i*width + j] = hsv2rgb(hue, saturation, value);
    }
  }
}

void draw() {
  img.loadPixels();
  cx = map(mouseX, 0, width, -0.99, -0.01);
  cy = map(mouseY, 0, height, -0.99, -0.01);
  updateSet();
  img.updatePixels();
  image(img, 0, 0);
  text(cx + "+" + cy + "i", 10, 10);
  /*
  if(keyPressed) {
    noLoop();
  }
  */
}
