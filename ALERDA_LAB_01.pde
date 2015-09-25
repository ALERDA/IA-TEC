Canvas canvas;
Node currentNode;  
Node targetNode;
Searcher searcher;

public enum Direction {
    UP,DOWN, LEFT, RIGHT
}

PVector target;

Agent m_a;

class NextMove
{
  public Node Node;
  public Direction Direction;
}

class Searcher
{
  public boolean Success = false;
  
  Searcher()
  {
  }
    
  public NextMove moveNext(Canvas canvas, Node currentNode, Node targetNode)
  {
    NextMove nextMove=new NextMove();
    
      if(currentNode.X == targetNode.X && currentNode.Y == targetNode.Y)
      {
        Success = true;
        return nextMove;
      }
      else
      {
        currentNode.Visited = true;
        (canvas.Graph[currentNode.X][currentNode.Y]).Visited=true;
        
        if(currentNode.X - 1 >= 0 && !(canvas.Graph[currentNode.X-1][currentNode.Y]).Visited) //Move left
        {
          nextMove.Direction = Direction.LEFT;
           currentNode =  canvas.Graph[currentNode.X-1][currentNode.Y];
        }
        else if(currentNode.X + 1 < canvas.Width && ((canvas.Graph[currentNode.X+1][currentNode.Y]).Visited == false)) //Move right
        {
          nextMove.Direction = Direction.RIGHT;
           currentNode =  canvas.Graph[currentNode.X+1][currentNode.Y];
        }
        else if(currentNode.Y - 1 >= 0 && !(canvas.Graph[currentNode.X][currentNode.Y-1]).Visited) //Move up
        {
           nextMove.Direction = Direction.UP;
           currentNode =  canvas.Graph[currentNode.X][currentNode.Y-1];
        }
        else if(currentNode.Y + 1 <= canvas.Height && !(canvas.Graph[currentNode.X][currentNode.Y+1]).Visited) //Move down
        {
          nextMove.Direction = Direction.DOWN;
           currentNode =  canvas.Graph[currentNode.X][currentNode.Y+1];
        }        
      }
     // System.out.println("Current node 5: " + currentNode.X + " , " + currentNode.Y);
      nextMove.Node = currentNode;
      return nextMove;
  }
}

class Canvas
{
  Canvas(int width, int height)
  {
    this.Width = width;
    this.Height = height;
    this.Graph = new Node[this.Width][this.Height];
    for(int x = 0; x < width; x++)
    {
      for(int y = 0; y < height; y++)
      {
        this.Graph[x][y] = new Node(x, y);
      }
    }
  }
  
  public int Width;
  public int Height;
  public Node[][] Graph;
  
}
class Node
{
  Node (int x, int y)
  {
    this.X = x;
    this.Y = y;
    Visited = false;
  }
  
  public int X;
  public int Y;
  public boolean  Visited;
}

void setup() {
  m_a = new Agent(75,75);
  int canvasWidth = 300, canvasHeight = 300;
  size(300, 300);
  
  targetNode = new Node ((int)random(width/5)*5,(int)random(height/5)*5);
 
  searcher = new Searcher();
  canvas = new Canvas(canvasWidth, canvasHeight);
  currentNode = new Node(0, 0);
  //targetNode = new Node(20, 20);
}


class Agent {

  public PVector agentColor;
  int gScareFactor;
  
  Direction AgentDirection;

  
  public PVector location;
  PVector velocity;
  PVector acceleration;
  
  // Additional variable for size
  float r;

  float maxspeed;

  Agent(float x, float y) { 
  
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    location = new PVector(x,y);

    agentColor = new PVector(255,0,0);

    maxspeed = 1;

  }

  void display() {
      fill(agentColor.x,agentColor.y,agentColor.z);
      //System.out.println("Location: " + location.x + " , " + location.y);
      //System.out.println(AgentDirection);

      Direction var = AgentDirection;
       if (var==Direction.UP)
       {
                triangle(location.x,location.y,location.x-5,location.y+10,location.x+5,location.y+10);       
       }
       else if (var==Direction.DOWN)
       {
                triangle(location.x,location.y,location.x-5,location.y-10,location.x+5,location.y-10);
       }
       else if (var==Direction.LEFT)
       {
               triangle(location.x,location.y,location.x+10,location.y-5,location.x+10,location.y+5);
        }
       else if (var==Direction.RIGHT)
       {
                triangle(location.x,location.y,location.x-10,location.y-5,location.x-10,location.y+5);
       }
  }
}



void draw() {
  noStroke(); 
  background(0);
  
  fill(175);

  ellipse(targetNode.X,targetNode.Y, 5,5);
    
  if(!searcher.Success)
  {
    NextMove nextMove = searcher.moveNext(canvas, currentNode, targetNode);
    currentNode = nextMove.Node;
  
    m_a.location.x = nextMove.Node.X;
    m_a.location.y = nextMove.Node.Y;
    m_a.AgentDirection = nextMove.Direction;
    m_a.display();
  }
  else
  {
    System.out.println("Success");
  }
}
