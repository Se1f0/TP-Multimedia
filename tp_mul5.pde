int a,b;
int draw=0;
int ddy,ddx;

PImage frame1=null;
PImage frame2=null;
PImage residus=null;

void setup() {
  a=1200;b=688;

  size(1300,700);
  background(0);
  ddx=80;
  ddy=80;
  residus=createImage(a,b,ALPHA);
  frame1=loadImage("frame1.png");
  frame2=loadImage("frame2.png");
   

}
void draw() {

if(draw==1){
   background(0);
 AfficheImage("residus.png",a,b,0,0);
TrouverSimilairePourToutBlocks16_16(16,16);
textSize(30);
fill(0,0,255);
text("ImagesResidus...",a-340,b-110);
noFill();     
     
draw=2;
}  
  
  if(draw==0){
     background(0);

  AfficheImage("frame1.png",a,b,0,0);
  
       textSize(30);
fill(0,0,255);
text("Clicker sur Enter ...",a-340,b-110);
noFill();  
}



}







void keyPressed(){

  if(key==ENTER && draw==0){
background(0);
AfficheImage("frame1.png",a,b,0,0);
  
textSize(30);
fill(0,0,255);
text("En cours d'execution...",a-340,b-110);
noFill();     
  
  draw=1;
  }

 if(key==ENTER && draw==2){
      background(0);

  AfficheImage("frame1.png",a,b,0,0);
  
  
  draw=0;
  }
  

}
