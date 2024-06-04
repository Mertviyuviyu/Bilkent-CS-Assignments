package Lab02;

import java.util.ArrayList;

public class Word {
    private String text;
    private ArrayList<Word> canBeFollowedBy;

    public Word(String text){
        this.text = text;
        this.canBeFollowedBy = new ArrayList<Word>();

    }
    public String getText(){
        return text;
    }
    public ArrayList<Word> getCanBeFollowedBy() {
        return canBeFollowedBy;
    }
    public void addFollowedBy(Word w) {
        canBeFollowedBy.add(w);
    }
    public boolean canEndSentence(){
        for(int i = 0; i < canBeFollowedBy.size(); i++){
            if (canBeFollowedBy.get(i).getText().equals("<END>")){
                return true;
            }
        }
        return false;
    }
}
