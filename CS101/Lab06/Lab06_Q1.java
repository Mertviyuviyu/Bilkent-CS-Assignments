package Lab06;

import java.util.ArrayList;
import java.util.Random;


public class Lab06_Q1 {

    public static double calculateDistance(String loc1, String loc2){

        double distance;

        double x1 = Double.parseDouble(loc1.substring(0, loc1.indexOf(',')));
        double y1 = Double.parseDouble(loc1.substring(loc1.indexOf(',') + 1));

        double x2 = Double.parseDouble(loc2.substring(0, loc2.indexOf(',')));
        double y2 = Double.parseDouble(loc2.substring(loc2.indexOf(',') + 1));

        distance = Math.sqrt(Math.pow(x2-x1, 2)+Math.pow(y2-y1,2));
        return distance;
    }

    public static boolean doesIntersect(String loc1, String loc2){
        if(calculateDistance(loc1, loc2) <= 100){
            return true;
        }
        else{
            return false;
        }
    }
    public static int countIntersecting(String loc, ArrayList<String> locations){
        int count = 0;
        for(int i=0; i<locations.size();i++){
            if(doesIntersect(loc, locations.get(i)) && loc != locations.get(i)){
                count++;
            }
            
        }
        return count;
    }
    public static void displayIntersections(ArrayList<String> cats,ArrayList<String> locations,ArrayList<Integer> months){
        for (int i = 0; i<cats.size(); i++){
            String catName = cats.get(i);
            String catLoc = locations.get(i);
            int catMonth = months.get(i);
            System.out.printf("%s at location %s for %d months intersects with: ",catName,catLoc,catMonth);
            if(countIntersecting(catLoc, locations) == 0){
                System.out.println("NO CATS");
                System.out.println();
            }
            else{
                for (int k = 0; k < cats.size(); k++){
                    if(doesIntersect(catLoc, locations.get(k)) && catLoc != locations.get(k)){
                        System.out.printf("%n   %s, at location %s for %d months  ",cats.get(k),locations.get(k),months.get(k));
                    }
                }
                System.out.println();
                System.out.println();
            }
        
        }
    }
    public static int findMinMonthsAtLocation(String loc, ArrayList<String> locations,ArrayList<Integer> months){
        int index = 0;
        int minMonth = 1000;
        for (int i = 0; i<locations.size(); i++){
            if(doesIntersect(loc, locations.get(i)) && loc != locations.get(i)){
                if(months.get(i) < minMonth){
                    index = i;
                    minMonth = months.get(i);
                }
            }
        }
        return index;
    }
    public static String findRandomLocation(){
        Random rr = new Random();
        int randomX = rr.nextInt(500);
        int randomY = rr.nextInt(500);
        return randomX + "," + randomY;
    }
    public static void moveCats(ArrayList<String> locations,ArrayList<Integer> months){
        ArrayList<String> intersectLocs = new ArrayList<String>();    
        ArrayList<Integer> intersectMonths = new ArrayList<Integer>();

        for (int i=0; i < locations.size(); i++){
            if(countIntersecting(locations.get(i), locations) >= 2){
                intersectLocs.add(locations.get(i));
                intersectMonths.add(months.get(i));
            }
        }
        int moveIndex = findMinMonthsAtLocation(intersectLocs.get(0), intersectLocs, intersectMonths);
        int changeIn = locations.indexOf(intersectLocs.get(moveIndex));
        String newRandomPoint = findRandomLocation();
        locations.set(changeIn, findRandomLocation());
        while (countIntersecting(newRandomPoint, locations) != 0){
            newRandomPoint = findRandomLocation();
            locations.set(changeIn, findRandomLocation());
        }
    }
    public static int check(ArrayList<String> loc){
        int count = 0;
        for(int i=0; i < loc.size(); i++){
            if(countIntersecting(loc.get(i), loc) >= 2){
                count++;
            }
        }
        return count;
    }


    
    public static void main(String[] args) {
        ArrayList<String> catNames = new ArrayList<String>();
        ArrayList<String> catLocations = new ArrayList<String>();
        ArrayList<Integer> catMonths = new ArrayList<Integer>();

        catNames = CatInfoGenerator.getRandomNameList(10);
        catLocations = CatInfoGenerator.getRandomLocationList(10);
        catMonths = CatInfoGenerator.getRandomMonthList(10);
        
        displayIntersections(catNames, catLocations, catMonths);

        while(check(catLocations) != 0){
            moveCats(catLocations, catMonths);
        }

        System.out.println("After moving the cats: ");
        System.out.println();

        displayIntersections(catNames, catLocations, catMonths);
        
        
        
    }


}

