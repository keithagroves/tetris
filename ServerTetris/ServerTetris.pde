import processing.net.*; 
import java.util.Map;
  
public static final int COLS = 10;
public static final int ROWS = 20;
HashMap<Byte, ShapeManager> players = new HashMap<Byte, ShapeManager>();

boolean newClient;
byte id = (byte)random(0, 10000);
Server myServer;
public static final byte ID_MESSAGE = -99;
public static final byte CONTROL_MESSAGE = -99;

int level = 0; 
void setup() {
  size(610, 600);
  width = width/2;

  myServer = new Server(this, 5204);
}

void draw() {
  background(255);
  if (frameCount%(100-Math.min(level, 99))==0) {
    gameStep();
  }
  talkToClient();  
  background(0);
  //drawPlayerScreen(board, false);
  ///drawPlayerScreen(serverBoard, true);
  //shapeManager.drawBlock(false);
  //shapeManager2.drawBlock(true);
  for(ShapeManager sm: players.values()){
      drawPlayerScreen(sm.board, false);
  }
  
  fill(255);
  rect(width, 0, 10, height);
}

void gameStep() {
  for(ShapeManager sm : players.values()){
    sm.moveDown();
    myServer.write(output(sm.board, sm.id));
    
  }

}

void talkToClient() {
  Client thisClient = myServer.available();
  if (thisClient !=null) {
    if (thisClient.active() ) {
        byte [] message = thisClient.readBytes();
        if(players.get(message[0]) != null){
          println(players.get(message[0]));
          keyPress(message[1], message[0]);
          myServer.write(output(players.get(message[0]).board, message[0]));
        } else{
           println("player" + message[0]+" does not exist"); 
        }
        }
      
    }
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
        rect(x*(width/COLS), y*(height/ROWS), width/COLS, height/ROWS);
      } else {
        rect(x*(width/COLS)+width+Constants.GAP, y*(height/ROWS), width/COLS, height/ROWS);
      }
    }
  }
}

void keyPress(int keyCod, byte id) {
  ShapeManager sm = players.get(id);
  if (keyCod == RIGHT) {
    sm.right();
  }
  if (keyCod == LEFT) {
    sm.left();
  }
  if (keyCod == UP) {
    sm.rotate();
  }
  if (keyCod == DOWN) {
    sm.moveDown();
  }
  if (keyCod == ' ') {
    while (sm.moveDown()) {
    };
  }
}



// ServerEvent message is generated when a new client connects 
// to an existing server.
void serverEvent(Server someServer, Client someClient) {
  println("client connected "+someClient.ip());
  byte playerId = (byte)random(0,1000);
  
  players.put((byte)playerId, new ShapeManager(playerId));
  
  someClient.write(new byte[]{ID_MESSAGE, playerId});
}

public byte[] output(byte[][] input, byte id) {
    return serialize( players.get(id), input);
}

byte[] serialize( ShapeManager sm, byte[][] input) {
  byte[][] tempGrid = new byte[input.length][input[0].length];
  for (int i = 0; i < input.length; i++) {
    arrayCopy(input[i], tempGrid[i]);
  }
  int[][] grid = sm.grid;
  for (int row = 0; row< grid.length; row++) {
    for (int col = 0; col < grid[0].length; col++) {
      if (grid[row][col] > 0) {
        try {
          tempGrid[col+sm.x][row+sm.y]= (byte)grid[row][col];
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
  out[out.length-1] = sm.id;
  return out;
}
