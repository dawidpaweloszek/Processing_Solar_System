import peasy.*;

private AstralObject _sun;
private PeasyCam _cam;

void setup() {
  size(1200, 720, P3D);
  _cam = new PeasyCam(this, 500);
  
  _sun = new AstralObject(100, 0, 0, true);
  _sun.spawnMoons(3, 1);
}

void draw() {
  background(0);
  
  //pointLight(255, 255, 255, -150,    0,    0);
  //pointLight(255, 255, 255,  150,    0,    0);
  //pointLight(255, 255, 255,    0,  150,    0);
  //pointLight(255, 255, 255,    0, -150,    0);
  //pointLight(255, 255, 255,    0,    0,  150);
  //pointLight(255, 255, 255,    0,    0, -150);
  
  directionalLight(255, 255, 255, 0, 0, 500);
  
  _sun.show();
  _sun.orbit();
  
  AstralObject planets[] = _sun.getPlanets();
  int i = int(random(0, planets.length));
  AstralObject planet = planets[i];
  //planet.shine();
}
