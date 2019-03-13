class wigFader {
  int x,y,w,h;
  color onc,offc;
  color curc;
  float faderval;
  boolean faderactive,isdirty;
  wigFader(int _x, int _y, int _w, int _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    onc = 0;
    offc = 177;
    curc = 255;
    faderactive = false;
    faderval = 0.5;
  } 
  void draw(){
    fill(offc);
    rect(x,y,w,h); 
    
    fill(onc);
    rect(x,y+h*(1-faderval),w,h*faderval);
  } 
  void update(){
    // if(mousePressed && mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h){
      if(faderactive) {
        
        faderval = 1.0 - (mouseY-y)/float(h);
        faderval=constrain(faderval,0.0,1.0);
        curc = onc;
        isdirty = true;
     }
     else
     curc=offc;
  }
   void mousePressed() {
    if(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h)
      faderactive = true;   
  }
  void mouseReleased() {     
  faderactive = false;
  }
}
