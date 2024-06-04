package Lab01;

import java.util.Scanner;

public class Lab01_Q2 {
    public static void main(String[] args) {
        
       //   08:10/Saturday-April-01,2023
       
        String dt;
        int dotPos;
        int slashPos;
        int dash1;
        int dash2;
        int commaPos;


        Scanner input = new Scanner(System.in);

        System.out.print("Enter date and time: ");
        dt=input.nextLine();

        input.close();


        dotPos = dt.indexOf(':');
        slashPos = dt.indexOf('/');
        dash1 = dt.indexOf('-');
        dash2 = dt.indexOf('-', dash1+1);
        commaPos = dt.indexOf(',');

        String day = dt.substring(slashPos+1,dash1);
        String minute = dt.substring(dotPos+1, slashPos);
        String hour = dt.substring(0,dotPos);
        String date = dt.substring(dash2+1,commaPos);
        String month = dt.substring(dash1+1,dash2);
        String year = dt.substring(commaPos+1);


        System.out.printf("%s minutes past %s on %s %s %s (%s)",minute,hour,date,month,year,day);



    }
}
