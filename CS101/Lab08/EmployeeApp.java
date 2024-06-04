package Lab08;

public class EmployeeApp {
    public static void main(String[] args) {
        Project pj1 = new Project("Sunmarket", 450, 50, 10);

        Employee emp1 = new Employee("Zana Karakus", 55, "Information Technology", "IT", pj1);
        Employee emp2 = new Employee("Denis Rocca", 70, "Human Resources", "HR", pj1);
        Employee emp3 = new Employee("Jamie Anders", 40, "Human Resources", "HR", pj1);
        Employee emp4 = new Employee(emp1);

        System.out.println("Employees:");
        System.out.println(emp1);
        System.out.println(pj1);
        System.out.println(emp2);
        System.out.println(pj1);
        System.out.println(emp3);
        System.out.println(pj1);
        System.out.println(emp4);
        System.out.println(pj1);

        System.out.println("----------end employee list---------");
        System.out.println();

        System.out.println("Employees with Matching Departments (1) ");

        if(emp1.getDepartment().equals(emp4.getDepartment())){
            System.out.println(emp1);
            System.out.println(pj1);
            System.out.println(emp4);
            System.out.println(pj1);
        }

        System.out.println("Employees with Matching Departments (2) ");
        if(emp2.getDepartment().equals(emp3.getDepartment())){
            System.out.println(emp2);
            System.out.println(pj1);
            System.out.println(emp3);
            System.out.println(pj1);
        }

    }
}
