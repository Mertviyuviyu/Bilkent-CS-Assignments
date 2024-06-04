package Lab01;

import java.util.Scanner;
import java.lang.Math;

/**
 * Lab01_Q1
 */
public class Lab01_Q1 {

    public static void main(String[] args) {
        
        int x;
        double y;
        double roundedY;
        

        Scanner input = new Scanner(System.in);
        System.out.print("Enter x: ");
       
        x = input.nextInt();
        
        y = (Math.pow(x, 3) + 3*Math.abs(x) + 9 ) / Math.pow(x, 2);

        roundedY = Math.round(y);
        
        System.out.println("y:" + (int)roundedY);
        System.out.printf("%.2f is between %d and %d",y, (int)Math.floor(y),(int)Math.ceil(y));

       

        input.close();


    

    }
}