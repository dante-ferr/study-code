package company;

import java.util.ArrayList;

public class Company {
    private String name;
    private ArrayList<Employee> employees;
    private ArrayList<Payroll> payrolls;

    public Company(String name) {
        this.name = name;
        this.employees = new ArrayList<>();
        this.payrolls = new ArrayList<>();
    }

    public Company(String name, Employee[] employees) {
        this(name);
        
        for (Employee employee : employees) {
            this.addThirdPartyEmployee(employee);
        }
    }

    public void addOwnEmployee(String name, String id, String department, String role, float salary, Boolean ownEmployee) {
        var employee = new Employee(name, id, department, role, salary, ownEmployee);
        employees.add(employee);
    }

    public void addThirdPartyEmployee(Employee employee) {
        employees.add(employee);
    }

    public void createPayroll() {
        Employee[] clonedEmployees = employees
            .stream()
            .map(Employee::new)
            .toArray(Employee[]::new);

        payrolls.add(new Payroll(clonedEmployees));
    }

    public void listEmployeesFromDepartment(String department) {
        for (Employee employee : employees) {
            if (employee.getDepartment().equals(department)) {
                employee.printSelf();
            }
        }
    }

    public String getName() {
        return name;
    }

    public ArrayList<Payroll> getPayrolls() {
        return payrolls;
    }
}
