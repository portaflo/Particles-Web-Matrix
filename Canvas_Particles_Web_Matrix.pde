int particleCount = 150;
int minDist = 70;

ArrayList<Particle> particles;

void setup() {
  frameRate(30);
  size(1000, 400);
  particles = new ArrayList<Particle>();
  for (int i=0; i<particleCount; i++) {
    particles.add(new Particle());
  }
}

void draw() {
  background(0);
  for (Particle p : particles) {
    p.drawParticle();
  }

  update();
}

void update() {
  for (Particle p : particles) {
    p.x += p.vx;
    p.y += p.vy;

    if (p.x+p.radius > width) {
      p.x = p.radius;
    } else if (p.x - p.radius < 0) {
      p.x = width - p.radius;
    }
    if (p.y+p.radius > height) {
      p.y = p.radius;
    } else if (p.y - p.radius < 0) {
      p.y = height - p.radius;
    }

    for (Particle p2 : particles) {
      distance(p, p2);
    }
  }
}

void distance(Particle p1, Particle p2) {
  float dist;
  float dx = p1.x - p2.x;
  float dy = p1.y - p2.y;

  dist = sqrt(dx*dx + dy*dy);
  if (dist <= minDist) {
    stroke(255);
    strokeWeight((1-dist/minDist));
    line(p1.x, p1.y, p2.x, p2.y);

    float ax = dx/2000;
    float ay = dy/2000;

    p1.vx -= ax;
    p1.vy -= ay;

    p2.vx += ax;
    p2.vy += ay;
  }
}

class Particle {

  float x;
  float y;
  int radius;
  float vx;
  float vy;

  public Particle() {

    this.x = floor(random(width));
    this.y = floor(random(height));
    this.radius = 4;
    this.vx = -1 + random(2);
    this.vy = -1 + random(2);
  }

  void drawParticle() {

    ellipse(this.x, this.y, 2*this.radius, 2*this.radius);
  }
}
