package Lab03;

import java.util.ArrayList;

public class Rogue extends Unit {
    public Rogue(){
        super("Rogue", 1, 1);
    }
    public int getAttack(){
        return level+2;
    }
    public int getMaxHealth(){
        return level;
    }
    public void firstPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        arenaOpponent.damage(getAttack());
        System.out.println("Rogue damaged arena opponent by " + getAttack());
    }
    public void secondPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        arenaOpponent.damage(getAttack());
        System.out.println("Rogue damaged arena opponent by " + getAttack());
    }
    public void thirdPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        Unit opponent = chooseRandomUnitAlive(enemyWaiting);
        if(opponent != null){
            opponent.damage(getAttack());
            System.out.println("Rogue damaged waiting " + opponent.name + " by " + getAttack());
        }
        else{
            System.out.println("Rogue does nothing");
        }
    }
}
