/*
Estudiantes:
  Alexander Garcia
  Erick Carvajal
  Daniel Madriz
*/

public class Agent {

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
      delay(100);
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
