class AstralObject {
  private float _radius;
  private float _angle;
  private float _distance;
  private float _orbitSpeed;
  private color _color;
  private AstralObject _astralObjects[];
  
  /**
  * Constructor
  * @param r is a desired radius value
  * @param d is a desired distance value
  * @param o is a desired orbit speed value
  */
  AstralObject(float r, float d, float o) {
    this._radius = r;
    this._distance = d;
    this._angle = random(0, TWO_PI);
    this._orbitSpeed = o;
    this._color = color(random(255), random(255), random(255));
  }
  
  /**
  * Function is called whenever spawning a moon for a planet is needed
  * @param total is a desired quantity of moons
  * @param level is a desired depth of spawnMoons funtion. Can't be equal to 0.
  */
  void spawnMoons(int total, int level) {
    _astralObjects = new AstralObject[total];
    float newDistance = _radius;
    
    for (int i = 0; i < _astralObjects.length; i++) {
      float r = _radius * (random(0.4, 0.7))/level;
      float d = newDistance/level + r + random(20, 80)/(level*level);
      newDistance = d + r;
      float o = random(-0.02, 0.02);
      
      _astralObjects[i] = new AstralObject(r, d, o);
      if (level < 2) {
        int num = int(random(0, 2));
        _astralObjects[i].spawnMoons(num, level+1);
      }
    }
  }
  
  void orbit() {
    _angle =  _angle + _orbitSpeed;
    if (_astralObjects != null) {
      for (int i = 0; i < _astralObjects.length; i++) {
        _astralObjects[i].orbit();
      }
    }
  }
  
  void show() {
    pushMatrix();
    rotate(_angle);
    translate(_distance, 0);
    fill(_color);
    ellipse(0, 0, _radius*2, _radius*2);
    if (_astralObjects != null) {
      for (int i = 0; i < _astralObjects.length; i++) {
        _astralObjects[i].show();
      }
    }
    popMatrix();
  }
}
