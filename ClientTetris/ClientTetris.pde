import processing.net.*; 
int COLS = 10;
int ROWS = 20;
byte [][] board = new byte[COLS][ROWS];
byte [][] serverBoard = new byte[COLS][ROWS];
Client myClient; 
int level = 0;
byte id = 0;
public static final byte ID_MESSAGE = -99;
public static final byte CONTROL_MESSAGE = -100;


void setup() {
  size(610, 600);
  width/=2;
  myClient = new Client(this, "localhost", 5204);
}

void draw() {
  background(0);
  drawPlayerScreen(board, true);
  drawPlayerScreen(serverBoard, false);
  fill(255);
  rect(width, 0, Constants.GAP, height);
}




void drawPlayerScreen(byte [][] b, boolean self) {
 
  for (int y = 0; y < ROWS; y++) {
    for (int x = 0; x < COLS; x++) {

      if (b[x][y] == 1) {
        fill(0, 200, 0);
      } else if (b[x][y] ==2) {
        fill(50, 200, 200);
      } else if (b[x][y] == 3) {
        fill(224, 25, 255);
      } else if (b[x][y] ==4) {
        fill(123, 200, 0);
      } else if (b[x][y] ==5) {
        fill(200, 256, 0);
      } else if (b[x][y] == 6) {
        fill(224, 255, 25);
      } else if (b[x][y] ==7) {
        fill(0, 200, 255);
      } else {
        noFill();
      }
      if (self) {
        rect(x*(width/COLS), y*(height/ROWS), width/COLS, height/ROWS);
      } else {
        rect(x*(width/COLS)+width+Constants.GAP, y*(height/ROWS), width/COLS, height/ROWS);
      }
    }
  }
}

void keyPressed() {
  if (keyCode == RIGHT) {
    myClient.write(new byte[]{this.id, (byte)RIGHT});
  }
  if (keyCode == LEFT) {
    myClient.write(new byte[]{this.id, (byte)LEFT});
  }
  if (keyCode == UP) {
    myClient.write(new byte[]{this.id, (byte)UP});
  }
  if (keyCode == DOWN) {
    myClient.write(new byte[]{this.id, (byte)DOWN});
  }
  if (keyCode == ' ') {
    myClient.write(new byte[]{this.id, (byte)' '});
  }
}

void clientEvent(Client someClient) {
 
  byte [] data = someClient.readBytes();
  if(this.id == 0 && data[0] == ID_MESSAGE){
      this.id = data[1];
      println(this.id);
   }
  println(data.length);
  if(data.length <= COLS*ROWS+1){
  byte id = data[data.length-1];
  if (id == this.id) {
    updateData(this.board, data);
  } else {
    updateData(this.serverBoard, data);
  }
  } else{
    someClient.clear();
  }

}

void updateData(byte [][] b, byte [] data){
  for (int i = 0; i < b.length; i++) {
      for (int j = 0; j < b[i].length; j++) { 
        if (i + (j * b.length) < data.length)
          b[i][j]= data[i + (j * serverBoard.length)];
      }
    }
}
