package Lab03;

import java.util.ArrayList;

public class Bard extends Unit {
    public Bard(){
        super("Bard", 1, 1);
    }
    public int getAttack(){
        return level;
    }
    public int getMaxHealth(){
        return level;
    }
    public void firstPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        arenaOpponent.damage(getAttack());
        System.out.println("Bard damaged arena opponent by " + getAttack());
    }
    public void secondPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        heal(1);
        System.out.println("Bard heals itself by 1");
    }
    public void thirdPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        Unit chosen = chooseRandomUnitAlive(allyWaiting);
        if(chosen != null){
            chosen.increaseLevel();
            System.out.println("Bard leveled-up ally " + chosen.name + " by " + "1");
        }
        else{
            System.out.println("Bard does nothing.");
        }
    }
    
}
