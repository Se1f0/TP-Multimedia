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

public class TP4 extends PApplet {

PImage frame1,frame2,redRect1,test;

ArrayList<Cordonee> position_rect_rouge = new ArrayList<Cordonee>();

int wRed,hRed,wGreen,hGreen;
int xRed,yRed,xGreen,yGreen;
int draw;

boolean showFrame1 = true,showFrame2 = false;

public void setup() {
    draw = 0;
    
    frame1 = loadImage("frame1.png");
    frame2 = loadImage("frame2.png");
    displayFrame1();
}

public void draw() {
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
public void mousePressed() {
    if (showFrame1) {
        position_rect_rouge.add(new Cordonee(mouseY,mouseX));   
    }
}

public void mouseReleased() {
    if (showFrame1) {
        displayFrame1();
        position_rect_rouge.add(new Cordonee(mouseY,mouseX));
        xRed = position_rect_rouge.get(0).getJ();
        yRed = position_rect_rouge.get(0).getI();
        hRed = position_rect_rouge.get(1).getI() - position_rect_rouge.get(0).getI();
        wRed = position_rect_rouge.get(1).getJ() - position_rect_rouge.get(0).getJ();
        xGreen = xRed - 80;
        yGreen = yRed - 80;
        hGreen = hRed + 160;
        wGreen = wRed + 160;
        position_rect_rouge.get(0).getJ();
        stroke(255, 0, 0);
        noFill();
        rect(xRed, yRed, wRed, hRed);
        
        redRect1 = frame1.get(xRed,yRed,wRed,hRed);

        stroke(0,255,0);
        rect(xGreen, yGreen, wGreen, hGreen);
        println("xGreen0: "+xGreen+" yGreen0: "+yGreen);
        println("xGreen1: "+(xGreen+wGreen)+" yGreen1: "+(yGreen+hGreen));
        position_rect_rouge.clear();   
    }
}

public void keyPressed() {
    if (key == DELETE && showFrame1 == true) {
        displayFrame1();
        xRed = 0;
        yRed = 0;
        hRed = 0;
        wRed = 0;
    }
    if (keyCode == 39) {
        if (!showFrame2) {
            background(255);
            displayFrame2();   
            showFrame2 = true;
            showFrame1 = false;
            
            stroke(0,255,0);
            noFill();
            rect(xGreen, yGreen, wGreen, hGreen);

            stroke(255,0,0);
            noFill();
            rect(xRed, yRed, wRed, hRed);

            findSim();
        }        
    }
    if (keyCode == 37) {
        if (!showFrame1) {
            background(255);
            displayFrame1();
            showFrame2 = false;
            showFrame1 = true;
            xGreen = 0;
            yGreen = 0;
            hGreen = 0;
            wGreen = 0;
            xRed = 0;
            yRed = 0;
            hRed = 0;
            wRed = 0;
        }
    }
}

public void displayFrame1() {
    image(frame1, 0, 0,1920,1080);
    textSize(50);
    fill(0, 0, 255);
    text("Frame 1",900,1000);
}

public void displayFrame2() {
    image(frame2, 0, 0,1920,1080);
    textSize(50);
    fill(0, 0, 255);
    text("Frame 2",900,1000);
}

public float compareImage(PImage image2) {
    image2.loadPixels();
    redRect1.loadPixels();
    float mse = 0;
    for (int i = 0; i < redRect1.pixels.length; i++) {
        float y1,y2,r,g,b;
        r = red(redRect1.pixels[i]);
        g = green(redRect1.pixels[i]);
        b = blue(redRect1.pixels[i]);
        y1 = rgb2yuv(r,g,b);
        r = red(image2.pixels[i]);
        g = green(image2.pixels[i]);
        b = blue(image2.pixels[i]);
        y2 = rgb2yuv(r,g,b);
        float temp = y1-y2;
        temp = temp * temp;
        mse += temp;
    }
    mse = mse / (hRed*wRed);
    return mse;
}

public void findSim() {
    float minMse = Float.MAX_VALUE;
    Cordonee finalePos = null;
    for (int i = yGreen; i < (yGreen+hGreen-hRed); i+=10) {
        println(i);
        for (int j = xGreen; j < (xGreen+wGreen-wRed); j+=10) {
            PImage image2 = frame2.get(j,i,wRed,hRed);
            float mse = compareImage(image2);
            if (mse < minMse) {
                minMse = mse;
                finalePos = new Cordonee(i,j);
            }
        }
    }
    if (finalePos != null) {
        stroke(255,255,0);
        noFill();
        rect(finalePos.getJ(), finalePos.getI(), wRed, hRed);   
    }
}

public float rgb2yuv(float r,float g,float b) {
    float y;
    y = 0.299f*r + 0.587f*g + 0.114f*b;
    return y;
}
  public void settings() {  size(1920, 1080); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TP4" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
