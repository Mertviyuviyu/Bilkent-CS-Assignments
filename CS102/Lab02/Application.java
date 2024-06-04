package Lab02;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

public class Application {
    public static void main(String[] args) {
        WordBag wb = new WordBag();
         try {
            BufferedReader reader = new BufferedReader(new FileReader(new File("sentences.txt")));
            String currentLine = reader.readLine();

            // unless we encounter a null line
            while (currentLine != null) {
                wb.processSentence(currentLine);
                // and get the next line
                currentLine = reader.readLine();
            }

        } catch (FileNotFoundException e) {
            // in case the file we provide cannot be found, this is the exception we get
            e.printStackTrace();
        } catch (IOException e) {
            // in case there is problem with reading the file, this is the exception we get
            e.printStackTrace();
        }
        System.out.println("Input file \"sentences.txt\" processed.");
        System.out.println();
        Scanner sc = new Scanner(System.in);
        int userChoice;
        do{
            System.out.println("1. Generate Sentence");
            System.out.println("2. Output Sentences to Text File");
            System.out.println("3. Exit");
            System.out.print("Please choose an option: ");
            userChoice = sc.nextInt();
            if(userChoice == 1){
                System.out.print("Soft Limit: ");
                int soft = sc.nextInt();

                System.out.print("Hard Limit: ");
                int hard  = sc.nextInt();

                String sent = wb.generateSentence(soft, hard);
                System.out.printf("Sentence: %s%n" , sent);
            }
            else if(userChoice == 2){
                System.out.print("File Name: ");
                String fileName = sc.next();
                sc.nextLine();

                System.out.print("Sentence Count: ");
                int sentCount = sc.nextInt();

                System.out.print("Soft Limit: ");
                int soft = sc.nextInt();


                System.out.print("Hard Limit: ");
                int hard  = sc.nextInt();
                System.out.println();

                wb.writeToTextFile(fileName, sentCount, soft, hard);
                System.out.println();

            }
            else{
                if(userChoice != 3){
                    System.out.println("You entered incorrect");
                }
            }

        }while(userChoice != 3);
        System.out.println("Goodbye!");
        sc.close();
        
    }
}
