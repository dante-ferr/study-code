package company;

public class Payroll {
    private Employee[] employees;

    public Payroll(Employee[] employees) {
        this.employees = employees;
    }

    public Employee higherSalaryEmployee() {
        Employee higherSalaryEmployee = employees[0];
        for (int i = 1; i < employees.length; i++) {
            if (employees[i].getNetSalary() > higherSalaryEmployee.getNetSalary()) {
                higherSalaryEmployee = employees[i];
            }
        }
        return higherSalaryEmployee;
    }

    public float getGrossCost() {
        float grossCost = 0;
        for (int i = 0; i < employees.length; i++) {
            grossCost += employees[i].getGrossSalary();
        }
        return grossCost;
    }

    public void printSelf() {
        for (int i = 0; i < employees.length; i++) {
            employees[i].printSelf();
        }
    }
}
