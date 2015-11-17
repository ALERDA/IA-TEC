/*
Estudiantes:
  Alexander Garcia
  Erick Carvajal
  Daniel Madriz
*/


import java.util.Stack;
public interface IStrategySearch{
  public Stack<Step> Search(Maze context,PVector source, PVector target);
}
