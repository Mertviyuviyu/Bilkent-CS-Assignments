package Lab03;

import java.util.ArrayList;
import java.util.Random;

public class Arena {
    public ArrayList<Unit> playerUnits;
    public ArrayList<Unit> computerUnits;
    public boolean gameEnded;
    public int phaseBattleEnded;
    public boolean playerWon;

    public Arena() {
        playerUnits = new ArrayList<>();
        computerUnits = new ArrayList<>();
        playerUnits.add(new Warrior());
        computerUnits.add(new Warrior());
        gameEnded = false;
        phaseBattleEnded = 0;
        Random rr = new Random();
        for (int i = 0; i < 6; i++) {
            int choice = rr.nextInt(7);
            if (choice == 0) {
                playerUnits.add(new Archer());
            } else if (choice == 1) {
                playerUnits.add(new Bard());
            } else if (choice == 2) {
                playerUnits.add(new Healer());
            } else if (choice == 3) {
                playerUnits.add(new Necromancer());
            } else if (choice == 4) {
                playerUnits.add(new Rogue());
            } else if (choice == 5) {
                playerUnits.add(new Warrior());
            } else if (choice == 6) {
                playerUnits.add(new Wizard());
            }
        }
        for (int i = 0; i < 6; i++) {
            int choice = rr.nextInt(7);
            if (choice == 0) {
                computerUnits.add(new Archer());
            } else if (choice == 1) {
                computerUnits.add(new Bard());
            } else if (choice == 2) {
                computerUnits.add(new Healer());
            } else if (choice == 3) {
                computerUnits.add(new Necromancer());
            } else if (choice == 4) {
                computerUnits.add(new Rogue());
            } else if (choice == 5) {
                computerUnits.add(new Warrior());
            } else if (choice == 6) {
                computerUnits.add(new Wizard());
            }
        }
    }

    public void battle(int playerIndex, int computerIndex) {
        Unit playerUnit = playerUnits.get(playerIndex);
        Unit computerUnit = computerUnits.get(computerIndex);
        phaseBattleEnded = 0;

        playerUnits.remove(playerIndex);
        computerUnits.remove(computerIndex);
        boolean[] playerStatusStart = new boolean[6];
        boolean[] computerStatusStart = new boolean[6];
        for (int i = 0; i < 6; i++) {
            playerStatusStart[i] = playerUnits.get(i).isDead;
            computerStatusStart[i] = computerUnits.get(i).isDead;
        }
        System.out.print("Player: ");
        playerUnit.firstPhase(computerUnit, playerUnits, computerUnits);
        System.out.print("Computer: ");
        computerUnit.firstPhase(playerUnit, computerUnits, playerUnits);

        if (playerUnit.isDead || computerUnit.isDead) {
            if (playerUnit.isDead && !computerUnit.isDead) {
                computerUnit.increaseLevel();
                System.out.println(playerUnit.name + " is dead now");
                System.out.println(computerUnit.name + " levels up by 1");
            }
            if (!playerUnit.isDead && computerUnit.isDead) {
                playerUnit.increaseLevel();
                System.out.println(playerUnit.name + " levels up by 1");
                System.out.println(computerUnit.name + " is dead now");
            }
            boolean[] playerStatusEnd = new boolean[6];
            boolean[] computerStatusEnd = new boolean[6];
            for (int i = 0; i < 6; i++) {
                playerStatusEnd[i] = playerUnits.get(i).isDead;
                computerStatusEnd[i] = computerUnits.get(i).isDead;
            }
            for (int i = 0; i < 6; i++) {
                if (playerStatusStart[i] != playerStatusEnd[i] && !computerUnit.isDead) {
                    computerUnit.increaseLevel();
                    System.out.println(computerUnit.name + " levels up by 1");
                }
                if (computerStatusStart[i] != computerStatusEnd[i] && !playerUnit.isDead) {
                    playerUnit.increaseLevel();
                    System.out.println(playerUnit.name + " levels up by 1");
                }
            }
            playerUnits.add(playerUnit);
            computerUnits.add(computerUnit);
            phaseBattleEnded = 1;
            checkGameEnd();
            return;
        }
        System.out.print("Player: ");
        playerUnit.secondPhase(computerUnit, playerUnits, computerUnits);
        System.out.print("Computer: ");
        computerUnit.secondPhase(playerUnit, computerUnits, playerUnits);

        if (playerUnit.isDead || computerUnit.isDead) {
            if (playerUnit.isDead && !computerUnit.isDead) {
                computerUnit.increaseLevel();
                System.out.println(playerUnit.name + " is dead now");
                System.out.println(computerUnit.name + " levels up by 1");
            }
            if (!playerUnit.isDead && computerUnit.isDead) {
                playerUnit.increaseLevel();
                System.out.println(playerUnit.name + " levels up by 1");
                System.out.println(computerUnit.name + " is dead now");
            }
            boolean[] playerStatusEnd = new boolean[6];
            boolean[] computerStatusEnd = new boolean[6];
            for (int i = 0; i < 6; i++) {
                playerStatusEnd[i] = playerUnits.get(i).isDead;
                computerStatusEnd[i] = computerUnits.get(i).isDead;
            }
            for (int i = 0; i < 6; i++) {
                if (playerStatusStart[i] != playerStatusEnd[i] && !computerUnit.isDead) {
                    computerUnit.increaseLevel();
                    System.out.println(computerUnit.name + " levels up by 1");
                }
                if (computerStatusStart[i] != computerStatusEnd[i] && !playerUnit.isDead) {
                    playerUnit.increaseLevel();
                    System.out.println(playerUnit.name + " levels up by 1");
                }
            }
            playerUnits.add(playerUnit);
            computerUnits.add(computerUnit);
            phaseBattleEnded = 2;
            checkGameEnd();
            return;
        }
        System.out.print("Player: ");
        playerUnit.thirdPhase(computerUnit, playerUnits, computerUnits);
        System.out.print("Computer: ");
        computerUnit.thirdPhase(playerUnit, computerUnits, playerUnits);

        if (playerUnit.isDead && !computerUnit.isDead) {
            computerUnit.increaseLevel();
            System.out.println(playerUnit.name + " is dead now");
            System.out.println(computerUnit.name + " levels up by 1");

        }
        if (!playerUnit.isDead && computerUnit.isDead) {
            playerUnit.increaseLevel();
            System.out.println(playerUnit.name + " levels up by 1");
            System.out.println(computerUnit.name + " is dead now");
        }
        boolean[] playerStatusEnd = new boolean[6];
        boolean[] computerStatusEnd = new boolean[6];
        for (int i = 0; i < 6; i++) {
            playerStatusEnd[i] = playerUnits.get(i).isDead;
            computerStatusEnd[i] = computerUnits.get(i).isDead;
        }
        for (int i = 0; i < 6; i++) {
            if (playerStatusStart[i] != playerStatusEnd[i] && !computerUnit.isDead) {
                computerUnit.increaseLevel();
                System.out.println(computerUnit.name + " levels up by 1");
            }
            if (computerStatusStart[i] != computerStatusEnd[i] && !playerUnit.isDead) {
                playerUnit.increaseLevel();
                System.out.println(playerUnit.name + " levels up by 1");
            }
        }
        playerUnits.add(playerUnit);
        computerUnits.add(computerUnit);
        phaseBattleEnded = 3;
        checkGameEnd();
    }
    public void checkGameEnd(){
        int count1 = 0;
        int count2 = 0;
        for(int i = 0; i < playerUnits.size(); i++){
            if(playerUnits.get(i).isDead){
                count1++;
            }
            if(computerUnits.get(i).isDead){
                count2++;
            }
        }
        if(count1 == playerUnits.size()){
            gameEnded = true;
            playerWon = false;
        }
        if(count2 == computerUnits.size()){
            gameEnded = true;
            playerWon = true;
        }
    }

    public void printComputerUnits(){
        for(int i = 0; i < computerUnits.size(); i++ ){
            System.out.printf("%d. %s %n",i+1,computerUnits.get(i).getInfo());
        }
    }
    public void printPlayerUnits(){
        for(int i = 0; i < playerUnits.size(); i++){
            System.out.printf("%d. %s %n",i+1,playerUnits.get(i).getInfo());
        }
    }

}
