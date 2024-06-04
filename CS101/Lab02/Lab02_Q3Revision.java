package Lab02;

import java.util.Scanner;

public class Lab02_Q3Revision {
    public static void main(String[] args) {
        
        String line;
        int length;
        char first;
        char middle;
        char last;
        char userCharacter;

        
        Scanner input = new Scanner(System.in);

        System.out.print("Enter string: ");
        line = input.nextLine();
        length = line.length();
        System.out.print("Enter a character to check super special: ");
        userCharacter = input.next().charAt(0);



        first = line.charAt(0);
        middle = line.charAt((int) Math.ceil(length/2));
        last = line.charAt(length-1);



         
        if(length<3){
            System.out.println("Length of string not sufficient");
        }
        else if( !((97 <= first && first <= 122) && (97 <= middle && middle <= 122) && (97 <= last && last <= 122)) ){
            System.out.println("Characters not lowercase letters...");
        }
        else if((Math.abs(first-userCharacter)<=1 && (Math.abs(userCharacter-last)>=2 && Math.abs(userCharacter-middle)>=2 ))){

            if(line.contains(" ")){
                System.out.println("String is super special: true");


            }
            else{
                System.out.printf("first:%c middle:%c last %c %n",first,middle,last);
                System.out.println("String is super special: true");
            }
        }
        else if((Math.abs(middle-userCharacter)<=1 && (Math.abs(userCharacter-first)>=2 && Math.abs(userCharacter-last)>=2))){

            if(line.contains(" ")){
                System.out.println("String is super special: true");


            }
            else{
                System.out.printf("first:%c middle:%c last %c %n",first,middle,last);
                System.out.println("String is super special: true");
            }
           
        }
        else if((Math.abs(last-userCharacter)<=1 && (Math.abs(userCharacter-first)>=2 && Math.abs(userCharacter-middle)>=2))){

            if(line.contains(" ")){
                System.out.println("String is super special: true");


            }
            else{
                System.out.printf("first:%c middle:%c last %c %n",first,middle,last);
                System.out.println("String is super special: true");
            }
           
        }
        else{

            if(line.contains(" ")){
                System.out.println("String is super special: false");


            }
            else{
                System.out.printf("first:%c middle:%c last %c %n",first,middle,last);
                System.out.println("String is super special: false");
            }
        
    
        }

        input.close();





    }
    
}
