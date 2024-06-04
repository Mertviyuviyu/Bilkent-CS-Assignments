package Lab08;

public class Project {
    private static final double TAX_RATE = 0.13;
    private static final int OVERHEAD = 50000;
    private static final int EMP_HOURS_WEEK = 45;

    private static int projectCounter = 5000;
    private static int currentYear = 2023;


    private String projectId;
    private String projectName;
    private char projectType;
    private double personHours;
    private double ratePerHour;
    private int projectWeeks;

    public Project(String projectName, double personHours, double ratePerHour, int projectWeeks) {
        this.projectName = projectName;
        setPersonHours(personHours);
        setRatePerHour(ratePerHour);
        setProjectWeeks(projectWeeks);
        setProjectId();
        setProjectType();
        projectCounter++;
    }

    public String getProjectName() {
        return projectName;
    }

    public String getProjectId() {
        return projectId;
    }

    public char getProjectType() {
        return projectType;
    }

    public double getPersonHours() {
        return personHours;
    }

    public double getRatePerHour() {
        return ratePerHour;
    }

    public int getProjectWeeks() {
        return projectWeeks;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }
    public void setPersonHours(double hour){
        if(hour >= 0){
            this.personHours = hour;
        }
        else{
            this.personHours = 0;
        }
    }
    public void setRatePerHour(double rate){
        if(rate >= 0){
            this.ratePerHour = rate;
        }
        else{
            this.ratePerHour = 0;
        }
    }
    public void setProjectWeeks(int week){
        if(week >= 0){
            this.projectWeeks = week;
        }
        else{
            this.projectWeeks = 0;
        }
    }
    private void setProjectId(){
        this.projectId = currentYear + "-" + projectCounter;
    }
    public void setProjectType(){
        double projectCost = calculateProjectCost();
        if(projectCost >= 1000000){
            this.projectType = 'm';
        }
        else if(projectCost >= 500000 && projectCost < 1000000){
            this.projectType = 'l';
        }
        else if(projectCost > 0 && projectCost < 500000){
            this.projectType = 's';
        }
        else{
            this.projectType = 'i';
        }
    }

    public void deactivateProject(){
        this.personHours = 0;
        this.ratePerHour = 0;
        setProjectType();
    }
    public void activateProject(double hour, double rate){
        this.personHours = hour;
        this.ratePerHour = rate;
        setProjectType();
    }
    public double calculateProjectCost(){
        double cost = 0;
        cost = this.ratePerHour * this.personHours;
        if(cost >= 20000){
            cost += OVERHEAD;
        }
        cost += cost * TAX_RATE;
        return cost;
    }
    public int calculatePersonResources(){
        int workerHour = projectWeeks * EMP_HOURS_WEEK;
        return (int) personHours / workerHour;
    }
    public String toString(){
        if (projectType == 'i') {
            return "-------INACTIVE PROJECT------\n" + "Project Name: " + projectName + "\n" + "Project ID: " + projectId + "\n";
        }
        else{
            return "Project Name: " + projectName + "\n" + "Project ID: " + projectId + "\n" + "Project Type: " + projectType + "\n" + "Team Size: " + calculatePersonResources() + "\n" + "Estimated Project Cost: " + calculateProjectCost() + "\n";
        }
    }
    







}
