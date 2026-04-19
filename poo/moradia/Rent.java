package moradia;

public class Rent {
    private Property property;
    private int durationDays;
    private int residents;

    public Rent(Property property, int durationDays, int residents) {
        this.property = property;
        this.durationDays = durationDays;
        this.residents = residents;
    }

    public double getDailyCharge() {
        if (durationDays >= 360) {
            return property.getMaxDailyCharge() * 0.9;
        }
        if (durationDays >= 180) {
            return property.getMaxDailyCharge() * 0.95;
        }
        return property.getMaxDailyCharge();
    }

    private double getCost(int days) {
        var iptuFee = property.getIptuFee();
        var condominiumFee = property.getCondominiumFee();

        if (property.getCategory() == 'A') {
            iptuFee = 0;
            condominiumFee = 0;
        } else if (property.getCategory() == 'B') {
            condominiumFee = 0;
        } else if (property.getCategory() == 'C') {
            iptuFee = 0;
        }

        return getDailyCharge() * days * property.getFcat() * property.getFqto() + iptuFee
                + condominiumFee;
    }

    public double getTotalCost() {
        return getCost(durationDays);
    }

    public double getMonthlyEquivalentCost() {
        double months = durationDays / 30.0;
        return getTotalCost() / months;
    }

    public double getMonthlyCostPerResident() {
        return getMonthlyEquivalentCost() / residents;
    }

    public Property getProperty() {
        return property;
    }

    public int getDurationDays() {
        return durationDays;
    }
}
