package Lab03;

import java.util.ArrayList;
import java.util.Random;

public abstract class Unit {
    public String name;
    public int health;
    public int level;
    public boolean isDead;
    public abstract int getAttack(); 
    public abstract int getMaxHealth();
    public abstract void firstPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting);
    public abstract void secondPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting);
    public abstract void thirdPhase(Unit arenaOpponent, ArrayList<Unit> allyWaiting, ArrayList<Unit> enemyWaiting);
    public Unit(String name, int health, int level){
        this.name = name;
        this.health = health;
        this.level = level;
        isDead = false;
    }
    public void damage(int damageAmount){
        if(health - damageAmount <= 0){
            isDead = true;
            health = 0;
        }
        else{
            health = health - damageAmount;
        }
    }
    public void increaseLevel(){
        level++;
    }
    public void decreaseLevel(){
        if(level != 1){
            level--;
        }
        if(health > getMaxHealth()){
            health = getMaxHealth();
        }
    }
    public void revive(){
        if(isDead){
            decreaseLevel();
            health = getMaxHealth();
            isDead = false;
        }
    }
    public void heal(int healAmount){
        if(health + healAmount >= getMaxHealth()){
            health = getMaxHealth();
        }
        else{
            health += healAmount;
        }
    }
    public String getInfo(){
        return (name + ", LVL: " + level + ", ATK: " + getAttack() +", HEALTH: " + health + "/" + getMaxHealth());
    }
    public Unit chooseRandomUnitAlive(ArrayList<Unit> units){
        ArrayList<Unit> possibleUnits = new ArrayList<>();
        for(int i = 0; i < units.size(); i++){
            if(!units.get(i).isDead){
                possibleUnits.add(units.get(i));
            }
        }
        Random rr = new Random();
        if(possibleUnits.size() == 0){
            return null;
        }
        int chosen = rr.nextInt(possibleUnits.size());
        return possibleUnits.get(chosen);
    }
    public Unit chooseRandomUnitDead(ArrayList<Unit> units){
        ArrayList<Unit> possibleUnits = new ArrayList<>();
        for(int i = 0; i < units.size(); i++){
            if(units.get(i).isDead){
                possibleUnits.add(units.get(i));
            }
        }
        Random rr = new Random();
        if(possibleUnits.size() == 0){
            return null;
        }
        int chosen = rr.nextInt(possibleUnits.size());
        return possibleUnits.get(chosen);
    }

}

