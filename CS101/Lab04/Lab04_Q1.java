package Lab04;

import java.util.Scanner;

public class Lab04_Q1 {
    public static void main(String[] args) {
        int min;
        int max;
        double sameRate;

        Scanner input = new Scanner(System.in);
        do {
            System.out.print("Enter the minimum and maximum number of people: ");
            min = input.nextInt();
            max = input.nextInt();
            if (max <= min) {
                System.out.println("Invalid input - minimum must be less than maximum...");
            }
        } while (max <= min);

        double r = min;
        System.out.println("NUMBER OF PEOPLE         PROBABILITY");
        do {
            sameRate = 1;
            for (double i = 0; i < r; i++) {
                sameRate *= (365.0 - i) / 365.0;
            }
            sameRate = 1 - sameRate;
            System.out.printf("%.0f                       %.3f %n", r, sameRate);
            r++;
        } while (r <= max);

        input.close();

    }
}
