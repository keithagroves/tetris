static class BlockShapes{
  public static final int[][] shape1 =  {
    {0,0,0,0,0,0},
    {0,0,0,0,0,0},
    {0,2,2,2,2,0},
    {0,0,0,0,0,0},
    {0,0,0,0,0,0}
  };
  public static final int[][] shape2 =  {
    {0,0,0,0,0},
    {0,0,0,1,0},
    {0,1,1,1,0},
    {0,0,0,0,0},
    {0,0,0,0,0}
  };
  public static final int[][] shape3 =  {
    {0,0,0,0},
    {0,3,3,0},
    {0,3,3,0},
    {0,0,0,0}
  };
  public static final int[][] shape4 =  {
    {0,0,0,0,0},
    {0,4,4,0,0},
    {0,0,4,4,0},
    {0,0,0,0,0},
    {0,0,0,0,0}
  };
    public static final int[][] shape5 =  {
    {0,0,0,0,0},
    {0,0,5,0,0},
    {0,5,5,5,0},
    {0,0,0,0,0},
    {0,0,0,0,0}
  };
  
   public static final int[][] shape6 =  {
    {0,0,0,0,0},
    {0,6,0,0,0},
    {0,6,6,6,0},
    {0,0,0,0,0},
    {0,0,0,0,0}
  };
    public static final int[][] shape7 =  {
    {0,0,0,0,0},
    {0,0,7,7,0},
    {0,7,7,0,0},
    {0,0,0,0,0},
    {0,0,0,0,0}
  };
  
  
  public static final int[][][] shapes = {shape1, shape2, shape3,shape4, shape5, shape6, shape7};
  public static int[][] getRandomShape(){
      int[][] grid = shapes[(int)(Math.random()*shapes.length)];
      int[][] tempGrid = new int[grid.length][grid[0].length];
      for(int i = 0; i < grid.length; i++){
        arrayCopy(grid[i], tempGrid[i]);
      }
      return tempGrid;
  }
}
