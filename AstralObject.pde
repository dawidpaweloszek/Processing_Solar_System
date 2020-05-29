class AstralObject {
  private float _radius;
  private float _angle;
  private float _distance;
  private float _orbitSpeed;
  private float _object;
  private boolean _isThisSun;
  private color _color;
  private PVector _vector;
  private PShape _shape;
  private PImage _sunImage;
  private PImage[] _textures = new PImage[5];
  private int _index = int(random(0, _textures.length));
  private AstralObject _astralObjects[];
  
  /**
  * Constructor
  * @param r is a desired radius value
  * @param d is a desired distance value
  * @param o is a desired orbit speed value
  */
  AstralObject(float r, float d, float o, boolean i) {
    this._vector = PVector.random3D();
    this._radius = r;
    this._distance = d;
    this._vector.mult(this._distance);
    this._object = random(0, 30);
    this._angle = random(0, TWO_PI);
    this._orbitSpeed = o;
    this._color = color(random(255), random(255), random(255));
    _isThisSun = i;
    _sunImage = loadImage("textures/sun.jpg");
    _textures[0] = loadImage("textures/earth.jpg");
    _textures[1] = loadImage("textures/jupiter.jpg");
    _textures[2] = loadImage("textures/mercury.jpg");
    _textures[3] = loadImage("textures/pluto.jpg");
    _textures[4] = loadImage("textures/saturn.jpg");
    noStroke();
    noFill();
  }
  
  /**
  * Add spotLight from random planet
  */
  public void shine() {
    PVector vtmp = new PVector(1, 0, 1);
    PVector p = _vector.cross(vtmp);
    spotLight(255, 255, 255, p.x, p.y, p.z, 1000, 0, 1000, PI/2, 1000);
  }
  
  /**
  * Return AstralObject[] value of _astralObjects
  */
  public AstralObject[] getPlanets() {
    return _astralObjects;
  }
  
  /**
  * Return PVector value of _vector
  */
  public PVector getPosition() {
    return _vector;
  }
  
  /**
  * Function is called whenever array of AstralObjects datatype is needed to move
  */
  void orbit() {
    _angle =  _angle + _orbitSpeed;
    if (_astralObjects != null) {
      for (int i = 0; i < _astralObjects.length; i++) {
        _astralObjects[i].orbit();
      }
    }
  }

  /**
  * Function is called in draw(), basiclly main loop of program
  */
  void show() {
    pushMatrix();
    
    PVector vtmp = new PVector(1, 0, 1);
    PVector p = _vector.cross(vtmp);
    rotate(_angle, p.x, p.y, p.z);
    translate(_vector.x, _vector.y, _vector.z);
    rotate(_angle);
    noStroke();
    noFill();
    
    if (_object <= 10 || _isThisSun) {
      this._shape = createShape(SPHERE, _radius/2);
      if (_isThisSun) {
        _shape.setTexture(_sunImage);
      }
      else {
        _shape.setTexture(_textures[_index]);
      }
    }
    else if (_object > 10 && _object <= 15f && !_isThisSun) {
      _shape = loadShape("objects/shrek.obj");
      _shape.scale(_radius/20);
    }
    else if (!_isThisSun) {
      this._shape = drawPyramid(_radius/2, _index);
    }
    
    shape(_shape);
    
    if (_astralObjects != null) {
      for (int i = 0; i < _astralObjects.length; i++) {
        _astralObjects[i].show();
      }
    }
    popMatrix();
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
      
      _astralObjects[i] = new AstralObject(r, d, o, false);
      if (level < 2) {
        int num = int(random(0, 4));
        _astralObjects[i].spawnMoons(num, level+1);
      }
    }
  }
  
  /**
  * Function will draw a pyramid with given value as length between points
  * @param rad float value that is a length between two given points
  * @param index is a int value for used in texturing
  */
  PShape drawPyramid(float rad, int index) {
    PShape s;
    s = createShape();
    s.beginShape(TRIANGLES);
    s.texture(_textures[index]);
    s.vertex(-rad, -rad, -rad);
    s.vertex( rad, -rad, -rad);
    s.vertex(   0,    0,  rad);
    
    s.vertex( rad, -rad, -rad);
    s.vertex( rad,  rad, -rad);
    s.vertex(   0,    0,  rad);
    
    s.vertex( rad, rad, -rad);
    s.vertex(-rad, rad, -rad);
    s.vertex(   0,   0,  rad);
    
    s.vertex(-rad,  rad, -rad);
    s.vertex(-rad, -rad, -rad);
    s.vertex(   0,    0,  rad);
    
    s.vertex(-rad, -rad, -rad);
    s.vertex( rad, -rad, -rad);
    s.vertex( rad,  rad, -rad);
    
    s.vertex(-rad,  rad, -rad);
    s.vertex(-rad, -rad, -rad);
    s.vertex( rad,  rad, -rad);
    s.endShape(CLOSE);
    
    return s;
  }
}
