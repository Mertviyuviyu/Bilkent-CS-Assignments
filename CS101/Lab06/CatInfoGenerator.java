package Lab06;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;

public class CatInfoGenerator {
    private static final int CAMPUS_RADIUS = 250;
    private static final int MAX_MONTHS = 60;
    private static String[] arrayOfNames = {"Gollum","Spiderman","Mocha","Gora","Zeytin","Spot","Pamuk","Duman","Pasha","Tickles","Kahve","Tekir","Benek","Checkers", "Karamel","Tik Tak", "Havuç", "Blizzard", "Splatter", "Sprite","Hamur","Pofuduk","Popsicle","Ash","Gofret","Latte","Aslan","Patches","Lucky","Fluffy"};
    private static ArrayList<String> catNames = new ArrayList<String>( Arrays.asList( arrayOfNames ));
    

    public static ArrayList<String> getRandomNameList( int num ){
       /*Implement the method here.....
	    * The method should add num random names from the global static catNames list to a new ArrayList and 
		* return the random list of names. There should be no duplicates, and you should make sure that num is 
		* less than the number of names in the catNames list, if not, num should be set to the size of the 
		* catNames list.*/
		
        Random rr = new Random();
        ArrayList<String> randomCat = new ArrayList<>();
        num = Math.min(num, catNames.size());

        int i = 0;
        while(i<num){
            int rand = rr.nextInt(catNames.size());
            String name = catNames.get(rand);
            if(!randomCat.contains(name)){
                randomCat.add(name);
                i++;
            }
        }

        return randomCat;
    }
	
    public static ArrayList<String> getRandomLocationList( int num ){
        ArrayList<String> randomLocations = new ArrayList<String>();
        int randX;
        int randY;

        Random rand = new Random();
        int locCount = 0; //name counter

        while (  locCount < num ){    
            randX = rand.nextInt( CAMPUS_RADIUS * 2 );
            randY = rand.nextInt( CAMPUS_RADIUS * 2 );
            //if name not already added to list
            if( Math.sqrt( Math.pow(randX,2) + Math.pow(randY,2)) <= CAMPUS_RADIUS * 2 ){
                randomLocations.add( randX + "," + randY );
                locCount++;
            }
        }
        return randomLocations;
    }
    public static ArrayList<Integer> getRandomMonthList( int num ){
        ArrayList<Integer> randomMonths = new ArrayList<Integer>();
        int month;
    
        Random rand = new Random();

        for ( int i = 0; i < num; i++ ){    
            month = rand.nextInt( MAX_MONTHS );
            randomMonths.add( month );
        }
        return randomMonths;
    }
}
