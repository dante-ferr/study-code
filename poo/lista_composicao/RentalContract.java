public class RentalContract {
    private int number;
    private double rentValue;
    private int totalMonths;
    private int paidInstallments;
    private int lateInstallments;
    private double lateInterestRate;
    private int evictionMonthsThreshold;
    private boolean active;
    private Guarantor guarantor;

    public RentalContract(int number, double rentValue, int totalMonths, double lateInterestRate, int evictionMonthsThreshold, Guarantor guarantor) {
        this.number = number;
        this.rentValue = rentValue;
        this.totalMonths = totalMonths;
        this.lateInterestRate = lateInterestRate;
        this.evictionMonthsThreshold = evictionMonthsThreshold;
        setGuarantor(guarantor);
    }

    public double getBaseInstallment() {
        return rentValue;
    }

    public double getInstallmentWithLateFee() {
        return rentValue * (1 + lateInterestRate);
    }

    public void payBaseInstallment() {
        this.paidInstallments++;
    }

    public boolean shouldIssueEviction() {
        int remainingMonths = totalMonths - paidInstallments;
        if (remainingMonths <= 6) {
            return false;
        }
        return lateInstallments >= evictionMonthsThreshold;
    }

    public void changeGuarantorIncome(double newIncome) {
        if (guarantor != null) {
            guarantor.setMonthlyIncome(newIncome);
            updateStatus();
        }
    }

    public void setGuarantor(Guarantor guarantor) {
        this.guarantor = guarantor;
        updateStatus();
    }

    private void updateStatus() {
        this.active = (guarantor != null && guarantor.getMonthlyIncome() > 3 * rentValue);
    }
}
