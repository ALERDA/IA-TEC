String lastInput = new String();
String currentInput = new String();
PFont myFont; 
String[][] matrix = new String[8][4];

String probabilidadDe ="", dado = "";

void setup()
{
  size(700,500);
  
  table = loadTable("table.csv", "header");
  
  //smooth();
  //myFont = createFont("FFScala", 32);
  //textFont(myFont);
  //textAlign(CENTER);



    matrix[0][0] = "Summer";
    matrix[0][1] = "Hot";
    matrix[0][2] = "Sun";
    matrix[0][3] = "0.3";
    
    matrix[1][0] = "Summer";
    matrix[1][1] = "Hot";
    matrix[1][2] = "Rain";
    matrix[1][3] = "0.05";
    
    matrix[2][0] = "Summer";
    matrix[2][1] = "Cold";
    matrix[2][2] = "Sun";
    matrix[2][3] = "0.10";
    
    matrix[3][0] = "Summer";
    matrix[3][1] = "Cold";
    matrix[3][2] = "Rain";
    matrix[3][3] = "0.05";
    
    matrix[4][0] = "Winter";
    matrix[4][1] = "Hot";
    matrix[4][2] = "Sun";
    matrix[4][3] = "0.10";
    
    matrix[5][0] = "Winter";
    matrix[5][1] = "Hot";
    matrix[5][2] = "Rain";
    matrix[5][3] = "0.05";
    
    matrix[6][0] = "Winter";
    matrix[6][1] = "Cold";
    matrix[6][2] = "Sun";
    matrix[6][3] = "0.15";
    
    matrix[7][0] = "Winter";
    matrix[7][1] = "Cold";
    matrix[7][2] = "Rain";
    matrix[7][3] = "0.20";

}

void draw()
{

  //println(table.getRowCount() + " total rows in table"); 
  int j=0;
  textSize(20);

  for (TableRow row : table.rows()) {
    for (int i = 0; i < 4; i++) {
      fill(0,100,100,128);
      rect(i*130+20, j*20+2, 130, 20);
      String value = row.getString(i);
      fill(255,255,255);
      text(value,i*130+30,j*20+20);
    }
    j++;

   }
   
  text(lastInput, width/2, height/2);
  text(currentInput, width/2, height*.75);
  
}


void keyPressed()
{
   if(key == ENTER)
   {
       System.out.println("currentInput : " + currentInput);
       processUserInput2(currentInput);
       currentInput = "";
   }
   else if(key == BACKSPACE && currentInput.length() > 0)
   {
       currentInput = currentInput.substring(0, currentInput.length() - 2);
   }
   else if(key == CODED) {
       //currentInput = currentInput + key;
   }
   else
   {
       currentInput = currentInput + key;
   }
}

void keyPressed2()
{
 if(key == ENTER)
 {
     lastInput = currentInput = currentInput + key;
     currentInput = "";
     if(probabilidadDe.length() > 0)
     {
         dado = lastInput;
         processUserInput(probabilidadDe, dado);
         dado = probabilidadDe = "";
     }
     else
     {
         probabilidadDe = lastInput;
     }
     
 }
 else if(key == BACKSPACE && currentInput.length() > 0)
 {
     currentInput = currentInput.substring(0, currentInput.length() - 1);
 }
 else if(key == CODED) {
     // ignore...
 }
 else
 {
     currentInput = currentInput + key;
 }
}


void processUserInput2(String enteredValue)
{
  String[] values= enteredValue.split(",");
  for(int i = 0; i < values.length; i++)
  {
     values[i] = values[i].trim();
  }
  
  calculateProbability2(values);
  
}

void calculateProbability2(String[] values)
{
  float probability = 0;
  String currentValue = "";
 
  tableForWork = loadTable("table.csv", "header");
  
  for(int currentColumnIndex = 0; currentColumnIndex < values.length; currentColumnIndex++)
  {
    currentValue = values[currentColumnIndex];
    ArrayList<Integer> rowsToRemove = new ArrayList<Integer>();
    
    for(int rowIndex = 0; rowIndex < tableForWork.getRowCount(); rowIndex++)
    {
       System.out.println("1: " + currentValue);
       if(currentValue.length() !=0 && !tableForWork.getString(rowIndex, currentColumnIndex).equals(currentValue))
       {
         rowsToRemove.add(rowIndex);
       }
    }
    
    for(int rows = rowsToRemove.size() - 1; rows >= 0; rows--)
    {
      tableForWork.removeRow(rowsToRemove.get(rows));
    }
  }
  
  float totalProbability = 0;
  for(int rowIndex = 0; rowIndex < tableForWork.getRowCount(); rowIndex++)
  {
    System.out.println("La probabilidad en row " + rowIndex + " es: " + tableForWork.getString(rowIndex, 3) + ".");
    totalProbability += Float.parseFloat(tableForWork.getString(rowIndex, 3).trim());
  } 
  System.out.println("*********************************************");
  System.out.println("La probabilidad total es: " + totalProbability);
}


void processUserInput(String probabilidadDe, String dado)
{
    int columnaProbabilidadDe, columnaDado;
    String valorProbabilidadDe, valorDado;
    
    columnaProbabilidadDe = Integer.parseInt(probabilidadDe.split(",")[0].trim());
    columnaDado = Integer.parseInt(dado.split(",")[0].trim());
    valorProbabilidadDe = probabilidadDe.split(",")[1].trim();
    valorDado = dado.split(",")[1].trim();
    
    Float result = calculateProbability(columnaProbabilidadDe, columnaDado, valorProbabilidadDe, valorDado);
    
    System.out.println("La probabilidad es: " +  result);
}

Float calculateProbability(int columnaProbabilidadDe, int columnaDado, String valorProbabilidadDe, String valorDado)
{
     System.out.println(columnaProbabilidadDe + " , " + columnaDado + " , " +  valorProbabilidadDe + " , " +  valorDado);
     float dado = 0;
     float probabilidadDe = 0;
     float probabilidadCondicional = 0;
     
     for(int i = 0; i < 8; i++)
     {
       System.out.println("matrix[i][columnaDado] == valorDado: " + matrix[i][columnaDado] + " : "+ valorDado);
       if(matrix[i][columnaDado].equals(valorDado))
       {
          dado += Float.parseFloat( matrix[i][3]);
          System.out.println("Match dado: " + dado);
          
          if(matrix[i][columnaProbabilidadDe].equals(valorProbabilidadDe))
          {
              probabilidadDe += Float.parseFloat( matrix[i][3]);
          }
       }
     }
     
     if(dado > 0)
         probabilidadCondicional = (probabilidadDe * dado) / dado;
         
     return probabilidadCondicional;
}




// The following short CSV file called "table.csv" is parsed 
// in the code below. It must be in the project's "data" folder.


Table table, tableForWork;