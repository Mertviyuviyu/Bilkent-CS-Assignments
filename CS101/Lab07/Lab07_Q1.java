package Lab07;

import java.util.Scanner;

public class Lab07_Q1 {

    private static int[] arrival = { 9, 5, 8, 7, 9, 7, 8 };
    private static int[] departure = { 12, 7, 11, 12, 10, 9, 10 };
    private static String[] names = { "Ela", "Eren", "Alona", "Jen", "Mark", "Mel", "Ender" };

    public static int[] friendsAttending(int start, int finish) {
        int[] attendanceCount = new int[finish - start];
        for (int i = start; i < finish; i++) {
            int count = 0;
            for (int q = 0; q < names.length; q++) {
                if (arrival[q] <= i && departure[q] > i) {
                    count++;
                }
            }
            attendanceCount[i - start] = count;
        }
        return attendanceCount;
    }
    public static int bestTimeToAttend(int start,int finish,String avoid){
        int[] attendanceCount = friendsAttending(start, finish);
        int avoidIndex = -1;
        int count = 0;
        int indexOfBest = -1;
        int start2 = start;
        for(int i = 0; i < names.length; i++){
            if(avoid.equalsIgnoreCase(names[i])){
                avoidIndex = i;
            }
        }
        for(int i = 0; i < names.length; i++){
            if(arrival[avoidIndex] <= start && departure[avoidIndex] > start){
                attendanceCount[i] = -1;
            }
            start++;
        }
        for(int i = 0; i < attendanceCount.length; i++){
            if(attendanceCount[i] > count){
                count = attendanceCount[i];
                indexOfBest = i;
            }
        }
        if(indexOfBest == -1){
            return -1;
        }
        else{
            return indexOfBest + start2;
        }

    }

    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        System.out.println("1 - Friends Attending");
        System.out.println("2 - Best time to Attend");
        System.out.print("Choose (3 to quit): ");
        int userChoice = input.nextInt();
        System.out.println();

        while (userChoice != 3) {

            if (userChoice == 1) {
                System.out.print("Enter time interval you are available: ");
                int st = input.nextInt();
                int fin = input.nextInt();
                int count = 0;
                int index = -1;
                int st2 = st;
                int[] peopleCount = friendsAttending(st, fin);
                for (int i = 0; i < peopleCount.length; i++) {
                    System.out.printf("At %d pm, %d friends will be at the party %n", st, peopleCount[i]);
                    st++;
                    if (peopleCount[i] > count) {
                        count = peopleCount[i];
                        index = i;
                    }
                }
                index += st2;
                System.out.println("Best time to attend is: " + index);
            }


            if(userChoice == 2){
                System.out.print("Enter friend you wish to avoid: ");
                String avoidName = input.next();
                input.nextLine();
                System.out.print("Enter time interval you are available: ");
                int startTime = input.nextInt();
                int finishTime = input.nextInt(); 
                System.out.println("Best time to attend to avoid " + avoidName +  " and to see most friends is " + bestTimeToAttend(startTime, finishTime, avoidName));
            }

            System.out.println();
            System.out.println("1 - Friends Attending");
            System.out.println("2 - Best time to Attend");
            System.out.print("Choose (3 to quit): ");
            userChoice = input.nextInt();
            System.out.println();
        }
        System.out.println("Bye!");
        input.close();

    }
}
