package Lab01;

import java.util.Scanner;

public class Lab01_Q3Revision {
    public static void main(String[] args) {
        
        final int CAL_DEFICIT = 7700;
        // final int DAILY_CAL = 2000;
        int kg;
        int days;
        int minCal;
        int maxCal;


        
        Scanner input = new Scanner(System.in);

        System.out.print("Enter kilograms to lose: ");
        kg = input.nextInt();
       
        System.out.printf("Enter days to lose %d kilograms: ",kg);
        days = input.nextInt();

        System.out.print( "Enter minimum calories to take daily: ");
        minCal = input.nextInt();

        System.out.print("Enter maximum calories to take daily: ");
        maxCal = input.nextInt();





        
        double calToLose;
        double minTakeCal;
        double minRecCarb;
        double minGramCarb;
        double minRecFat;
        double minGramFat;
        double minRecProt;
        double minGramProt;

        calToLose = (kg * CAL_DEFICIT) / days;
        
        minTakeCal = minCal - calToLose;
        minRecCarb = minTakeCal * 0.5;
        minGramCarb = minRecCarb / 4;
        minRecFat = minTakeCal * 0.3;
        minGramFat = minRecFat / 9;
        minRecProt = minTakeCal * 0.2;
        minGramProt = minRecProt / 4;

        double maxTakeCal;
        double maxRecCarb;
        double maxGramCarb;
        double maxRecFat;
        double maxGramFat;
        double maxRecProt;
        double maxGramProt;
        

        maxTakeCal = maxCal - calToLose;
        maxRecCarb = maxTakeCal * 0.5;
        maxGramCarb = maxRecCarb / 4;
        maxRecFat = maxTakeCal * 0.3;
        maxGramFat = maxRecFat/ 9;
        maxRecProt = maxTakeCal * 0.2;
        maxGramProt = maxRecProt / 4;



 
        System.out.println("**********************************************************************************************************************");
        System.out.printf("To lose %d kilograms in %d days you will need a daily deficit of %.0f calories %n",kg,days,calToLose);
        System.out.println("**********************************************************************************************************************");
        System.out.printf("RECOMMENDED  MINIMUM DAILY CALORIES TO LOSE %d KILOS IN %d DAYS: %.0f %n",kg,days,minTakeCal);
        System.out.printf("RECOMMENDED  MAXIMUM DAILY CALORIES TO LOSE %d KILOS IN %d DAYS: %.0f %n",kg,days,maxTakeCal);
        System.out.println("**********************************************************************************************************************");
       //10 5 5 10
        System.out.printf("MACRO          RECOMMENDED PERCENT     CALORIES PER GRAM      MIN CALORIES    MAX CALORIES      MIN GRAMS    MAX GRAMS%n");
        System.out.printf("CARBOHYDRATE                   50%%                     4 %17.0f %15.0f %14.1f %12.1f %n",minRecCarb,maxRecCarb,minGramCarb,maxGramCarb);
        System.out.printf("FAT                            30%%                     9 %17.0f %15.0f %14.1f %12.1f %n",minRecFat,maxRecFat,minGramFat,maxGramFat);       
        System.out.printf("PROTEIN                        20%%                     4 %17.0f %15.0f %14.1f %12.1f %n",minRecProt,maxRecProt,minGramProt,maxGramProt);
        System.out.print("**********************************************************************************************************************");


        input.close();

















    }
}
