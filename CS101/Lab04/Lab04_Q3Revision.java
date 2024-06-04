package Lab04;

import java.util.Scanner;

public class Lab04_Q3Revision {
    public static void main(String[] args) {
        
        String userData;
        boolean notLower;

        Scanner input = new Scanner(System.in);

        
        do{
            System.out.print("Enter word to convert: ");
            userData = input.next();
            notLower = false;
            String converted = "";
            for(int a = 0; a < userData.length(); a++){
                char letterCheck = userData.charAt(a);
                if(!Character.isLowerCase(letterCheck)){
                    notLower = true;
                    
                }
            }
            if(notLower){
                System.out.println("Invalid input! Only enter lowercase letters");
            }
            
            else if(!userData.equalsIgnoreCase("exit") & !notLower){
                char mostRepeated = userData.charAt(0);
                int maxCount = 0;

                for(int f = 0; f < userData.length(); f++){
                    char check = userData.charAt(f);
                    int count = 0;
                    
                    for(int s = f+1; s < userData.length(); s++){
                        if(userData.charAt(s) == check){
                            count++;
                        }

                    }

                    if(count > maxCount){
                        maxCount = count;
                        mostRepeated = check;
                    }

                }


                for (int k = 0; k < userData.length(); k++) {
                    char replace = userData.charAt(k);
                    if (replace == mostRepeated) {
                        converted += "(";
                    } 
                    else {
                        int checker = replace + userData.length();
                        if(checker > 122){
                            checker = checker - 26;
                            converted += (char)(checker);

                        }
                        else{
                            converted += (char)(checker);
                        }
                    }
                }
                System.out.println("Length:" + userData.length());
                System.out.println("Converted word: " + converted);;
                
                
            }

        } while(!userData.equalsIgnoreCase("exit"));

    input.close();


    }
}
