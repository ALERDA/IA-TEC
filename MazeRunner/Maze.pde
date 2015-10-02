public class Maze{
  public Node[][] mazeMap;
  int mapLength;
  int mapWidth;
  
  public Maze(){
  }
  
 void mapSetup(int xWidth, int yLength,int[][] valuesMaze){
    mapLength=yLength;
    mapWidth=xWidth;
    int id=0;
    mazeMap = new Node[mapWidth][mapLength];
    for ( int row = 0; row < mapWidth; row++ ){
      for ( int col = 0; col < mapLength; col++ )
      {
        Node node=new Node(row,col,id,valuesMaze[row][col]);
        mazeMap[row][col] = node; 
        id++;
      }
    }
  }
 
  public int getMapLength(){
    return mapLength;
  }

  public int getMapWidth(){
    return mapWidth;
  }
  
  public Node[][] getMap(){
    return mazeMap;
  }
  
  public void printMap(int scaleSquare){
    int Scale=scaleSquare;
    int coloractual;
    PVector Color1=new PVector(255,255,255); //black
    PVector Color2=new PVector(0,0,0); //white
    System.out.println("Map Print");
    Node nodeTmp= new Node();
    for ( int row = 0; row < mapWidth; row++ ){
      for ( int col = 0; col < mapLength; col++ )
      {
        nodeTmp=mazeMap[row][col];
        System.out.print(nodeTmp.getItemType()+" ");
        coloractual=nodeTmp.getItemType();
        if (coloractual==0){
          fill(Color1.x,Color1.y,Color1.z);
        }
        else{
          fill(Color2.x,Color2.y,Color2.z);
        }
      rect(col*Scale,row*Scale,Scale,Scale);
      }
      System.out.println();
    }
  }
  
    public void printMapDetail(){
    System.out.println("Map Print");
    Node nodeTmp= new Node();
    for ( int row = 0; row < mapWidth; row++ ){
      for ( int col = 0; col < mapLength; col++ )
      {
        nodeTmp=mazeMap[row][col];
        nodeTmp.whoAmI();
      }
    }
  }
  
  public Node[][]  returnMap(){
    return mazeMap;
  }
  
  private int totalMapItems(){
    return mazeMap[mapWidth-1][mapLength-1].getId();
  }
  
  private Node searchNodeById(int searchId){
    Node nodeTmp= new Node();
    Node nodeRet=null;
    for ( int row = 0; row < mapWidth; row++ ){
      for ( int col = 0; col < mapLength; col++)
      {
        nodeTmp=mazeMap[row][col];
        if(nodeTmp.getId()==searchId){
          nodeRet=nodeTmp;
        }
      }
    }
    return nodeRet;
  }
  
  private Node searchNodeByPos(int p_row, int p_col){
    return mazeMap[p_row][p_col]; //<>//
  }
  
}