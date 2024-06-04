package Lab08;

public class projectSample {
    public static void main(String[] args) {
        Project first = new Project("Arctech", 450, 50, 10);
        System.out.println(first.toString());
        Project second = new Project("Sunmarket", 8750, 300, 10);
        System.out.println(second.toString());

        first.setPersonHours(4500);
        first.setRatePerHour(500);
        first.setProjectType();
        System.out.println(first.toString());

        second.deactivateProject();
        System.out.println(second.toString());

    }
    
}
