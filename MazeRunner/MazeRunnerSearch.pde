public enum Direction {
    UP,DOWN, LEFT, RIGHT
}

public class Step
{
  public Node Node;
  public Direction Direction;
}

public class MazeRunnerSearch implements IStrategySearch{
  MazeRunnerSearch(){
  }
  
  public Stack<Step> Search(Maze context,PVector source, PVector target){
    Stack<Step> route = new Stack<Step>();
    boolean continuesearch=true;
    boolean backtracking=false;
    Node tmpNode=context.searchNodeByPos((int)source.x, (int)source.y); //<>//
    tmpNode.setVisited();
    Step tmpStep = new Step();
    tmpStep.Node = tmpNode;
    tmpStep.Direction=Direction.RIGHT;
    route.push(tmpStep);
    Node routeNode=null;
    Step nextStep = null;
    while ((continuesearch) && (isNotDestination(tmpNode,target))){
      nextStep=getOptimal( context, tmpNode,  target);
      routeNode = nextStep.Node;
      if (routeNode != null){
        //System.out.println("Push ");
        if (backtracking){
          route.push(tmpStep);
          backtracking=false;
        }
        route.push(nextStep);
        context.searchNodeByPos(routeNode.getRowVal(), routeNode.getColVal()).setVisited();  
        tmpNode=routeNode;
      }
      else{
        if(route.empty()){
          continuesearch=false;
        }
        else{
          //System.out.println("Pop ");
          tmpStep=route.pop();
          tmpNode=tmpStep.Node;
          backtracking=true;
          tmpNode.whoAmI();
        }
      }
    }   
    return route;
  }
  
  private boolean isNotDestination(Node finalNode,PVector target){
    if((finalNode.getRowVal()==(int)target.x) && (finalNode.getColVal()==(int)target.y)){
      return false;
    }
    else{
      return true;
    }
  }
  
  private Node getBestNode(Node candidateNode,Node bestNode,PVector target){
    if (bestNode==null){
      return candidateNode;
    }
    else if (manhattanDistance(candidateNode, target)< manhattanDistance(bestNode, target)){
       return candidateNode;
    }
    else{
      return bestNode;
    }  
  }
  
 private Step getOptimal(Maze context,Node source, PVector target){
    Node candidateNode=null;
    Node bestNode = null;
    Step nextStep = new Step();
    Direction direction = Direction.RIGHT;
    
    if((source.getRowVal()-1)>= 0){ //MOVE UP
      candidateNode=context.searchNodeByPos((source.getRowVal()-1),source.getColVal());
      if ((candidateNode.getVisited() ==false) & ((candidateNode.getItemType())==0)){ 
          bestNode=getBestNode(candidateNode,bestNode, target);
          direction = Direction.UP;
      }
    } 
    if((source.getColVal())-1>= 0){
      candidateNode=context.searchNodeByPos(source.getRowVal(),source.getColVal()-1);
      if ((candidateNode.getVisited() ==false)  & ((candidateNode.getItemType())==0)){
          bestNode=getBestNode(candidateNode,bestNode, target);
          direction = Direction.LEFT;
      }
    }     
    if((source.getRowVal()+1)< context.getMapWidth()){
      candidateNode=context.searchNodeByPos(source.getRowVal()+1,source.getColVal());
      if ((candidateNode.getVisited() ==false) & ((candidateNode.getItemType())==0)){
          bestNode=getBestNode(candidateNode,bestNode, target);
          direction = Direction.DOWN;
      }
    }   
    if((source.getColVal()+1)< context.getMapLength()){
      candidateNode=context.searchNodeByPos(source.getRowVal(),source.getColVal()+1);
      if ((candidateNode.getVisited() ==false) & ((candidateNode.getItemType())==0)){
          bestNode=getBestNode(candidateNode,bestNode, target);
          direction = Direction.RIGHT;
        }
    }
    nextStep.Node = bestNode;
    nextStep.Direction = direction;
    
    return nextStep; 
  }
  
  private int manhattanDistance(Node source,PVector target){
    return Math.abs((int)target.x-source.getRowVal()) + Math.abs((int)target.y-source.getColVal());  
  }
}