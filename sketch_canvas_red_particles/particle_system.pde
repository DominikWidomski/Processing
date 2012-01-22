class ParticleSystem {
  ArrayList particles = new ArrayList();

  ParticleSystem(int n) {
    addParticles(n);      //initialise
  }

  private void addParticles(int n) {

    for (int i = 0; i < n; i++) {
      float rand = random(1);
      if (rand > 0 && rand < 0.333) {
        particles.add(new ParticleC());
      }
      else if (rand >= 0.333 && rand < 0.667) {
        particles.add(new ParticleS());
      }
      else if (rand >=0.667 && rand <= 1) {
        particles.add(new ParticleT());
      }
    }
  }

  public void run() {
    println("=RUNNING PARTICLES=");
    for (int i = 0; i < particles.size(); i++) {
      Particle p = (Particle) particles.get(i);
      println("ID: " + p);
      p.tick();
    }
  } 

  public void addParticle(PVector _loc, PVector _vel, float _r) {

    Particle p = null;
    float rand = random(1);
    if (rand > 0 && rand < 0.333) {
      p = new ParticleC(_loc, _vel, _r);
      particles.add(p);
    }
    else if (rand >= 0.333 && rand < 0.667) {
      p = new ParticleC(_loc, _vel, _r);
      particles.add(p);
    }
    else if (rand >=0.667 && rand <= 1) {
      p = new ParticleC(_loc, _vel, _r);
      particles.add(p);
    }
    println("Adding a new Particle: " + _loc + " " + _vel + " " + _r + ";");
    println("size: " + particles.size() + "; ID: " + p);
  }

  public void addParticle(Particle p) {
    particles.add(p);
  }

  void explodeRandom() {
    if (particles.size() > 0) {
      int rand = int(random(particles.size()));
      Particle op = (Particle) particles.get(rand);
      
      PVector loc = op.loc;
      PVector vel = op.vel; 
      float r = op.r;
      float nr = r/2;
      
      println("RANDOM: " + rand + " ID: " + op);
      println("R: " + r + " NR: " + nr);
      println("VEL: " + op.vel);

      stroke(255, 100);
      line(0, op.loc.y, height, op.loc.y);
      line(op.loc.x, 0, op.loc.x, width);

      if (r > 1) {
        for (int i = 0; i < 1; i++) {
          println("I " + i + "  ============================");
          println("LOC: " + loc + " :: VEL: " + vel + " :: NR: " + nr);
          //float vx = op.vel.x * random(2);
          //float vy = op.vel.y * random(-1, 1);

          addParticle(op.loc, op.vel, nr);
          println("created a particle: VX:" + op.vel.x + " VY:" + op.vel.y + "  R:" + nr);
        }
        particles.remove(rand);
      }
      else {
        println("Particle too small to blow up");
      }
    }
  }

  void explodeParticle(Particle p) {
    float r = p.r;
    println("R: " + r);

    if (r > 1) {
      for (int i = 0; i < 1; i++) {
        float vx = p.vel.x * random(2);
        float vy = p.vel.y * random(-1, 1);
        float nr = r/2;

        addParticle(p.loc, new PVector(vx, vy), nr);
        println("created a particle: VX:" + vx + " VY:" + vy + "  R:" + nr);
      }
      particles.remove(p);
    }
    else {
      println("Particle too small to blow up");
    }
  }
}

