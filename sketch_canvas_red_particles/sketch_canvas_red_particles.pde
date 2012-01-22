/*Some Particle System
 //ATM:  R = RUN SIMULATION (hold)
 //      N = Add new particle
 //      SPACE = EXPLODE a random particle
 */

ParticleSystem partSys;
PImage gradImg = createImage(width, height, RGB);
int frameTotal = 0;

PFont ubuntuFont;

void setup() {
  size(600, 600); 
  println("=SIZE= [600,600]");
  //size(screenWidth, screenHeight); 
  frameRate(30);
  background(0);
  println("=GENERATE GRADIENT IMAGE=");
  generateGradient();

  println("=CREATE NEW PARTICLE SYSTEM= elements.[5]");
  partSys = new ParticleSystem(5);  //initialises the particle system with starting number of particles of 10

  println("=LOAD AND SET FONT=");
  ubuntuFont = loadFont("ubuntu.vlw");
  textFont(ubuntuFont, 15);
}

void draw() {
  if (keyPressed && (key == 'r' || key == 'R') ) {
    println("=FRAME TOTAL= [" + frameTotal++ +"]");
    background(0);
    //generateGradient();           //GENERATE THE GRADIENT EVERY FRAME ??? (flickering depending on particles coming in etc)
    image(gradImg, 0, 0);
    //fill(0, 0, 0, 40);
    //rect(0, 0, width, height);

    partSys.run();  //run the particle system
  }
}

void mousePressed() {
  partSys.addParticle(new PVector(mouseX, mouseY), new PVector(random(3, 5), 0), 10);
  println("Sending a mouse event request to add a particle");
}

public void generateGradient() {
  gradImg.loadPixels();
  int loc;

  /*
  for(int x = 0; x < gradImg.width; x++){
   for(int y = 0; y < gradImg.height; y++){
   loc = x + y * gradImg.width;
   
   pixels[loc] = 
   } 
   }
   */
  for (int i = 0; i < gradImg.pixels.length; i++) {
    gradImg.pixels[i] = color(0, 90, 102, gradImg.width - i % gradImg.width * 2);
  }

  gradImg.updatePixels();
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//@PARTICLE CLASSES//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//@PARTICLES
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////////////
// KEY HANDLING
///////////////////////////////////////////////////////////////////////////////////////////////////////////
void keyPressed() {
  if (key == ' ') {
    println(" ");
    println("BOOOM           /////////////////////////////");
    partSys.explodeRandom();
  }
  if (key == 'n' || key == 'N') {
    println(" ");
    println("Adding a new particle         ///////////////");
    partSys.addParticle( new PVector( -10, random(height) ), new PVector( random(3, 5), 0 ), 10 );
  }
}

