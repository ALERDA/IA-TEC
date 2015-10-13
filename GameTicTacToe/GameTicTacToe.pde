import java.util.Random;
Board b = new Board();
int Scale=100;
int  XVALUE=1;
int  OVALUE=2;


void setup(){
  Random rand = new Random();
  strokeWeight(4);  // line Thicker
  size(300,300);
  int randomnumber= rand.nextInt((1 - 0) + 1) + 0;
  b.printBoard();
  if (1==randomnumber){
    b.minimax(0, 1);
    b.placeAMove(b.computersMove, 1);
    drawX(b.computersMove.x,b.computersMove.y);
    b.printBoard();
  }

}

void draw()
{
  drawBoard();
}

void mouseClicked() {
  int x = getX();
  int y = getY();
    if (b.returCellValue(x,y)==0){
        drawO(x,y);
        Point point = new Point(x, y);
        b.placeAMove(point, 2); 
        b.printBoard();
        b.minimax(0, 1);            
        b.placeAMove(b.computersMove, 1);
        drawX(b.computersMove.x,b.computersMove.y);
        b.printBoard();
    }
    else{
      System.out.println("Cell is not available for selection");
    }
    if (b.hasWon(XVALUE)) 
      System.out.println("Unfortunately, you lost!");
    else if (b.hasWon(OVALUE)) 
      System.out.println("You win!"); //Can't happen
    else if(b.getEmptyCells().isEmpty())
      System.out.println("It's a draw!");
}

int getX()
{
   int x=mouseX/Scale;
   return x;

}

int getY()
{
   int y=mouseY/Scale;
   return y;
}

void drawBoard()
{
  line(Scale,1,Scale,Scale*3); //vertical line
  line(Scale*2,1,Scale*2,Scale*3);  //vertical line  
  line(1,Scale,Scale*3,Scale);  //horizontal line
  line(1,Scale*2,Scale*3,Scale*2);  //horizontal line
}

void drawO(int x,int y)
{
  strokeWeight(4);  // line Thicker
  ellipse(x*Scale+Scale/2, y*Scale+Scale/2, Scale-20, Scale-20);
}

void drawX(int x,int y)
{
  line(x*Scale+10, y*Scale+10, x*Scale+Scale-10, y*Scale+Scale-10);
  line(Scale+x*Scale-10, y*Scale+10, x*Scale+10, y*Scale+Scale-10);
}