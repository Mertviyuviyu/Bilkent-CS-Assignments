public class Player {
    private char symbol;
    private int cellNum;
    private Board b1;  
    private int firstRoll;
    private int moveCount;
    private int trapCount;
    private final int[] corners;

    public Player(char symbol, Board b1){
        this.symbol = symbol;
        this.b1 = b1;
        cellNum = 0;
        firstRoll = 0;
        moveCount = 0;
        trapCount = 0;
        this.corners = b1.getCorners();
    }

    public void moveCell(int num){
        cellNum += num;
        moveCount++;
        boolean steppedIntoTrap = false;
        for (int i = 0; i < b1.TRAP_COUNT; i++)
            if (cellNum == b1.trapCells[i] && !b1.deactivatedTraps[i]) {
                steppedIntoTrap = true;
                b1.deactivatedTraps[i] = true;
            }
        if(steppedIntoTrap) {
            trapCount++;
            System.out.println("You moved into trap and moved back to closest corner!");
            if(cellNum >= corners[3]){
                cellNum = corners[3];
            }
            else if(cellNum >= corners[2] && cellNum < corners[3]){
                cellNum = corners[2];
            }
            else if(cellNum >= corners [1] && cellNum < corners[2]){
                cellNum = corners[1];
            }
            else{
                cellNum = corners[0];
            }
        }
    }

    public int getCellNum(){
        return cellNum;
    }
    public char getSymbol(){
        return symbol;
    }
    public int getRoll(){
        return firstRoll;
    }
    public void setRoll(int r){
        firstRoll = r;
    }
    public int getMoveCount(){
        return moveCount;
    }
    public int getTrapCount(){
        return trapCount;
    }



    
}