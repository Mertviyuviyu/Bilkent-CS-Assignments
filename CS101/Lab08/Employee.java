package Lab08;

public class Employee {
    private static final int WORKING_DAYS = 261;

    private String employeeName;
    private double dailyRate;
    private Department department;
    private Project project;

    public Employee(String employeeName, double dailyRate, String deptName, String deptCode, Project project) {
        this.employeeName = employeeName;
        this.dailyRate = dailyRate;
        this.department = new Department(deptName, deptCode);
        this.project = project;
    }
    public Employee(Employee other) {
        this.employeeName = other.employeeName;
        this.dailyRate = other.dailyRate;
        this.department = other.department;
        this.project = other.project;
    }

    public void setEmployeeName(String employeeName){
        this.employeeName = employeeName;
    }
    public void setDailyRate(double dailyRate){
        this.dailyRate = dailyRate;
    }
    public void setDepartment(Department department){
        this.department = department;
    }
    public void setProject(Project project){
        this.project = project;
    }

    public String getEmployeeName() {
        return employeeName;
    }
    public double getDailyRate() {
        return dailyRate;
    }
    public Department getDepartment() {
        return department;
    }
    public Project getProject() {
        return project;
    }

    public double calculateYearlySalary() {
        return dailyRate * WORKING_DAYS;
    }

    public String toString() {
        return "Employee Name: " + employeeName + " " +
                "Yearly Salary: " + calculateYearlySalary() + "\n" +
                "DeptName: " + department.getDeptName() + " " +
                "Dept Code: " + department.getDeptCode();
                
    }


}
