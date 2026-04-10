public class Guarantor {
    private String name;
    private String cpf;
    private double monthlyIncome;

    public Guarantor(String name, String cpf, double monthlyIncome) {
        this.name = name;
        this.cpf = cpf;
        this.monthlyIncome = monthlyIncome;
    }

    public double getMonthlyIncome() {
        return monthlyIncome;
    }

    public void setMonthlyIncome(double monthlyIncome) {
        this.monthlyIncome = monthlyIncome;
    }
}
