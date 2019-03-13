/*void sendOSC(String s,float f){  
OscMessage myMessage = new OscMessage(s);    
myMessage.add(f);  
oscP5.send(myMessage,Reaper);
}

void sendOSC(String s,int i){  
OscMessage myMessage = new OscMessage(s);    
myMessage.add(i);  
oscP5.send(myMessage,Reaper);
}

void sendOSC(String s){  
OscMessage myMessage = new OscMessage(s);    
oscP5.send(myMessage,Reaper);
} */


void sendOSC(String s,float f) {
  
OscMessage myMessage=new OscMessage(s);
myMessage.add(f);
oscP5.send(myMessage,Reaper);
}

void sendOSC(String s,int i) {
  OscMessage myMessage = new OscMessage(s);  
  myMessage.add(i);
  oscP5.send(myMessage,Reaper);
}

void sendOSC(String s) {
  OscMessage myMessage = new OscMessage(s);  
  oscP5.send(myMessage,Reaper);
} 
