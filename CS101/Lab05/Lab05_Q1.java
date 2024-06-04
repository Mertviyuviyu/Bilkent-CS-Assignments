package Lab05;

import java.util.Scanner;

public class Lab05_Q1 {
    public static int persistance(int num){
        int a;
        int answer = 1;
        int count = 0;
        
        if(num / 10 != 0){
            count++;
        }

        do {
            answer = 1;
            
            while(num != 0){

                a = num % 10;
                answer *= a;
                num /= 10;             
            }

            num = answer;
            if(answer / 10 != 0){
                count++;
            }

        } while(answer / 10 != 0);
        
        return count;

    }
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        int userIn = 0;

        while(userIn <= 0){
            System.out.print("Enter a positive integer: ");
            if(input.hasNextInt()){
                userIn = input.nextInt();
            }
            else{
                input.next();
            }

        }
        System.out.printf("multiplicative persistance of %d is %d",userIn,persistance(userIn));

        input.close();
    }
    
}
