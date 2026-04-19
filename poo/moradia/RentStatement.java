package moradia;

import java.util.ArrayList;
import java.util.List;

public class RentStatement {
    private String tenantAddress;
    private String landlordAddress;
    private Rent rent;
    private List<StatementLine> lines;

    public RentStatement(String tenantAddress, String landlordAddress, Rent rent) {
        this.tenantAddress = tenantAddress;
        this.landlordAddress = landlordAddress;
        this.rent = rent;
        this.lines = new ArrayList<>();
        buildStatement();
    }

    private void buildStatement() {
        Property property = rent.getProperty();
        char category = property.getCategory();

        double baseRent = rent.getDailyCharge() * rent.getDurationDays() * property.getFcat()
                * property.getFqto();
        lines.add(new StatementLine("Gross Rent", baseRent));

        if (category != 'A' && category != 'C') {
            lines.add(new StatementLine("IPTU", property.getIptuFee()));
        }

        if (category != 'A' && category != 'B') {
            lines.add(new StatementLine("Condominium", property.getCondominiumFee()));
        }
    }

    public List<StatementLine> getLines() {
        return lines;
    }

    public String getSummary() {
        return String.format(
                "Total Contract Value: R$ %.2f\nMonthly Equivalent Cost: R$ %.2f\nMonthly Cost Per Resident: R$ %.2f",
                rent.getTotalCost(), rent.getMonthlyEquivalentCost(),
                rent.getMonthlyCostPerResident());
    }

    public String getTenantAddress() {
        return tenantAddress;
    }

    public String getLandlordAddress() {
        return landlordAddress;
    }
}
