package Lab04;

import java.util.Scanner;

public class Lab04_Q3 {
    public static void main(String[] args) {
        
        String userData;
        boolean notLetter;
        boolean same;
        boolean unique;

        Scanner input = new Scanner(System.in);

        
        
        do{
            System.out.print("Enter word to convert: ");
            userData = input.next();
            
            if(!userData.equalsIgnoreCase("exit")){
                System.out.printf("Original word: %s  Converted Word: ",userData);

                

                for(int i = 0; i < userData.length(); i++){
                    notLetter = false;
                    same = false;
                    unique = false;

                    for(int k = 0; k < userData.length(); k++){
                        
                        
                        if(!Character.isLetter(userData.charAt(i))){
                            notLetter = true;
                        }
                        else if(Character.toLowerCase(userData.charAt(i)) == Character.toLowerCase(userData.charAt(k)) && k != i){
                            same = true;
                        }
                        else{
                            unique = true;
                        } 
                    }

                    if (notLetter){
                        System.out.print("* ");
                    }
                    else if (same){
                        System.out.print(") ");
                    }
                    else if (unique){
                        System.out.print("( ");
                    }


                }
                
                System.out.println();
            }

        } while(!userData.equalsIgnoreCase("exit"));

    input.close();


    }
    
}
