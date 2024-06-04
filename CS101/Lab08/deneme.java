package Lab08;

import java.util.ArrayList;

public class deneme {

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

        ArrayList<Employee> employees = new ArrayList<Employee>();
        employees.add(emp1);
        employees.add(emp2);
        employees.add(emp3);
        employees.add(emp4);

        int matchCount = 1;
        for (int i = 0; i < employees.size(); i++) {
            for (int j = i + 1; j < employees.size(); j++) {
                Employee employee1 = employees.get(i);
                Employee employee2 = employees.get(j);
                if (employee1.getDepartment().equals(employee2.getDepartment())) {
                    System.out.printf("Employees with matching Departments (%d) %n",matchCount);
                    System.out.println("------------------------------------------------");
                    System.out.println(employee1);
                    System.out.println(pj1);
                    System.out.println(employee2);
                    System.out.println(pj1);
                    matchCount++;
                }
            }
        }
    }
    
}
