package company;

public class Employee {
    private String name;
    private String id;
    private String department;
    private String role;
    private float grossSalary;
    private Boolean ownEmployee;

    public Employee(String name, String id, String department, String role, float grossSalary, Boolean ownEmployee) {
        this.name = name;
        this.id = id;
        this.department = department;
        this.role = role;
        this.grossSalary = grossSalary;
        this.ownEmployee = ownEmployee;
    }

    public Employee(Employee other) {
        this.name = other.getName();
        this.id = other.getId();
        this.department = other.getDepartment();
        this.role = other.getRole();
        this.grossSalary = other.getGrossSalary();
        this.ownEmployee = other.getOwnEmployee();
    }

    public void printSelf() {
        System.out.println(
            "Name: " + getName() + "; " +
            "Department: " + getDepartment() + " " +
            "Role: " + getRole() + " " +
            "Is Own Employee: " + getOwnEmployee() + " " +
            "Gross Salary: " + getGrossSalary() + " " +
            "Net Salary: " + getNetSalary());
    }

    public String getName() {
        return name;
    }

    public String getId() {
        return id;
    }

    public String getDepartment() {
        return department;
    }

    public String getRole() {
        return role;
    }

    public float getGrossSalary() {
        return grossSalary;
    }

    public float getNetSalary() {
        return ownEmployee ? (float) (grossSalary * 0.9) : (float) (grossSalary * 0.92);
    }

    public Boolean getOwnEmployee() {
        return ownEmployee;
    }
}
