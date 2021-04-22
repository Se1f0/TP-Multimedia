PImage frame1,frame2,redRect1,test;

ArrayList<Cordonee> position_rect_rouge = new ArrayList<Cordonee>();

int wRed,hRed,wGreen,hGreen;
int xRed,yRed,xGreen,yGreen;
int draw;

boolean showFrame1 = true,showFrame2 = false;

void setup() {
    draw = 0;
    size(1920, 1080);
    frame1 = loadImage("frame1.png");
    frame2 = loadImage("frame2.png");
    displayFrame1();
}

void draw() {
}