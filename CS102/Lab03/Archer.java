package Lab03;

import java.util.ArrayList;

public class Archer extends Unit{
    public Archer(){
        super("Archer", 2, 1);
    }
    public int getAttack(){
        return level+1;
    }
    public int getMaxHealth(){
        return level+1;
    }
    public void firstPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        arenaOpponent.damage(getAttack());
        System.out.println("Archer damaged arena opponent by " + getAttack());
    }
    public void secondPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        Unit opponent = chooseRandomUnitAlive(enemyWaiting);
        if(opponent != null){
            opponent.damage(getAttack());
            System.out.println("Archer damaged waiting " + opponent.name + " by " + getAttack());
        }
        else{
            System.out.println("Archer does nothing");
        }
    }
    public void thirdPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        heal(1);
        System.out.println("Archer heals itself by 1");
    }
}
