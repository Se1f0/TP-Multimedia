import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class tp_mul5 extends PApplet {

int a,b;
int draw=0;
int ddy,ddx;

PImage frame1=null;
PImage frame2=null;


public void setup() {
  a=1200;b=688;

  
  background(0);
  ddx=80;
  ddy=80;
  frame1=loadImage("frame1.png");
  frame2=loadImage("frame2.png");
}
public void draw() {

 if(draw==0){
     background(0);
     
  AfficheImage("frame1.png",a,b,0,0);
  

}

if(draw==1){
   background(0);
 AfficheImage("frame2.png",a,b,0,0);
TrouverSimilairePourToutBlocks16_16(16,16);
draw=2;
}



}







public void keyPressed(){

  if(key==ENTER && draw==0){
        
  
  draw=1;
  }

 if(key==ENTER && draw==2){
      background(0);
     
  AfficheImage("frame1.png",a,b,0,0);
  
  
  draw=0;
  }
  

}
class Cordonee {
    private int i,j;

    Cordonee(int i,int j) {
        this.i = i;
        this.j = j;
    }

    public int getI() {
        return this.i;
    }

    public int getJ() {
        return this.j;
    }

    public void setI(int i) {
        this.i = i;
    }

    public void setJ(int j) {
        this.j = j;
    }

    public void affiche() {
        println("{i:"+this.i+",j:"+this.j+"}");
    }
}

public void CreateImageResidus(String name,PImage image1,PImage image2,int w,int h){

float l1,l2,l;
PImage image3=createImage(w,h,ALPHA);
image3.loadPixels();
image1.loadPixels();
image2.loadPixels();
int c;
for(int i=0;i<h;i++){
   for(int j=0;j<w;j++){
       
     l1=brightness(image1.get(j,i));   
      
  
     l2=brightness(image2.get(j,i));   
            
     l=Math.abs(l1-l2);       
     
     c=color(l);

     image3.pixels[j+i*w]=c;

   }


}


image3.updatePixels();

image3.save("residus\\"+name+".png");



}





public void AfficheImage(String name,int w,int h,int x,int y){
PImage img=loadImage(name);
img.loadPixels();


image(img,x,y,w,h);


}




public float calculateMSE(PImage image1,PImage image2,int w,int h){


image2.loadPixels();
image1.loadPixels();
float l1,l2;
float mse=0;


for(int i=0;i<h;i++){
  for(int j=0 ;j<w;j++){
     


     l1=brightness(image1.get(j,i));   
      
  
     l2=brightness(image2.get(j,i));   
     
     

     mse+=(l2-l1)*(l2-l1);

  }

}


mse=mse/(w*h);



return mse;
}



public void TrouverSimilaire(PImage image1,int w,int h,int x,int y){

frame2.loadPixels();


int minx=-1,miny=-1;
float minmse=Float.MAX_VALUE;
float tempmse;
 PImage image2=null;

for(int i=0;i<b-h;i+=5){
   for(int j=0;j<a-w;j+=5){
     
       image2=frame2.get(j, i, w, h);
       
       tempmse=calculateMSE(image1,image2,w,h);
          
       if(tempmse<minmse){
 
         minmse=tempmse;
         minx=j;miny=i;
       }


   }
}


if(minx!=-1 && miny!=-1){
  
  image2=frame2.get(minx,miny,w,h);

 CreateImageResidus("bl( "+x+" , "+y+" )",image1,image2,w,h);
  

}else{

  println("error");
}





}


public void TrouverSimilairePourToutBlocks16_16(int w,int h){

frame1.loadPixels();
frame2.loadPixels();
PImage image1=null;
int ki=1,kj=0;
int pi=0,pj=0;
for(int i=0;i<b;i+=h){
 kj=1;
 pi=(i+1)*100/(b);
 println(pi+"%");
  pj=0; 

    for(int j=0;j<a;j+=w){
       pj=(j+1)*100/(a);
       println(pi+"%  ,  "+pj+"%");
   
     image1=frame1.get(j, i, w, h);;
     TrouverSimilaire(image1,w,h,ki,kj);
     kj++;
    }

    ki++;

}



println("100%");


}
  public void settings() {  size(1300,700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "tp_mul5" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
