package company;

public class Main {
    public static void main(String[] args) {
        System.out.println("--- Starting Employee Management ---");

        // 1. Employee creation and copy constructor
        Employee baseEmployee = new Employee("Alice Smith", "ID101", "IT", "Developer", 5000.0f, true);
        Employee clonedEmployee = new Employee(baseEmployee);

        System.out.println("Base Employee:");
        baseEmployee.printSelf();
        System.out.println("Cloned Employee:");
        clonedEmployee.printSelf();

        // 2. Company creation and adding initial employees
        Employee[] thirdPartyTeam = {
            new Employee("Bob Jones", "ID201", "Support", "Analyst", 3000.0f, false),
            new Employee("Charlie Brown", "ID202", "Support", "Specialist", 3500.0f, false)
        };
        Company myCompany = new Company("TechCorp", thirdPartyTeam);

        // 3. Adding own employees
        myCompany.addOwnEmployee("Diana Prince", "ID102", "IT", "Architect", 8000.0f, true);
        myCompany.addOwnEmployee("Edward Norton", "ID103", "HR", "Manager", 4500.0f, true);

        // 4. Adding a third-party employee
        Employee thirdPartyNew = new Employee("Fiona Gallagher", "ID203", "Cleaning", "Staff", 2000.0f, false);
        myCompany.addThirdPartyEmployee(thirdPartyNew);

        // 5. Listing employees from a department
        System.out.println("\n--- Employees from IT Department ---");
        myCompany.listEmployeesFromDepartment("IT");

        // 6. Creating a Payroll
        myCompany.createPayroll();
        
        // 7. Using Payroll functionalities
        System.out.println("\n--- Payroll Overview ---");
        var payrolls = myCompany.getPayrolls();
        if (!payrolls.isEmpty()) {
            Payroll currentPayroll = payrolls.get(0);
            
            System.out.println("Detailed Payroll:");
            currentPayroll.printSelf();

            System.out.println("\nTotal Gross Cost: " + currentPayroll.getGrossCost());

            Employee bestPaid = currentPayroll.higherSalaryEmployee();
            System.out.println("Employee with highest Net Salary:");
            bestPaid.printSelf();
        }

        System.out.println("\n--- End of Example ---");
    }
}
