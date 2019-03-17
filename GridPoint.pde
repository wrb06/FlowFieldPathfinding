class GridPoint{
   public int X;
   public int Y;
   public int Cost;
   public int IFValue;
   
   public GridPoint(int x, int y, int c){
     X = x;
     Y = y;
     Cost = c;
     IFValue = Integer.MAX_VALUE;
   }
}
