String s="",s_temp="";
char [] t =new char[255];
int taille=0,draw=0;

String BinaryToHex(String bin){
char [] temp=new char[4];
String s="";
  if(bin.length() % 16 ==0){
     
    for(int i=0;i<bin.length();i=i+4){
     temp[0]=bin.charAt(i);
     temp[1]=bin.charAt(i+1);
     temp[2]=bin.charAt(i+2);
     temp[3]=bin.charAt(i+3);
     
     if(temp[0]=='0' && temp[1]=='0' && temp[2]=='0' && temp[3]=='0') s=s+"0";
     if(temp[0]=='0' && temp[1]=='0' && temp[2]=='0' && temp[3]=='1') s=s+"1";
     if(temp[0]=='0' && temp[1]=='0' && temp[2]=='1' && temp[3]=='0') s=s+"2";
     if(temp[0]=='0' && temp[1]=='0' && temp[2]=='1' && temp[3]=='1') s=s+"3";
     if(temp[0]=='0' && temp[1]=='1' && temp[2]=='0' && temp[3]=='0') s=s+"4";
     if(temp[0]=='0' && temp[1]=='1' && temp[2]=='0' && temp[3]=='1') s=s+"5";
     if(temp[0]=='0' && temp[1]=='1' && temp[2]=='1' && temp[3]=='0') s=s+"6";
     if(temp[0]=='0' && temp[1]=='1' && temp[2]=='1' && temp[3]=='1') s=s+"7";
     if(temp[0]=='1' && temp[1]=='0' && temp[2]=='0' && temp[3]=='0') s=s+"8";
     if(temp[0]=='1' && temp[1]=='0' && temp[2]=='0' && temp[3]=='1') s=s+"9";
     if(temp[0]=='1' && temp[1]=='0' && temp[2]=='1' && temp[3]=='0') s=s+"A";
     if(temp[0]=='1' && temp[1]=='0' && temp[2]=='1' && temp[3]=='1') s=s+"B";
     if(temp[0]=='1' && temp[1]=='1' && temp[2]=='0' && temp[3]=='0') s=s+"C";
     if(temp[0]=='1' && temp[1]=='1' && temp[2]=='0' && temp[3]=='1') s=s+"D";
     if(temp[0]=='1' && temp[1]=='1' && temp[2]=='1' && temp[3]=='0') s=s+"E";
     if(temp[0]=='1' && temp[1]=='1' && temp[2]=='1' && temp[3]=='1') s=s+"F";
     
     }
  
  }
  
  return s;
}







String addRes(String sch,int typ){
String temp=Integer.toBinaryString(sch.length());
String fStr="";

int n=15-temp.length();  
 for(int i=1;i<=n;i++)   
               temp="0"+temp;
 
 if(typ==1) temp="1"+temp;              
 else  temp="0"+temp;

 
 fStr=BinaryToHex(temp);
 
 if(typ==0){
   for(int i=0;i<sch.length();i++){
      temp=Integer.toHexString((int)sch.charAt(i)).toUpperCase();
      fStr=fStr+temp;
      
   }
 }
 else
 {
    temp=Integer.toHexString((int)sch.charAt(0)).toUpperCase();
    
    fStr=fStr+temp;
      
 }
 
 return fStr;
 }
 

 
String encoder(String ch){
String fch="",sch12="" ,sch="";
 
int i=0,j,cpt,vr;
char car;

while(i<ch.length()){
car=ch.charAt(i);
cpt=1;vr=1;
sch="";
sch+=car;
 j=i+1;  
    
    while(j<ch.length() && vr==1)
    {        
        if(ch.charAt(j)==car){
         sch+=ch.charAt(j);  
        cpt++;j++;
        }
        else
        vr=0;  
    }
    


   if(cpt>2){
     if(sch12!=""){
     fch+=addRes(sch12,0);
     sch12="";
     }
     
     fch+=addRes(sch,1);
   
   }else{
   sch12+=sch;
   
   
   } 
       
   i=i+cpt;

}         
    
     if(sch12!=""){
     fch+=addRes(sch12,0);
     sch12="";
     }

return fch;
} 

int HexcharToInt(char ch){
int c=(int)ch;
     
     if(c>=65) c-=55;
     else c-=48;

return c;
}

String decoder(String ch){
String sch="";
int i=0;int c,val,nb,j;
String temp,fch="";
try
{
 
  while(i<ch.length()){
  
  c=HexcharToInt(ch.charAt(i));
 
      temp="";sch="";

     if(c>=8){  
       c-=8;c+=48;
       
       temp=String.valueOf((char)(HexcharToInt(ch.charAt(i+4))*16+HexcharToInt(ch.charAt(i+5))));
       
       sch=sch+(char)c+ch.charAt(i+1)+ch.charAt(i+2)+ch.charAt(i+3);
       val=1;nb=0;
        
        j=sch.length()-1;
        while(j>=0){
        nb+=HexcharToInt(sch.charAt(j))*val;
        val*=16;
        j--;
        }
        
       for(j=0;j<nb;j++)
       {
  
          fch+=temp;
       } 
      
         i=i+6;
         }else{
            
           sch=sch+(char)c+ch.charAt(i+1)+ch.charAt(i+2)+ch.charAt(i+3);
       val=1;nb=0;
        
        j=sch.length()-1;
        while(j>=0){
        nb+=HexcharToInt(ch.charAt(j))*val;
        val*=16;
        j--;
        }
         println(nb);int y;
        for(j=i+4;j<i+2*nb+4;j=j+2){
          y=HexcharToInt(ch.charAt(j));println("y:"+y);
           y=HexcharToInt(ch.charAt(j+1));println("y:"+y);
       println("j:"+j+"::"+(HexcharToInt(ch.charAt(j))*16+HexcharToInt(ch.charAt(j+1)))) ;  
       fch+=String.valueOf((char)(HexcharToInt(ch.charAt(j))*16+HexcharToInt(ch.charAt(j+1)))); 
        } 
         
          
         
          
         i=i+2*nb+4;
  
         
         }
  
  
  



}


}
catch(StringIndexOutOfBoundsException e){
println("eerrr");

}
println(fch);
return fch;






} 


void setup(){
size(1000,800);
background(0);
}

void draw(){
  textSize(20);
fill(255);
if(draw==0){
     background(0);

  text("Input String: "+s_temp,20,50);
}
}

void keyPressed(){
s=new String();
if(key != '\n'){
t[taille]=key;
taille++;
s_temp=new String(t,0,taille);
}else{
s=new String(t,0,taille);
t=new char[55];
if(draw==0)
text("encoder String: "+encoder(s),20,100);
text("decoder String: "+decoder(encoder(s)),20,150);
taille=0;draw=1;
}



}
