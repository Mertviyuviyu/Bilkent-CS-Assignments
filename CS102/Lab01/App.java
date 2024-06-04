import java.util.ArrayList;
import java.util.Random;
import java.util.Scanner;

public class App {
    public static void main(String[] args) {
        int width;
        int length;
        int players;
        boolean gameFinished = false;
        ArrayList<Player> tempPlayers = new ArrayList<Player>();
        Scanner sc = new Scanner(System.in);
        System.out.println("Welcome to Board Game");
        System.out.print("Enter board width: ");
        width = sc.nextInt();
        System.out.print("Enter board length: ");
        length = sc.nextInt();
        Board b1 = new Board(width, length);
        int lastCell = (2 * (width + length - 2)) - 1;
        System.out.print("How many players (2-4): ");
        players = sc.nextInt();
        sc.nextLine();
        System.out.print("Please enter a character (symbol) for each player.");
        System.out.println();
        for (int i = 0; i < players; i++) {
            char temp;
            System.out.printf("For player %d: ", i);
            temp = sc.nextLine().charAt(0);
            Player p = new Player(temp, b1);
            tempPlayers.add(p);
        }
        Player[] playersArray = tempPlayers.toArray(new Player[tempPlayers.size()]);
        Random rr = new Random();
        System.out.println("Players are rolling dice.");
        for (int i = 0; i < players; i++) {
            int roll = rr.nextInt(1, 7);
            System.out.printf("%c:%d  ", playersArray[i].getSymbol(), roll);
            playersArray[i].setRoll(roll);
        }
        int n = playersArray.length;
        boolean swap;
        do {
            swap = false;
            for (int i = 1; i < n; i++) {
                if (playersArray[i - 1].getRoll() < playersArray[i].getRoll()) {
                    Player temp = playersArray[i - 1];
                    playersArray[i - 1] = playersArray[i];
                    playersArray[i] = temp;
                    swap = true;
                }
            }
        } while (swap);

        for (int i = 0; i < playersArray.length; i++) {
            for (int k = i + 1; k < playersArray.length; k++) {
                if (playersArray[i].getRoll() == playersArray[k].getRoll()) {
                    System.out.printf("%n Tie break for %c and %c ", playersArray[i].getSymbol(), playersArray[k].getSymbol());
                }
            }
        }
        System.out.println();
        System.out.print("Playing order is: ");
        for (int i = 0; i < playersArray.length; i++) {
            System.out.print(playersArray[i].getSymbol() + " ");
        }
        System.out.println();

        b1.printBoard(playersArray);

        while (!gameFinished) {
            for (int i = 0; i < playersArray.length; i++) {
                int userMoveChoice;
                int moveRoll;
                moveRoll = rr.nextInt(1, 7);
                if (moveRoll > lastCell - playersArray[i].getCellNum()) {
                    moveRoll = lastCell - playersArray[i].getCellNum();
                }
                do {
                    System.out.printf("%nPlayer %c rolls %d, how many cells you move? (0,%d): ", playersArray[i].getSymbol(), moveRoll, moveRoll);
                    userMoveChoice = sc.nextInt();
                } while (userMoveChoice > moveRoll || userMoveChoice < 0);

                playersArray[i].moveCell(userMoveChoice);
                b1.printBoard(playersArray);
                if (playersArray[i].getCellNum() == lastCell) {
                    gameFinished = true;
                    System.out.printf("%nPlayer %c won, congrats!%n", playersArray[i].getSymbol());
                    break;
                }
            }
        }
        System.out.println("Player  Move    Trap");
        for (int i = 0; i < playersArray.length; i++) {
            System.out.printf("%c         %d        %d%n", playersArray[i].getSymbol(), playersArray[i].getMoveCount(), playersArray[i].getTrapCount());
        }
        sc.close();


        /*Board test = new Board(3, 4);
        Player p1 = new Player('A',test);
        Player p2 = new Player('B',test);
        Player p3 = new Player('C',test);
        Player p4 = new Player('D',test);
        Player[] players = {p1,p2,p3,p4};
        p1.moveCell(1);
        p2.moveCell(2);
        p3.moveCell(3);
        p4.moveCell(4);
        test.printBoard(players);
        */
    }

}
