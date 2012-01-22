class Particle {
  PVector loc = new PVector();
  PVector vel = new PVector();
  float r;
  float m;
  boolean dead;

  Particle() {
    m = 1;
    r = 10;
    loc.x = -r;
    loc.y = random(height);
    vel.x = random(3, 5);
    vel.y = 0;
  }

  Particle(PVector _loc, PVector _vel, float _r) {
    loc = _loc; 
    vel = _vel; 
    r = _r;
    m = 1;
  } 

  public void tick() {
    update();
    render();
  }

  protected void update() {
    println("    VEL: " + vel);
    loc.x += vel.x;
    loc.y += vel.y;

    //borders
    if (loc.x - r > width) loc.x = -r*2;
    if (loc.x + r*2 < 0) dead = true;
    if (loc.y + r*2 < 0) loc.y = height + r*2;
    if (loc.y - r > height) loc.y = -r*2;
  }

  protected void render() {
    fill(200, 100, 100, 150);
    textAlign(LEFT);
    text("R" + int(r) + ", VX" + int(vel.x), loc.x + 5, loc.y -5);
  }

  public void resolveCollision(Particle other) {
    //Vector between the two particles i guess (collision plane)
    PVector Dn = new PVector(this.loc.x - other.loc.x, this.loc.y - other.loc.y);

    //distance between the two balls (magnitude of the vector)
    float delta = Dn.mag();

    // normal vector of the collision plane
    Dn.normalize();

    //tangential vector of the collision plane
    PVector Dt = new PVector(Dn.y, -Dn.x);

    //avoid division by 0
    if (delta == 0)
    {
      other.loc.add(new PVector(0.01f, 0));
      return;
    }

    //get masses of both particles and the overall mass in the collision.
    float m1 = this.m;       //mass of this particle
    float m2 = other.m;      //mass of the other particle
    float M = m1 + m2;       //overall mass

    //minimum translation distance to push particles apart after intersecting
    //PVector mT = Dn * (this.r + other.r - delta);
    PVector mT = new PVector(Dn.x * (this.r + other.r - delta), Dn.y * (this.r + other.r - delta));

    //push the balls apart proportional to their mass (have to do it seperately for x and y values of the vectors.
    this.loc.x = this.loc.x + (mT.x * m2/M);    
    this.loc.y = this.loc.y + (mT.y * m2/M);

    other.loc.x = other.loc.x + (mT.x * m1/M);
    other.loc.y = other.loc.y + (mT.y * m1/M);

    //the velocity vectors of the balls before the collision
    PVector v1 = this.vel;
    PVector v2 = other.vel;

    //spllit the velocity vector of the balls into a normal and tangential component in respect of the collision plane
    //calculate dot products of both velocities with normal and tangent 
    float v1dotN = PVector.dot(v1, Dn);
    float v1dotT = PVector.dot(v1, Dt);
    float v2dotN = PVector.dot(v2, Dn);
    float v2dotT = PVector.dot(v2, Dt);

    //create the normal and tangential component for particle 1, velocity 1.
    PVector v1n = new PVector(Dn.x * v1dotN, Dn.y * v1dotN);
    PVector v1t = new PVector(Dt.x * v1dotT, Dt.y * v1dotT);

    //create the normal and tangential component for particle 2, velocity 2.
    PVector v2n = new PVector(Dn.x * v2dotN, Dn.y * v2dotN);
    PVector v2t = new PVector(Dt.x * v2dotT, Dt.y * v2dotT);

    //calculate the new velocty vectors of the particles, the tangential component stays the same, the normal component changes analog to the 1-Dimensional case
    this.vel = PVector.mult( PVector.add(v1t, Dn), ( (m1 + m2) / (M * v1n.mag()) + (2 * m2) / (M * v2n.mag()) ) );
    other.vel = PVector.mult( PVector.sub(v2t, Dn), ( (m2 - m1) / (M * v2n.mag()) + (2 * m1) / (M * v1n.mag()) ) );
  }
}

class ParticleC extends Particle {

  ParticleC() 
  { 
    super();
  }

  ParticleC(PVector _loc, PVector _vel, float _r) 
  { 
    loc = _loc; 
    vel = _vel; 
    r = _r;
    m = 1;
  } 

  void tick() {
    super.tick();
  }

  protected void render() {
    super.render();

    fill(200, 20, 10, 50);
    stroke(200, 20, 20, 200);

    if (r > 1) {
      ellipse(loc.x, loc.y, r, r);
      stroke(200, 20, 20, 100);
      point(loc.x, loc.y);
    }
    else {
      point(loc.x, loc.y);
    }
  }
}

class ParticleS extends Particle {
  float theta = random(5);

  ParticleS() {
    super();
  }

  ParticleS(PVector _loc, PVector _vel, float _r) 
  { 
    loc = _loc; 
    vel = _vel; 
    r = _r;
    m = 1;
  } 

  protected void render() {
    super.render();

    fill(200, 20, 10, 50);
    stroke(200, 20, 20, 200);

    if (r > 1) {
      pushMatrix();
      translate(loc.x, loc.y);
      rotate(theta += 0.02);
      rect(0, 0, r, r);
      popMatrix();
    }
    else {
      point(loc.x, loc.y);
    }
  }
}

class ParticleT extends Particle {
  float theta = random(5);

  ParticleT() {
    super();
  }

  ParticleT(PVector _loc, PVector _vel, float _r) 
  { 
    loc = _loc; 
    vel = _vel; 
    r = _r;
    m = 1;
  } 

  protected void render() {
    super.render();

    fill(200, 20, 10, 50);
    stroke(200, 20, 20, 200);

    if (r > 1) {
      pushMatrix();
      translate(loc.x, loc.y);
      rotate(theta += 0.02);
      beginShape(TRIANGLES);
      vertex(0, -r/2);
      vertex(r/2, r/2);
      vertex(-r/2, r/2);
      endShape();
      popMatrix();
    }
    else {
      point(loc.x, loc.y);
    }
  }
}
