public class Beneficiary {
    String name;
    String rg;
    String cpf;
    String propertyType;
    double propertySize;
    double income;
    String benefits;
    double iptuDebts;

    public Beneficiary(String name, String rg) {
        this.name = name;
        this.rg = rg;
    }

    public Beneficiary(String name, String rg, String cpf, String propertyType, double propertySize, double income, String benefits, double iptuDebts) {
        this.name = name;
        this.rg = rg;
        this.cpf = cpf;
        this.propertyType = propertyType;
        this.propertySize = propertySize;
        this.income = income;
        this.benefits = benefits;
        this.iptuDebts = iptuDebts;
    }

    public double calculateDebt() {
        if (propertyType.equalsIgnoreCase("Casa")) return propertySize * 5.976;
        if (propertyType.equalsIgnoreCase("Apartamento")) return propertySize * 7.298;
        return propertySize * 9.858;
    }

    public double calculateFinalIptu(int yearsLiving, boolean servedState, double minimumWage) {
        double debt = calculateDebt();
        double exemption = 0.09;

        if (yearsLiving > 10) {
            exemption = 1.0;
        } else if (servedState) {
            exemption = 0.40;
        } else if (income < minimumWage) {
            exemption = 0.25;
        } else if (income == minimumWage) {
            exemption = 0.17;
        }

        return debt - (debt * exemption);
    }

    public static void main(String[] args) {
        Beneficiary p1 = new Beneficiary("Person A", "12345678");
        Beneficiary p2 = new Beneficiary("Person B", "87654321", "00011122233", "Casa", 120.0, 1300.0, "None", 0.0);

        double baseDebt = p2.calculateDebt();
        double finalValue = p2.calculateFinalIptu(5, false, 1412.0);

        System.out.printf("Base Debt: R$ %.2f\n", baseDebt);
        System.out.printf("Final IPTU: R$ %.2f\n", finalValue);
    }
}