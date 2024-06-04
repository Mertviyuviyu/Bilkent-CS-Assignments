package Lab01;

import java.util.Scanner;

public class Lab01_Q3 {
    public static void main(String[] args) {
        
        final int CAL_DEFICIT = 7700;
        final int DAILY_CAL = 2000;
        int kg;
        int days;

        
        Scanner input = new Scanner(System.in);

        System.out.print("Enter kilograms to lose: ");
        kg = input.nextInt();
       
        System.out.printf("Enter days to lose %d kilograms: ",kg);
        days = input.nextInt();





        
        double calToLose;
        double takeCal;
        double recCarb;
        double gramCarb;
        double recFat;
        double gramFat;
        double recProt;
        double gramProt; 
        
        calToLose = (kg * CAL_DEFICIT) / days;
        takeCal = DAILY_CAL - calToLose;
        recCarb = takeCal * 0.5;
        gramCarb = recCarb / 4;
        recFat = takeCal * 0.3;
        gramFat = recFat / 9;
        recProt = takeCal * 0.2;
        gramProt = recProt / 4;



 
        System.out.println("*********************************************************************************************");
        System.out.printf("To lose %d kilograms in %d days you will need a daily deficit of %.0f calories %n",kg,days,calToLose);
        System.out.println("*********************************************************************************************");
        System.out.printf("RECOMMENDED DAILY CALORIES TO LOSE %d KILOS IN %d DAYS: %.0f %n",kg,days,takeCal);
        System.out.println("*********************************************************************************************");
       //10 5 5 10
        System.out.printf("MACRO          RECOMMENDED PERCENT     CALORIES PER GRAM      RECOMMENDED CALORIES      GRAMS %n");
        System.out.printf("CARBOHYDRATE                   50%%                     4 %25.0f %10.1f  %n",recCarb,gramCarb);
        System.out.printf("FAT                            30%%                     9 %25.0f %10.1f  %n",recFat,gramFat);
        System.out.printf("PROTEIN                        20%%                     4 %25.0f %10.1f  %n",recProt,gramProt);
        System.out.print("*********************************************************************************************");


        input.close();

















    }
}
