package Lab02;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Random;

public class WordBag {
    private ArrayList<Word> allWords;
    
    public WordBag(){
        allWords = new ArrayList<Word>();
    }

    public void processSentence(String sentence){
        String[] words = sentence.split(" ");
        Word first = findOrCreate("<START>");
        for(int i = 0; i < words.length; i++){
            Word second = findOrCreate(words[i]);
            first.addFollowedBy(second);
            first = second;
        }
        first.addFollowedBy(findOrCreate("<END>"));
    }

    public Word findOrCreate(String wordText){
        for(int i = 0; i < allWords.size(); i++){
            if(allWords.get(i).getText().equals(wordText)){
                return allWords.get(i);
            }
        }
        Word createWord = new Word(wordText);
        allWords.add(createWord);
        return createWord;
    }

    public String generateSentence(int softLimit, int hardLimit){
        int wordCounter = 0;
        String sentence = "";
        Word current = findOrCreate("<START>");

        while(wordCounter < hardLimit){
            ArrayList<Word> pickWordList = current.getCanBeFollowedBy();
            Random rr = new Random();
            int choice = rr.nextInt(pickWordList.size());
            Word nextWord = pickWordList.get(choice);
            if(nextWord.getText().equals("<END>")){
                break;
            }
            sentence += nextWord.getText();
            sentence += " ";
            wordCounter++;
            if(wordCounter >= softLimit && nextWord.canEndSentence()){
                break;
            }
            current = nextWord;
        }
        return sentence;
    }

    public void writeToTextFile(String outputName, int sentenceCount, int softLimit, int hardLimit){
        try {
            // open the output writer
            FileWriter writer = new FileWriter(outputName + ".txt");
            for(int i = 0; i < sentenceCount; i++){
                String printSent = generateSentence(softLimit, hardLimit);
                writer.write(printSent + "\n");
            }
            System.out.println("Saved to " + outputName + ".txt");
            // in the end we need to close the file
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Word> getAllWords(){
        return allWords;
    }
}
