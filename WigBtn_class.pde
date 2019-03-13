/*class wigBtn{
  int x,y,size;
  color onc,offc;
  color currentc;
  boolean btnon;
  
  wigBtn(int _x,int _y,int _size){
    x = _x;
    y = _y;
    size = _size;  
    onc = 128;
    offc = 255; 
  }  
  
  void draw(){
    if(btnon)
       fill(onc);
    else
       fill(offc);
     rect(x,y,size,size);   
  }
  
  boolean togglebtn(){
    if(mousePressed && mouseX > x && mouseX < x+size && mouseY > y && mouseY < y+size)
    {
       btnon = !btnon;
       return true;
    }
    return false;
  }
}
 */
 
 class wigBtn{
  int x,y,size;
  color onc,offc;
  color currentc;
  boolean btnon;
  boolean confirmedstate;
  wigBtn(int _x,int _y,int _size){
    x = _x;
    y = _y;
    size = _size;  
    onc = 128;
    offc = 255; 
    btnon = false;
    confirmedstate = false;
  }  
  void draw(){
    if(confirmedstate)
       fill(255,255,0);
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
