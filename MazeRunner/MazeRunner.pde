int time;
int wait = 1000;
float x = 0;
float y = 100;
int sqrtx=80;
int sqrty=20;
int scaleSquare=30;
int maxlenghtx=21;
int maxlenghty=21;
Node previousNode = null;

Agent m_a;
int [][] initMaze= {
                    {0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0},
{0,1,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1},
{0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,0,0,1,0,0,0},
{0,1,0,1,0,1,1,1,1,1,0,1,0,1,1,1,0,1,1,1,1},
{0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0},
{0,1,0,1,0,1,0,1,1,1,1,1,0,1,0,1,0,1,0,1,1},
{0,1,0,1,0,1,0,0,0,0,0,1,0,1,0,1,0,0,0,0,0},
{0,1,0,1,1,1,0,1,0,1,0,1,1,1,0,1,1,1,1,1,0},
{0,0,0,1,0,0,0,1,0,1,0,0,0,0,0,0,0,1,0,1,0},
{1,1,0,1,0,1,0,1,0,1,0,1,1,1,0,1,0,1,0,1,1},
{0,0,0,0,0,1,0,1,0,1,0,0,0,1,0,1,0,1,0,0,0},
{1,1,0,1,1,1,0,1,0,1,1,1,1,1,0,1,0,1,0,1,0},
{0,0,0,0,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,1,0},
{1,1,1,1,1,1,1,1,1,1,0,1,1,1,0,1,0,1,0,1,1},
{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0},
{0,1,0,1,1,1,0,1,1,1,1,1,0,1,0,1,0,1,1,1,0},
{0,1,0,0,0,1,0,0,0,1,0,1,0,1,0,0,0,0,0,1,0},
{0,1,0,1,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0},
{0,1,0,0,0,0,0,1,0,0,0,1,0,1,0,1,0,1,0,0,0},
{0,1,1,1,0,1,1,1,0,1,1,1,0,1,0,1,0,1,0,1,0},
{0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,1,0,1,0}
};
PVector source;
PVector target;
Maze figureMaze;
Stack<Step> route;
void setup() {
  time = millis();//store the current time
  size(630,630);
  figureMaze=new Maze();
  figureMaze.mapSetup(maxlenghtx,maxlenghty,initMaze);
  figureMaze.printMap(scaleSquare);
  generateTarget();
  generateSource();
  IStrategySearch search= new MazeRunnerSearch();
  route=search.Search(figureMaze, source, target);
  System.out.println("Length " +route.size());
  m_a = new Agent(75,75);
  route = reverseStack(route);
}

private Stack<Step> reverseStack(Stack<Step> sourceStack)
{
    Stack<Step> target = new Stack<Step>();
    while(!sourceStack.empty())
    {
      target.push(sourceStack.pop());
    }
    return target;
}
private void printRoute(){ 
   while (!route.empty()){
     Node tmp=route.pop().Node;
     fill(0,0,0);
     tmp.whoAmI();
     fill(120,120,120);
     ellipse(tmp.getColVal()*30 +15,tmp.getRowVal()*30+15,10,10);
     delay(100);
     System.out.println(" -----------------------------------");
    //m_a.location.x = nextMove.Node.X;
    //m_a.location.y = nextMove.Node.Y;
    //m_a.AgentDirection = nextMove.Direction;
    //m_a.display();
 }
}


private void generateTarget(){
  fill(255,0,0);
  target=generatePosition();
    System.out.println("Target Row:" + target.x +" Col:"+target.y);
  rect(target.y*30, target.x*30,scaleSquare,scaleSquare);
}

private void generateSource(){
  fill(0,255,255);
   source=generatePosition();
  System.out.println("Source Row:" + source.x +" Col:"+source.y);
  rect(source.y*30 ,source.x*30,scaleSquare,scaleSquare);
}

private PVector generatePosition(){
   PVector vector = new PVector();
   vector.x=(int)random(20);
   vector.y=(int)random(20);
   while (figureMaze.searchNodeByPos((int)vector.x,(int)vector.y).getItemType()==1){
     vector.x=(int)random(20);
     vector.y=(int)random(20);
   }  
     vector.x=vector.x;
     vector.y=vector.y;
   return vector;
}

void draw() {
  //noStroke(); 
  //background(0);
  fill(0,0,0);
  if (!route.empty()){
      Step step=route.pop();
      Node tmp=step.Node;  
      //tmp.whoAmI();
      //ellipse(tmp.getColVal()*30 +15,tmp.getRowVal()*30+15,10,10);
      m_a.location.y = tmp.getRowVal()*30+15;
      m_a.location.x = tmp.getColVal()*30 +15;
      if(previousNode == null)
      {
        step.Direction = Direction.LEFT;
      }
      else
      {
        if(previousNode.getRowVal() > tmp.getRowVal())
        {
          step.Direction = Direction.UP;
        }
        else if(previousNode.getRowVal() < tmp.getRowVal())
        {
          step.Direction = Direction.DOWN;
        }
        else if(previousNode.getColVal() > tmp.getColVal())
        {
          step.Direction = Direction.LEFT;
        }
        else if(previousNode.getColVal() < tmp.getColVal())
        {
          step.Direction = Direction.RIGHT;
        }
      }
      previousNode = step.Node;
      m_a.AgentDirection = step.Direction;
      m_a.display();
      System.out.println(" -----------------------------------");
   }
}
 

 