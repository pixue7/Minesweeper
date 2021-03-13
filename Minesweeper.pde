import de.bezier.guido.*;
public final static int numRows = 20;
public final static int numCols = 20;
private MSButton[][] buttons; 
private ArrayList <MSButton> mines = new ArrayList <MSButton>();
void setup(){
    size(400, 400);
    textAlign(CENTER,CENTER);
    Interactive.make(this);
    buttons = new MSButton[numRows][numCols];
    for (int j = 0; j < numRows; j++){
    for (int i = 0; i < numCols; i++){
    setMines();
    }
    }
}
public void setMines(){
    for(int n = 0; n < 40; n++){
    int j = (int)(Math.random()*numRows);
    int i = (int)(Math.random()*numCols);
    if(!mines.contains(buttons[j][i])){
    mines.add(buttons[j][i]); 
    }
  }
}                   

public boolean isWon(){
  return false;
}
public void displayLosingMessage(){
  
}
public void displayWinningMessage(){
  
}
public class MSButton{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
public MSButton(int row, int col){
    width = 400/numCols;
    height = 400/numRows;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this );
}
public boolean isMarked(){
    return flagged;
}
public boolean isClicked(){
    return clicked;
}
public void mousePressed(){
    clicked = true;
    if(mouseButton == RIGHT){
      flagged = !flagged;
    if(!flagged){
    clicked = false;
    }
    }
    else if(mines.contains(this)){
      displayLosingMessage();
    }
      else if(countMines(myRow, myCol) > 0){
      setLabel("" + countMines());
      }
     else{
     for(int i = -1; i <=1; i++){
     if(isValid(myRow-1, myCol+i)){
     mines[myRow-1][myCol+i].mousePressed();
     }
     }
     for(int i = -1; i <=1; i++){
     if(isValid(myRow+1, myCol+i)){
     mines[myRow+1][myCol+i].mousePressed();
     }
     if(isValid(myRow, myCol+1)){
     mines[myRow][myCol+1].mousePressed();
     }
     }
     if(isValid(myRow, myCol-1)){
     mines[myRow][myCol-1].mousePressed();
     }
     }
}
public void draw(){
  background(0);
  if(isWon()){
  displayWinningMessage();
  if(flagged){
  fill(0);
  }
  }
  else if(clicked && mines.contains(this)){
  fill(255,0,0);
  }
  else if(clicked){
  fill(200);
  }
  else{
  fill(100);
  rect(x, y, width, height);
  fill(0);
  text(myLabel, x+width/2, y+height/2);
  }
  }
}
public void setLabel(String newLabel){
  myLabel = newLabel;
}
public boolean isValid(int r, int c){
   if (r < 0 || r >= numRows){
   return false;
   }
   else if (c < 0 || c >= numCols){
   return false;
   }
   return true;
}
public int countMines(int row, int col){
   int numMines = 0;
    for(int i = -1; i <=1; i++){
    if(isValid(row-1, col+i)){
    if(mines.contains(buttons[row-1][col+i])){
    numMines++;
    }
    }
    }
    for(int i = -1; i <=1; i++){
    if(isValid(row+1, col+i)){
    if(mines.contains(buttons[row+1][col+i])){
    numMines++;
    }
    }
    }
    if(isValid(row, col+1)){
    if(mines.contains(buttons[row][col+1])){
    numMines++;
    }
    }
    if (isValid(row, col-1)){
    if (mines.contains(buttons[row][col-1])){
    numMines++;
    }
    }
    return numMines;
  }
