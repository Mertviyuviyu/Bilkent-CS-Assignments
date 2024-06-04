package Lab05;

import java.util.Scanner;

public class Lab05_Q3 { 
    
    static Scanner in = new Scanner(System.in);


    public static void displayMenu(){
        System.out.println("1 - Find Probability of Same Birthday");
        System.out.println("2 - Draw Chart");
        System.out.println("3 - Convert Word");
        System.out.println("4 - QUIT");
    }
    public static int getChoice(){
        System.out.print("Enter Choice: ");
        int choice = in.nextInt();
        in.nextLine();
        return choice;
    }
    public static double sameBirthday(int group){
        double sameRate = 1;
        for (double i = 0; i < group; i++) {
            sameRate *= (365.0 - i) / 365.0;
        }
        sameRate = 1 - sameRate;
        return sameRate;
    }
    public static int findMax(int num){
        int max = 0; 
        int digit; 

        while (num > 0) {
            digit = num % 10; 
            if (digit > max) {
                max = digit; 
            }
            num /= 10; 
        }
        return max;
    }
    public static void displayChart(String chartData){

        if(!isValidNumeric(chartData)){
            System.out.println("Invalid input - input must be numeric!");
        }
        else if(isValidNumeric(chartData)){
        
            Scanner scanner = new Scanner(chartData);
            int number = scanner.nextInt();
            scanner.close();
            
    
            for(int l = 0; l < chartData.length(); l++){
                System.out.printf("review %d   ",l+1);
                
            }
            System.out.println();
            for(int k = findMax(number); k > 0; k--){
                for(int i=0; i < chartData.length(); i++){

                    if(chartData.charAt(i)-48 >= k ){
                        System.out.print("     ***   ");
                    }
                    else{
                        System.out.print("           ");
                    }
                }
                System.out.println();
            }
            
        }
    }
    public static boolean isValidNumeric(String check){
        boolean numeric = true;
        for(int i = 0; i < check.length(); i++){
            if (! Character.isDigit(check.charAt(i))){
                i = check.length();
                numeric = false;

            }
        }
        return numeric;
    }
    public static int countLetter(String input, int index){
        int count = 0;
        for(int k = 0; k < input.length(); k++){
            if(Character.toLowerCase(input.charAt(index)) == Character.toLowerCase(input.charAt(k))){
                count++;
            }
        }
        return count;
    }
    public static String convertWord(String userIn){
        String converted = "";
        for(int k = 0; k < userIn.length(); k++){
            if(countLetter(userIn, k) > 1){
                converted += ") ";
            }
            else if(!Character.isLetter(userIn.charAt(k))){
                converted += "* ";
            }
            else{
                converted += "( ";
            }
        }
        return converted;
    }
    public static void main(String[] args) {
        int size;
        displayMenu();
        int userChoice = getChoice();
        if(userChoice == 1){
            System.out.print("Enter Group Size: ");
            size = in.nextInt();
            in.nextLine();
            double chance = sameBirthday(size);
            System.out.printf("The probability of two people in a group of %d having the same birthday is %.2f",size,chance); 
        }
        else if(userChoice == 2){
            System.out.print("Enter chart data: ");
            String data = in.next();
            in.nextLine();
            displayChart(data);

        }
        else if(userChoice == 3){
            System.out.print("Enter word to convert: ");
            String toConvert = in.nextLine();
            String converted = convertWord(toConvert);
            System.out.printf("Original word: %s  Converted Word: %s",toConvert,converted);

        }
        else if(userChoice == 4){
            System.out.println("Goodbye!");
        }
        else{
            System.out.println("Invalid choice");
        }
        in.close();
    }
}
