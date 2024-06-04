package Lab02;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class ReadWriteExample {
    public static void main(String[] args) {

        /*
         * READING FILE
         */

        // as reading a file involves first opening that file there can be exceptions
        // such exceptions should be handled in the code
        // (you will see more of this topic later in the course)
        // however, for now, just know that surrounding the part that can cause exceptions
        // with a try-catch block is one solution for the exceptions
        try {
            // create a new buffered reader with the given file to read its text
            // "sentences.txt" is the name of the file that is included in your project folder
            // you can also write the full path of the file
            BufferedReader reader = new BufferedReader(new FileReader(new File("sentences.txt")));
            
            // read the first line of the text into currentLine
            String currentLine = reader.readLine();

            // unless we encounter a null line
            while (currentLine != null) {

                // print the current line
                System.out.println(currentLine);

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

        /*
         * WRITING TO FILE
         */

        // similar to reading a file, writing to a file can cause exceptions
        // therefore we need to surround our code in a try-catch block
        try {
            // open the output writer
            FileWriter writer = new FileWriter("outpuFileName.txt");

            // write into file
            writer.write("Any string we want to include to the output file ");
            writer.write("can be send usign the write method. ");
            writer.write("If you need line breaks,\njust include them using the new line character.\n");
            writer.write("END OF TEXT");

            // in the end we need to close the file
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
