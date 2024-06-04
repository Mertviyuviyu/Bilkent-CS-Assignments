package Lab04;

import java.util.Scanner;

public class Lab04_Q2 {
    public static void main(String[] args) {
        String data;
        double average = 0;
        
        boolean invalidData = false;
        
        Scanner input = new Scanner(System.in);
        System.out.print("Enter chart data: ");
        data = input.next();

        for(int i = 0; i < data.length(); i++){
            if (! Character.isDigit(data.charAt(i))){
                System.out.println("Invalid chart data!");
                i = data.length();
                invalidData = true;

            }
        }

        if(!invalidData){
    
            for(int l = 0; l < data.length(); l++){
                System.out.printf("review %d   ",l+1);
                
            }
            System.out.println();
            for(int k = 9; k > 0; k--){
                for(int i=0; i < data.length(); i++){

                    if(data.charAt(i)-48 >= k ){
                        System.out.print("     ***   ");
                    }
                    else{
                        System.out.print("           ");
                    }
                }
                System.out.println();
            }
            for(int i=0; i < data.length(); i++){
                
                average += data.charAt(i);
            }

            average = average - (48 * data.length());
            average = average / data.length();


            System.out.printf("Average Review: %.1f",average);
        }

        input.close();

        }
            
        
    }
    



