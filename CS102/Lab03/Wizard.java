package Lab03;

import java.util.ArrayList;

public class Wizard extends Unit {
    public Wizard(){
        super("Wizard", 3, 1);
    }
    public int getAttack(){
        return 1;
    }
    public int getMaxHealth(){
        return level+2;
    }
    public void firstPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        System.out.println("Wizard does nothing");
    }
    public void secondPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        System.out.println("Wizard does nothing");
    }
    public void thirdPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        for(int i = 0; i < enemyWaiting.size(); i++){
            enemyWaiting.get(i).damage(getAttack());
        }
        System.out.println("Wizard deals " + getAttack() + " damage to every waiting enemy opponent");
    }   
}
