/*
Estudiantes:
  Alexander Garcia
  Erick Carvajal
  Daniel Madriz
*/

public class Node{
  private int row,col,nodeId;
  private int itemType;
  private boolean visited; 
  
  Node(int rowPos, int colPos,int idNode,int itemValue){
     row=rowPos;
     col=colPos;
     nodeId=idNode;
     itemType=itemValue;
     visited=false;
  }
  
  Node(){
  }
  
  public void whoAmI(){
    System.out.println("The Node ID is:" + nodeId);
    System.out.println("The Row Value is:" + row);
    System.out.println("The Col Value is:" + col);
    System.out.println("The Item Type Value is:" + itemType);
  }
  
  public int getId(){
    return nodeId;
  }

  public int getRowVal(){
    return row;
  }
  
  public int getColVal(){
    return col;
  }
  
  public boolean getVisited(){
    return visited;
  }
  
  public void setFigure(int figType){
    itemType=figType;
  }
  
  public void setVisited(){
    visited=true;
  }
  
  public int getItemType(){
    return itemType;
  }
}
