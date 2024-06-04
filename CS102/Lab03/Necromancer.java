package Lab03;

import java.util.ArrayList;

public class Necromancer extends Unit{
    public Necromancer(){
        super("Necromancer", 2, 1);
    }
    public int getAttack(){
        return level;
    }
    public int getMaxHealth(){
        return level+1;
    }
    public void firstPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        arenaOpponent.damage(getAttack());
        System.out.println("Necromancer damaged arena opponent by " + getAttack());
    }
    public void secondPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        Unit chosen = chooseRandomUnitDead(allyWaiting);
        if(chosen != null){
            chosen.revive();
            System.out.println("Necromancer revives waiting ally" + chosen.name);
        }
        else{
            this.damage(1);
            System.out.println("Necromancer deals 1 damage to iself");
        }
    }
    public void thirdPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting){
        arenaOpponent.decreaseLevel();
        System.out.println("Necromancer decreases arena opponents level by 1");
    }
}
