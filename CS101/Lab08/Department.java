package Lab08;

public class Department {
    
    private String deptName;
    private String deptCode;

    public Department(String deptName, String deptCode){
        this.deptName = deptName;
        this.deptCode = deptCode;
    }
    public String getDeptName(){
        return this.deptName;
    }
    public String getDeptCode(){
        return this.deptCode;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        Department otherDept = (Department) obj;
        return deptCode.equals(otherDept.deptCode) && deptName.equals(otherDept.deptName);
    }
    public String toString() {
        String str = "Department Name: " + deptName + "  " + "Department Code: " + deptCode;
        return str;
    }

}
