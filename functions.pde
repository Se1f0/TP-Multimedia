
void CreateImageResidus(int x,int y,PImage image1,PImage image2,int w,int h){

float l1,l2,l;

image1.loadPixels();
image2.loadPixels();
residus.loadPixels();
color c;
for(int i=0;i<h;i++){
   for(int j=0;j<w;j++){
       
     l1=brightness(image1.get(j,i));   
      
  
     l2=brightness(image2.get(j,i));   
            
     l=Math.abs(l1-l2);       
     
     
     c=color(l);

println(l);
     set(j+x,y+i,c);
   
   }


}


residus.updatePixels();


}





void AfficheImage(String name,int w,int h,int x,int y){
PImage img=loadImage(name);
img.loadPixels();


image(img,x,y,w,h);


}




float calculateMSE(PImage image1,PImage image2,int w,int h){


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



PImage TrouverSimilaire(PImage image1,int w,int h,int x,int y){

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

  

}else{

  println("error");
}



return image2;

}


void TrouverSimilairePourToutBlocks16_16(int w,int h){

frame1.loadPixels();
frame2.loadPixels();
PImage image1=null;
PImage image2=null;
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
     image2=TrouverSimilaire(image1,w,h,ki,kj);

     CreateImageResidus(j,i,image1,image2,w,h);
 
     kj++;
    }

    ki++;

}

residus.save("residus.png");

println("100%");


}
