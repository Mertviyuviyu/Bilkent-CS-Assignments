package Lab03;

import java.util.ArrayList;

public class Healer extends Unit{
    public Healer(){
        super("Healer", 3, 1);
    }
    public int getAttack(){
        return level;
    }
    public int getMaxHealth(){
        return level+2;
    }
    public void firstPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        if(health == getMaxHealth()){
            Unit chosen = chooseRandomUnitAlive(allyWaiting);
            if(chosen != null){
                chosen.heal(level);
                System.out.println("Healer heals waiting ally " + chosen.name + " by " + level);
            }
            else{
                System.out.println("Healer does nothing.");
            }
        }
        else{
            heal(level);
            System.out.println("Healer heals itself by " + level);
        }
    }
    public void secondPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        arenaOpponent.damage(getAttack());
        System.out.println("Healer damaged arena opponent by " + getAttack());
    }
    public void thirdPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        Unit chosen = chooseRandomUnitDead(allyWaiting);
        if(chosen != null){
            chosen.revive();
            System.out.println("Healer revives waiting ally" + chosen.name);
        }
        else{
            System.out.println("Healer does nothing");
        }
    }
}

