class wigPan{
  int x,y,w,h;
  color onc,offc;
  color curc;
  float panval;
  boolean panactive,isdirty;
  wigPan(int _x, int _y, int _w, int _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    onc = 0;
    offc = 177;
    curc = 255;
    panactive = false;
    panval = 0.5;
  } 
  void draw(){
    fill(offc);
    rect(x,y,w,h); 
    
    fill(offc);
    rect(x,y/*+h*(1-panval)*/,w*(panval),h);
  } 
  void update(){
      if(panactive) {
        
        panval = 1.0 - (mouseX-x)/float(w);
        panval=constrain(1-panval,0.0,1.0);
        curc = onc;
        isdirty = true;
     }
     else
     curc=offc;
  }
   void mousePressed() {
    if(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h)
      panactive = true;   
  }
  void mouseReleased() {     
  panactive = false;
  }
}
