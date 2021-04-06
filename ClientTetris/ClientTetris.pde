import processing.net.*; 
int COLS = 10;
int ROWS = 20;
byte [][] board = new byte[COLS][ROWS];
byte [][] enemyBoard = new byte[COLS][ROWS];
Client myClient; 
int level = 0;

void setup() {
  size(600, 600);
  width/=2;
  myClient = new Client(this, "localhost", 5204);
}

void draw() {
  background(255);
   background(0);
  drawPlayerScreen(board, true);
  drawPlayerScreen(enemyBoard, false);
  fill(255);
  rect(width, 0, 10, height);
}




void drawPlayerScreen(byte [][] b, boolean self) {
 
  for (int y = 0; y < ROWS; y++) {
    for (int x = 0; x < COLS; x++) {

      if (b[x][y] ==1) {
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
        rect(x*(width/COLS)+width, y*(height/ROWS), width/COLS, height/ROWS);
      }
    }
  }
}

void keyPressed() {
  if (keyCode == RIGHT) {
    myClient.write(RIGHT);
  }
  if (keyCode == LEFT) {
    myClient.write(LEFT);
  }
  if (keyCode == UP) {
    myClient.write(UP);
  }
  if (keyCode == DOWN) {
    myClient.write(DOWN);
  }
  if (keyCode == ' ') {
    myClient.write(' ');
  }
}

void clientEvent(Client someClient) {
  byte [] data = someClient.readBytes();
  byte id = data[data.length-1];
  if (id == 99) {
    updateData(this.board, data);
  } else if(id ==0) {
    updateData(this.enemyBoard, data);
  }

}

void updateData(byte [][] b, byte [] data){
  for (int i = 0; i < b.length; i++) {
      for (int j = 0; j < b[i].length; j++) { 
        if (i + (j * b.length) < data.length)
          b[i][j]= data[i + (j * enemyBoard.length)];
      }
    }
}
