package Lab02;

import java.util.Scanner;

public class Lab02_Q1 { 
    public static void main(String[] args) {

        double x;
        double y;
        String wrong;
        Scanner input = new Scanner(System.in);
        System.out.print("Enter a real number: ");

        if(input.hasNextDouble()){

            x = input.nextDouble();

            if(x > 15){
                y = Math.sqrt(Math.pow(x, 5) + 1);

            }    
            else if(15 >= x && x >= 0 ){
                y = Math.exp(x) - 15 ;

            }
            else{
                y = x / (x+10);

            }
            System.out.println("---------------------");
            System.out.printf("f(x) = %.2f",y);    


        }

        else{
            wrong = input.nextLine();
            System.out.println("Invalid input - value must be numeric....");
            System.out.printf("You entered: %s",wrong);
        }


        input.close();        


}

    



















    
}