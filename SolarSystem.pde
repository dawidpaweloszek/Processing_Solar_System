private AstralObject _sun;

void setup() {
  size(1200, 720);
  _sun = new AstralObject(50, 0, 0);
  _sun.spawnMoons(2, 1);
}

void draw() {
  background(#b80000);
  translate(width/2, height/2);
  _sun.show();
  _sun.orbit();
}
