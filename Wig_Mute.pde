class wigBtnM{
  int x,y,size;
  color onc,offc;
  color currentc;
  boolean btnon;
  boolean confirmedstate;
  wigBtnM(int _x,int _y,int _size){
    x = _x;
    onc = 128;
    y = _y;
    size = _size;  
    btnon = false;
    confirmedstate = false;
  }  
  void draw(){
    if(confirmedstate)
       fill(255,0,0);
    else
       fill(onc);
     rect(x,y,size,size);   
  }
  
  boolean togglebtn(){
    if(mousePressed && mouseX > x && mouseX < x+size && mouseY > y && mouseY < y+size){
       btnon = !btnon;
       return true;
    }
    return false;
  }
 }
