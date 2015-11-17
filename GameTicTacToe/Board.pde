/*
Estudiantes:
  Alexander Garcia
  Erick Carvajal
  Daniel Madriz
*/


import java.util.*;
import java.util.ArrayList;


class Board {
  Point computersMove;
  List<Point> emptyCells;
  int[][] board = new int[3][3];
  
  public List<Point> getEmptyCells() {
    emptyCells = new ArrayList();
    for (int i = 0; i < 3; ++i) {
      for (int j = 0; j < 3; ++j) {
        if (board[i][j] == 0) {
          emptyCells.add(new Point(i, j));
        }
      }
    }
    return emptyCells;
  }
   
  public boolean hasWon(int value) {
    //Evaluate Diagonal
    if ((board[0][0] == board[1][1] && board[0][0] == board[2][2] && board[0][0] == value) || (board[0][2] == board[1][1] && board[0][2] == board[2][0] && board[0][2] == value)) {
      return true;
    }
    //Evaluate Rows and Columns
    for (int i = 0; i < 3; ++i) {
      if (((board[i][0] == board[i][1] && board[i][0] == board[i][2] && board[i][0] == value)
      || (board[0][i] == board[1][i] && board[0][i] == board[2][i] && board[0][i] == value))) {
        return true;
      }
    }
    return false;
  }
   
  public void placeAMove(Point point, int player) {
    board[point.x][point.y] = player;
  } 
   
  public void printBoard() {
    System.out.println();
    for (int rows = 0; rows < 3; ++rows) {
      for (int cols = 0; cols < 3; ++cols) {
        System.out.print(board[rows][cols] + " ");
      }
      System.out.println();
    }
  } 
    
  public int returCellValue(int x, int y) {
    return board[x][y];
  }
  
  public int minimax(int depth, int turn) {
    if (hasWon(XVALUE)) return +1; 
    if (hasWon(OVALUE)) return -1;
    List<Point> pointsAvailable = getEmptyCells();
    if (pointsAvailable.isEmpty()) return 0; 
    
    int min = Integer.MAX_VALUE, max = Integer.MIN_VALUE;
    for (int i = 0; i < pointsAvailable.size(); ++i) { 
      Point point = pointsAvailable.get(i);
      if (turn == 1) {
        placeAMove(point, 1);
        int currentScore = minimax(depth + 1, 2);
        max = Math.max(currentScore, max);
        if(depth == 0)System.out.println("Score for position "+(i+1)+" = "+currentScore);
        if(currentScore >= 0){ if(depth == 0) computersMove = point;}
        if(currentScore == 1){board[point.x][point.y] = 0; break;} 
        if(i == pointsAvailable.size()-1 && max < 0){
           if(depth == 0)computersMove = point;
         }
       }
       else if (turn == 2) {
         placeAMove(point, 2);
         int currentScore = minimax(depth + 1, 1);
         min = Math.min(currentScore, min);
       if(min == -1){board[point.x][point.y] = 0; break;}
     }
     board[point.x][point.y] = 0; //Reset this point
   }
   return turn == 1?max:min;
 }
 
 }