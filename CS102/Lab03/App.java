package Lab03;

import java.util.Random;
import java.util.Scanner;

public class App {
    public static void main(String[] args) {
        Arena a1 = new Arena();
        Scanner sc = new Scanner(System.in);
        int turnCounter = 1;
        Random rr = new Random();

        while(!a1.gameEnded){
            System.out.println();
            System.out.println("Turn: " + turnCounter );
            System.out.println("Computer Units:");
            a1.printComputerUnits();
            System.out.println();
            System.out.println("Player's Units:");
            a1.printPlayerUnits();
            System.out.print("Which unit to choose: ");
            int userChoice;
            int computerChoice;
            boolean checker;
            do{
                checker = false;
                System.out.print("Which unit to choose: ");
                userChoice = sc.nextInt();
                if(userChoice > 7 || userChoice < 1){
                    System.out.println("Invalid input please enter between 1-7");
                    checker = true;
                }
                if(userChoice <=7 && userChoice >= 1){
                    if(a1.playerUnits.get(userChoice-1).isDead){
                        System.out.println("You choosed a dead unit.");
                        checker = true;
                    }
                }
            }while(checker);
            do{
                computerChoice = rr.nextInt(1,8);
            }while(a1.computerUnits.get(computerChoice-1).isDead);
            System.out.println("You choose: " + a1.playerUnits.get(userChoice-1).getInfo());
            System.out.println("Computer chooses: " + a1.computerUnits.get(computerChoice-1).getInfo());
            System.out.println();

            a1.battle(userChoice-1, computerChoice-1);

            System.out.println("Battle ended after phase: " + a1.phaseBattleEnded);
            turnCounter++;

        }
        if(a1.playerWon){
            System.out.println("The player wins the game.");
        }
        else{
            System.out.println("Computer wins the game.");
        }
        sc.close();
    }
}
