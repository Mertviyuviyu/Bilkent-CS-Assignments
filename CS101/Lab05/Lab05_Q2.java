package Lab05;

import java.util.Scanner;

public class Lab05_Q2 {
    static final String KEY = "a@bpdqi!l1mwnuo0s5t+z2A4B8E3G6WM";

    public static char convertChar(char in){
        int index = KEY.indexOf(in);
        if(index >= 0 && index % 2 == 0){
            return KEY.charAt(index+1);
        }
        else{
            return in;
        }
    }

    public static String convertText(String in){
        String convertedText = "";
        for(int l = 0; l < in.length(); l++){
            char evChar = in.charAt(l);
            convertedText += convertChar(evChar);
        }
        return convertedText;
    }

    public static int countNumbers(String in){
        int count = 0;
        for(int l = 0; l < in.length(); l++){
            char charCheck = in.charAt(l);
            if (charCheck >= 48 && charCheck <= 57){
                count++;
            }
        }
        return count;
    }


    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        System.out.print("Enter a phrase for conversion: ");

        String userInput = input.nextLine();

        if(userInput.isEmpty()){
            System.out.println("No phrase entered.");
        }
        else{
            System.out.printf("Text you entered: '%s' %n",userInput);
            System.out.printf("After conversion: '%s' %n",convertText(userInput));
            if(countNumbers(convertText(userInput)) == 0){
                System.out.println("!! Attention !! There is no number in this text");
            }
            if(convertText(userInput).equals(userInput)){
                System.out.println("No conversion happened.");
            }
        }
        input.close();
        
    }
}
