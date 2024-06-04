package Lab03;

import java.util.Random;
import java.util.Scanner;

public class Lab03_Q1 {
    public static void main(String[] args) {
        
        int userChoice;
        String userWord;
        int wordLength;
        int divIndex;
        String firstPart;
        String secondPart;
        String swappedWord;
        int n;
        int randomNumber;
        int randomIndex;
        String encodedWord;
        String letter;
        String lastPart;
        String decodedWord;
        String firstPart2;
        String secondPart2;

        System.out.println("1) Encode Message ");
        System.out.println("2) Decode Message ");
        System.out.println("3) Quit ");
        System.out.print("Enter a choice: ");

        Scanner input = new Scanner(System.in);
        Random rr = new Random();

        userChoice = input.nextInt();
        input.nextLine();
        userWord = "";
        encodedWord = "";
        decodedWord = "";
        divIndex = 0;
       
        while( userChoice != 3){
            
            if( userChoice > 3 || userChoice < 1){
                System.out.println("Invalid choice - try again...");

            }
            
            
            
            else if( userChoice == 1){
                System.out.print("Enter word to encode: ");
                userWord = input.nextLine();
                wordLength = userWord.length();
                divIndex = rr.nextInt(wordLength-1)+1;
                
                firstPart = userWord.substring(0, divIndex);
                secondPart = userWord.substring(divIndex);
                swappedWord = secondPart + " " + firstPart;
                
                
                randomIndex = rr.nextInt(wordLength+1);
                randomNumber = rr.nextInt(10);
                firstPart = swappedWord.substring(0, randomIndex);
                letter = swappedWord.substring(randomIndex,randomIndex+1);
                lastPart = swappedWord.substring(randomIndex+1);
                encodedWord = firstPart + letter + randomNumber + lastPart;
                
                n = 1;

                while( n < wordLength ){
                    randomIndex = rr.nextInt(wordLength+1);
                    randomNumber = rr.nextInt(10);
                    firstPart = encodedWord.substring(0, randomIndex);
                    letter = encodedWord.substring(randomIndex,randomIndex+1);
                    lastPart = encodedWord.substring(randomIndex+1);
                    encodedWord = firstPart + letter + randomNumber + lastPart;

                    n++;
                    
                }
                System.out.println(encodedWord);
                
            }
            else if (userChoice == 2){
                if(userWord == ""){
                    System.out.println("No message to decode...");
                }
                else{
                    int k = 0;
                    decodedWord = "";
                    while(k < encodedWord.length()){
                        if (!('0' <= encodedWord.charAt(k) && encodedWord.charAt(k) <= '9')){
                            decodedWord += encodedWord.charAt(k);
                            

                        }
                        k++;
                    }
                    firstPart2 = decodedWord.substring(0 , decodedWord.length() - divIndex);
                    secondPart2 = decodedWord.substring(decodedWord.length() - divIndex);

                    decodedWord = secondPart2 + firstPart2;
                
                    
                    
                    System.out.printf("The decoded message is: %s %n",decodedWord);
                }


            }
            
            
            
            
            
            System.out.print("Enter a choice: ");
            userChoice = input.nextInt();
            input.nextLine();


        }
        System.out.println("Goodbye!");


        input.close();
    }
    
}
