import processing.net.*; 
int COLS = 10;
int ROWS = 20;


ShapeManager shapeManager;
ShapeManager shapeManager2;

byte [][] board = new byte[COLS][ROWS];
byte [][] enemyBoard = new byte[COLS][ROWS];

Server myServer;


void setup() {
  size(600, 600);
  width = width/2;
  shapeManager = new ShapeManager(board);
  shapeManager2 = new ShapeManager(enemyBoard);
  myServer = new Server(this, 5204);
}

void draw() {
  background(255);
  if (frameCount%(100-Math.min(shapeManager2.level, 99))==0) {
    shapeManager2.moveDown();
    shapeManager.moveDown();
     myServer.write(output(enemyBoard, true));
     myServer.write(output(board, false)); 
  }
  Client thisClient = myServer.available();
  if (thisClient !=null) {
    if (thisClient.active()) {
      keyPress(thisClient.read());
      myServer.write(output(board, false)); 
    }
  }
  background(0);
  drawPlayerScreen(board, true);
  drawPlayerScreen(enemyBoard, false);
  shapeManager.drawBlock(false);
  shapeManager2.drawBlock(true);
  fill(255);
  rect(width, 0, 10, height);
}

void drawPlayerScreen(byte [][] board, boolean self) {
  
  for (int y = 0; y < ROWS; y++) {
    for (int x = 0; x < COLS; x++) {
      if (board[x][y] ==1) {
        fill(0, 200, 0);
      } else if (board[x][y] ==2) {
        fill(50, 200, 200);
      } else if (board[x][y] == 3) {
        fill(224, 25, 255);
      } else if (board[x][y] ==4) {
        fill(123, 200, 0);
      } else if (board[x][y] ==5) {
        fill(200, 256, 0);
      } else if (board[x][y] == 6) {
        fill(224, 255, 25);
      } else if (board[x][y] ==7) {
        fill(0, 200, 255);
      } else {
        noFill();
      }
      if (self) {
        rect(x*(width/COLS)+width, y*(height/ROWS), width/COLS, height/ROWS);
      } else {
        rect(x*(width/COLS), y*(height/ROWS), width/COLS, height/ROWS);
      }
    }
  }
}

void keyPress(int keyCod) {
  if (keyCod == RIGHT) {
    shapeManager.right();
  }
  if (keyCod == LEFT) {
    shapeManager.left();
  }
  if (keyCod == UP) {
    shapeManager.rotate();
  }
  if (keyCod == DOWN) {
    shapeManager.moveDown();
  }
  if (keyCod == ' ') {
    while (shapeManager.moveDown()) {
    };
  }

}

void keyPressed() {
  if (keyCode == RIGHT) {
    shapeManager2.right();
  }
  if (keyCode == LEFT) {
    shapeManager2.left();
  }
  if (keyCode == UP) {
    shapeManager2.rotate();
  }
  if (keyCode == DOWN) {
    shapeManager2.moveDown();
  }
  if (keyCode == ' ') {
    while (shapeManager2.moveDown()) {
    };
  }
    myServer.write(output(enemyBoard, true));
}

// ServerEvent message is generated when a new client connects 
// to an existing server.
void serverEvent(Server someServer, Client someClient) {
  println("client connected");
}

public byte[] output(byte[][] input, boolean self) {
  byte id = 0;
  if (self) {
    id = 0;
    byte[][] tempGrid = new byte[input.length][input[0].length];
    for (int i = 0; i < input.length; i++) {
      arrayCopy(input[i], tempGrid[i]);
    }
    int[][] grid = shapeManager2.grid;
    for (int row = 0; row< grid.length; row++) {
      for (int col = 0; col < grid[0].length; col++) {
        if (grid[row][col] > 0) {
          try {
            tempGrid[col+shapeManager2.x][row+shapeManager2.y]= (byte)grid[row][col];
          }
          catch(Exception e) {
            println("you're lazy!");
          }
        }
      }
    }

    byte[] out = new byte[tempGrid.length * tempGrid[0].length + 1];
    for (int i = 0; i < tempGrid.length; i++) {
      for (int j = 0; j < tempGrid[i].length; j++) { 
        out[i + (j * tempGrid.length)] = tempGrid[i][j];
      }
    }
    out[out.length-1] = id;
    return out;
  } else {
    id = 99;
    byte[][] tempGrid = new byte[input.length][input[0].length];
    for (int i = 0; i < input.length; i++) {
      arrayCopy(input[i], tempGrid[i]);
    }
    int[][] grid = shapeManager.grid;
    for (int row = 0; row< grid.length; row++) {
      for (int col = 0; col < grid[0].length; col++) {
        if (grid[row][col] > 0) {
          try {
            tempGrid[col+shapeManager.x][row+shapeManager.y]= (byte)grid[row][col];
          }
          catch(Exception e) {
            println("you're lazy!");
          }
        }
      }
    }

    byte[] out = new byte[tempGrid.length * tempGrid[0].length + 1];
    for (int i = 0; i < tempGrid.length; i++) {
      for (int j = 0; j < tempGrid[i].length; j++) { 
        out[i + (j * tempGrid.length)] = tempGrid[i][j];
      }
    }
    out[out.length-1] = id;
    return out;
  }
}
