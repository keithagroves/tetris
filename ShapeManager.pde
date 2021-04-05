class ShapeManager{
  int y = 0;
  int x = 0;
  int [][]grid = BlockShapes.shape1;
  int [][]board;
  int level;
  
  public ShapeManager(int [][]board){
    this.board = board;
  }
  
  boolean moveDown(){
     if(checkCollision(x, y+1)){
       y++; 
       return true;
     } else {
       resetShape(); 
       checkLines();
       level+=1;
       return false;
     }
  }
  
  void checkLines(){
     for(int y = 0; y < board[0].length; y++){
        boolean line = true;
        for(int x = 0; x< board.length; x++){
                if(board[x][y] == 0){
                    line = false;
                }
        }
        if(line){
           println("line created!");
           int tempRow = y;
           while(tempRow > 0){
              for(int x = 0; x< board.length; x++){
               board[x][tempRow] = board[x][tempRow-1];
        }
               tempRow--;
           }
        }
     }
  }
  void resetShape(){
     for(int row = 0; row< grid.length; row++){
        for(int col = 0; col < grid[0].length; col++){
           if(grid[row][col] > 0){
             try{
             board[col+x][row+y]= grid[row][col];  
             }catch(Exception e){
               println("you're lazy!");
               }
           }
        }
     }
     this.grid = BlockShapes.shapes[(int)random(0,4)];
     this.y = -2;
     this.x = (int)random(0,5);
  }
  
  void right(){
    if(checkCollision(x+1, y)){
       x++;
    } 
     
  }
   void left(){
     if(checkCollision(x-1, y)){
        x--;
     }
  }
  boolean checkCollision(int tempX, int tempY){
      for(int row = 0; row < grid.length; row++){
         for(int col = 0; col < grid[0].length; col++){
            if( grid[row][col] > 0 && tempY+row > board[0].length-1){
              return false;
            }
            else if(tempY+row > board[0].length -1){
              continue;
            }
            if( grid[row][col] > 0 && (tempX+col > board.length-1 || tempX+col < 0)){
              return false;
            }
            else if(tempX+col  > board.length-1 || tempX+col  < 0){
              continue;
            }
            if(tempY+row < 0)
              continue;
         
              
            if(grid[row][col] > 0 && board[tempX+col][tempY+row] > 0){
               return false; 
            }
            
         }
      }
      return true;
  }

  void rotate(){
      int[][] tempGrid = new int[grid.length][grid[0].length];
      for(int i = 0; i < grid.length; i++){
        arrayCopy(grid[i], tempGrid[i]);
      }
      
      int N = grid.length;
           // Consider all squares one by one
        for (int x = 0; x < N / 2; x++) {
            // Consider elements in group
            // of 4 in current square
            for (int y = x; y < N - x - 1; y++) {
                // Store current cell in
                // temp variable
                int temp = grid[x][y];
  
                // Move values from right to top
                grid[x][y] = grid[y][N - 1 - x];
  
                // Move values from bottom to right
                grid[y][N - 1 - x]
                    = grid[N - 1 - x][N - 1 - y];
  
                // Move values from left to bottom
                grid[N - 1 - x][N - 1 - y] = grid[N - 1 - y][x];
  
                // Assign temp to left
                grid[N - 1 - y][x] = temp;
            }
        }
        if(!checkCollision(x,y)){
           for(int i = 0; i < grid.length; i++){
            arrayCopy(tempGrid[i], grid[i]);
      }
        }
  }
  void drawBlock(){
    for(int row =0; row < grid.length; row++){
       for(int col = 0 ; col < grid[row].length; col++){
           if(grid[row][col] ==1){
            fill(0,200,0);;
         }
      else if(grid[row][col] ==2){
            fill(50, 200, 200);
      }
      else if(grid[row][col] == 3){
         fill(224,25,255); 
      }
      else if(grid[row][col] ==4){
            fill(123,200,0);
         }
      else if(grid[row][col] ==5){
            fill(200,256,0);
      }
      else if(grid[row][col] == 6){
         fill(224,255,25); 
      }
      else if(grid[row][col] ==7){
            fill(0,200,255);
         }
         if(grid[row][col]>0){
             rect((col+x)*(width/COLS), (row+y)*(height/ROWS),width/COLS, height/ROWS); 
       }
      }
    }
  }
}

        
