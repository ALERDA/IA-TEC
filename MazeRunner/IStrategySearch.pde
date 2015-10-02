import java.util.Stack;
public interface IStrategySearch{
  public Stack<Step> Search(Maze context,PVector source, PVector target);
}