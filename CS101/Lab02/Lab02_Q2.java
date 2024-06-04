package Lab02;

import java.util.Scanner;

public class Lab02_Q2 {
    public static void main(String[] args) {
        
        Scanner input = new Scanner(System.in);
        int smallJar;
        int bigJar;
        int order;
        int amount;
        int needBigJar;
        int needSmallJar;
        

        System.out.print("Input the  number of small and large jars available and the order size: ");
        smallJar = input.nextInt();
        bigJar = input.nextInt();
        order =input.nextInt();

        amount = bigJar * 5 + smallJar;
        needBigJar = order / 5;
        




        if(order < 5){
            System.out.println("Order must be larger than 5 litres");

        }

        else{

            if(order > amount || (order - needBigJar*5)> smallJar){
                System.out.println("You do not have enough jars to complete the order");

            }
            else{
                if(needBigJar > bigJar){
                    needSmallJar = order - bigJar*5;
            
                }
                else{
                    needSmallJar = order - needBigJar*5;
                }

                
                System.out.printf("Order of %d litres will contain %d small(1 litre)jars",order,needSmallJar);
            }


        }

        input.close();









    }
    
}
