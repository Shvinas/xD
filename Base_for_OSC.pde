import netP5.*;
import oscP5.*;

int q=7;

wigBtn[] buttonsSolo=new wigBtn[q]; //number of channels 

wigBtnM[] buttonsMute=new wigBtnM[q];                          //mute buttons

wigBtn[] buttonPlay=new wigBtn[1];                             //play/pause button

int numtracks=q;      //max value of channels which could be runned in programe
int spacing=40;
int spacing1=75;
int pantracks=q;

wigPan[] pan=new wigPan[pantracks];     //pan function 

wigFader[] fader=new wigFader[numtracks];

OscP5 oscP5;
NetAddress Reaper;

void setup(){
  size(600,600);     //size of the programe screan (X,Y) coordinates 
  frameRate(25);
  
  oscP5= new OscP5(this,9000);
  Reaper=new NetAddress("127.0.0.1",8000);     //comunication part between Processing and Reaper
  
  for(int i=0;i<numtracks;i++)
     fader[i]=new wigFader(20+(i*spacing),60,30,160);                //fader
     
  for(int i=0;i<pantracks;i++)
     pan[i]=new wigPan(20+(i*spacing1),400,50,20);                  //PAN 
  
  for(int i=0;i<buttonsSolo.length;i++)
     buttonsSolo[i]=new wigBtn(20+i*40,20,30);                       //Solo buttons
     
  for(int i=0;i<buttonsMute.length;i++)
     buttonsMute[i]=new wigBtnM(20+i*40,300,30);                     //mute buttons
     
  for(int i=0;i<buttonPlay.length;i++)
     buttonPlay[i]=new wigBtn(20+i*40,240,30);                       //play pause button
     
  
  //fader=new wigFader(20,60,30,160);     // simple fader 
 
 sendOSC("/device/track/count",numtracks);  
 sendOSC("/action/41743");    // comunication between reaper and processing
}

void draw(){
  background(50,75,175);   //background colour RGB
  
  for(int i=0;i<buttonsSolo.length;i++)
    buttonsSolo[i].draw();                                     //solo button 
    
  for(int i=0;i<buttonsMute.length;i++)
    buttonsMute[i].draw();                                   //mute button
  
  for(int i=0;i<buttonPlay.length;i++)
    buttonPlay[i].draw();                                    //play/pause button
  
  for(int i=0;i<numtracks;i++) {
    fader[i].update();
    fader[i].draw();
    
    if(fader[i].isdirty) {
      sendOSC("/track/"+(i+1)+"/volume",fader[i].faderval);
      fader[i].isdirty=false;
    }

/*fader[i].update();
fader[i].draw();*/

  fill(255);
  textSize(9);
  text(fader[i].faderval,20+(i*spacing),120); 
  }
  
    for(int i=0;i<pantracks;i++) {
    pan[i].update();
    pan[i].draw();
    
    if(pan[i].isdirty) {
      sendOSC("/track/"+(i+1)+"/pan",pan[i].panval);
      pan[i].isdirty=false;
    }
    fill(0,0,0);
    textSize(9);
    text(pan[i].panval,20+(i*spacing1),450);                //Pan Faders
  }
  
}

void mousePressed(){
    
  for(int i=0;i<buttonsSolo.length;i++){
    
    if(buttonsSolo[i].togglebtn()){
      
      OscMessage myMessage=new OscMessage("/track/"+(i+1)+"/solo");
      if(buttonsSolo[i].btnon)
        myMessage.add(1.0);
      else
        myMessage.add(0.0);
      oscP5.send(myMessage, Reaper);
    }
  }
  
  for(int i=0;i<buttonPlay.length;i++) {
    
    if(buttonPlay[i].togglebtn()) {
      OscMessage myMessage=new OscMessage("/play");
      if(buttonPlay[i].btnon)
        myMessage.add(1.0);
      else
        myMessage.add(0.0);
      oscP5.send(myMessage, Reaper);
    }
  }                                                         //play/pause button
  
  for(int i=0;i<buttonsMute.length;i++) {
    
    if(buttonsMute[i].togglebtn()){
      
      OscMessage myMessage=new OscMessage("/track/"+(i+1)+"/mute");
      if(buttonsMute[i].btnon)
        myMessage.add(1.0);
      else
        myMessage.add(0.0);
      oscP5.send(myMessage, Reaper);
    }
  }
  
   for(int i=0;i<numtracks;i++)
    fader[i].mousePressed();
    
  for(int i=0;i<pantracks;i++)
    pan[i].mousePressed();       //PAN
}
void mouseReleased()
{
  //wrap mouseReleased to each fader's version
  for(int i=0;i<numtracks;i++)
    fader[i].mouseReleased();
    
  for(int i=0;i<pantracks;i++)
    pan[i].mouseReleased();       //PAN
    
}  
// code for solo butons to react and sand signals from programe to reaper and back

void oscEvent(OscMessage TheOscMessage) {
  String addr=TheOscMessage.addrPattern();
  
  String[] adarray=split(addr,"/");
  int trnum=0;
  if(adarray.length==4 && adarray[1].equals("track") && adarray[3].equals("volume") && TheOscMessage.checkTypetag("f")) {
    trnum=int(adarray[2]);
      if(trnum<=numtracks) {
        fader[trnum-1].faderval=TheOscMessage.get(0).floatValue();
      }
  }
  
  if(adarray.length==4 && adarray[1].equals("track") && adarray[3].equals("pan") && TheOscMessage.checkTypetag("f")) {
    trnum=int(adarray[2]);
      if(trnum<=pantracks) {
        pan[trnum-1].panval=TheOscMessage.get(0).floatValue();
      }
  }      //PAN
  
  if(adarray.length>3 && adarray[1].equals("track") && adarray[3].equals("solo")){
    trnum=int(adarray[2]);
    buttonsSolo[trnum-1].confirmedstate=boolean(int(TheOscMessage.get(0).floatValue()));
  }
  
   if(adarray.length>3 && adarray[1].equals("track") && adarray[3].equals("mute")){
    trnum=int(adarray[2]);
    buttonsMute[trnum-1].confirmedstate=boolean(int(TheOscMessage.get(0).floatValue()));
  }
  
  
  if(adarray.length>1 && adarray[1].equals("play")) {
    trnum=int(adarray[1]);
    buttonPlay[trnum].confirmedstate=boolean(int(TheOscMessage.get(0).floatValue()));
  }
  
  print("### received an osc message.");
  print("addrpattern:"+TheOscMessage.addrPattern());
  println("typetag:"+TheOscMessage.typetag());
}
  
  /*
  print("### recieved an osc message.");
  print(" addrpattern: "+TheOscMessage.addrPattern());
  println("typetag: "+TheOscMessage.typetag());
} */
