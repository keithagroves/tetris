int COLS = 10;
int ROWS = 20;
ShapeManager shapeManager;
int [][] board = new int[COLS][ROWS];
void setup(){
 size(300,600);
 shapeManager = new ShapeManager(board);
}

void draw(){
   background(255);
  if(frameCount%100==0)
    shapeManager.moveDown();
  drawBackground();
  shapeManager.drawBlock();
}

void drawBackground(){
   background(0);
   for(int y = 0; y < ROWS; y++){
    for(int x = 0; x < COLS; x++){
      
      if(board[x][y] ==1){
            fill(0,200,0);
         }
      else if(board[x][y] ==2){
            fill(50, 200, 200);
      }
      else if(board[x][y] == 3){
         fill(224,25,255); 
      }
      else if(board[x][y] ==4){
            fill(123,200,0);
         }
      else if(board[x][y] ==5){
            fill(200,256,0);
      }
      else if(board[x][y] == 6){
         fill(224,255,25); 
      }
      else if(board[x][y] ==7){
            fill(0,200,255);
         }
     
       else{
        noFill(); 
       }
      rect(x*(width/COLS), y*(height/ROWS), width/COLS, height/ROWS); 
    }
  } 
  
}

void keyPressed(){
   if(keyCode == RIGHT){
      shapeManager.right(); 
   }
   if(keyCode == LEFT){
      shapeManager.left(); 
   }
   if(keyCode == ' '){
       shapeManager.rotate();
   }
   if(keyCode == DOWN){
      shapeManager.moveDown(); 
   }
}
