import java.util.Random;

public class Board {
    private int width;
    private int length;
    private final int allCells;
    public final int TRAP_COUNT = 3;
    public int[] trapCells = new int[TRAP_COUNT];
    public boolean[] deactivatedTraps = new boolean[TRAP_COUNT];
    private int[] corners;

    public Board(int width, int length) {
        this.width = width;
        this.length = length;
        allCells = 2 * (width + length - 2);

        corners = new int[4];
        corners[0] = 0;
        corners[1] = width - 1;
        corners[2] = width + length - 2;
        corners[3] = 2 * width + length - 3;

        Random rr = new Random();
        for (int i = 0; i < TRAP_COUNT; i++) {
            int trap;
            do {
                trap = rr.nextInt(1,allCells);
            } while (trap == corners[1] || trap == corners[2] || trap == corners[3] );
            trapCells[i] = trap;
        }
    }

    public void printBoard(Player[] players) {

        for (int i = 0; i < width * 4; i++) {
            System.out.print("#");
        }
        System.out.println();
        // Top
        for (int i = 0; i < width; i++) {
            char temp1 = ' ';
            char temp2 = ' ';
            if (players.length >= 1 && players[0].getCellNum() == i) {
                temp1 = players[0].getSymbol();
            }
            if (players.length >= 2 && players[1].getCellNum() == i) {
                temp2 = players[1].getSymbol();
            }
            System.out.printf("#%c%c#", temp1, temp2);
        }
        System.out.println();
        for (int i = 0; i < width; i++) {
            char temp3 = ' ';
            char temp4 = ' ';
            if (players.length >= 3 && players[2].getCellNum() == i) {
                temp3 = players[2].getSymbol();
            }
            if (players.length >= 4 && players[3].getCellNum() == i) {
                temp4 = players[3].getSymbol();
            }
            System.out.printf("#%c%c#", temp3, temp4);
        }
        System.out.println();
        for (int i = 0; i < width * 4; i++) {
            System.out.print("#");
        }
        System.out.println();
        System.out.print("####");
        for (int k = 0; k < (width - 2); k++) {
            System.out.print("    ");
        }
        System.out.print("####");
        System.out.println();
        //LEFT SIDE FOR P1 P2
        for (int i = 0; i < length - 2; i++) {
            char temp1 = ' ';
            char temp2 = ' ';

            if (players.length >= 1 && players[0].getCellNum() == allCells - i - 1) {
                temp1 = players[0].getSymbol();
            }
            if (players.length >= 2 && players[1].getCellNum() == allCells - i - 1) {
                temp2 = players[1].getSymbol();
            }
            System.out.printf("#%c%c#", temp1, temp2);
            for (int k = 0; k < (width - 2); k++) {
                System.out.print("    ");
            }
            //RIGHT SIDE FOR P1 P2
            temp1 = ' ';
            temp2 = ' ';
            if (players.length >= 1 && players[0].getCellNum() == width + i) {
                temp1 = players[0].getSymbol();
            }
            if (players.length >= 2 && players[1].getCellNum() == width + i) {
                temp2 = players[1].getSymbol();
            }
            System.out.printf("#%c%c#", temp1, temp2);
            System.out.println();
            char temp3 = ' ';
            char temp4 = ' ';
            //left side for p3 p4
            if (players.length >= 3 && players[2].getCellNum() == allCells - i - 1) {
                temp3 = players[2].getSymbol();
            }
            if (players.length >= 4 && players[3].getCellNum() == allCells - i - 1) {
                temp4 = players[3].getSymbol();
            }
            System.out.printf("#%c%c#", temp3, temp4);
            for (int k = 0; k < (width - 2); k++) {
                System.out.print("    ");
            }
            temp3 = ' ';
            temp4 = ' ';
            //right side for p3 p4
            if (players.length >= 3 && players[2].getCellNum() == width + i) {
                temp3 = players[2].getSymbol();
            }
            if (players.length >= 4 && players[3].getCellNum() == width + i) {
                temp4 = players[3].getSymbol();
            }
            System.out.printf("#%c%c#", temp3, temp4);
            System.out.println();
            System.out.print("####");
            System.out.print("    ".repeat(width - 2));
            System.out.print("####");
            System.out.println();
        }
        for (int i = 0; i < width * 4; i++) {
            System.out.print("#");
        }
        //bottom for p1 p2
        System.out.println();
        for (int i = 0; i < width; i++) {
            char temp1 = ' ';
            char temp2 = ' ';
            if (players.length >= 1 && players[0].getCellNum() == allCells - i - (length - 1)) {
                temp1 = players[0].getSymbol();
            }
            if (players.length >= 2 && players[1].getCellNum() == allCells - i - (length - 1)) {
                temp2 = players[1].getSymbol();
            }
            System.out.printf("#%c%c#", temp1, temp2);
        }
        System.out.println();
        for (int i = 0; i < width; i++) {
            char temp3 = ' ';
            char temp4 = ' ';
            //bottom for p3 p4
            if (players.length >= 3 && players[2].getCellNum() == allCells - i - (length - 1)) {
                temp3 = players[2].getSymbol();
            }
            if (players.length >= 4 && players[3].getCellNum() == allCells - i - (length - 1)) {
                temp4 = players[3].getSymbol();
            }
            System.out.printf("#%c%c#", temp3, temp4);
        }
        System.out.println();
        for (int i = 0; i < width * 4; i++) {
            System.out.print("#");
        }
    }

    public int[] getCorners() {
        return corners;
    }
}
