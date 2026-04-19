package moradia;

import java.util.Map;

public class Property {
    private double maxDailyCharge;
    private double condominiumFee;
    private double iptuFee;
    private char category;
    private int amountOfBedrooms;

    public static final Map<Character, Double> FCATS =
            Map.of('A', 0.2, 'B', 0.4, 'C', 0.5, 'D', 0.7, 'E', 0.8, 'F', 0.9, 'G', 1.0);

    public static final Map<Integer, Double> FQTOS = Map.of(1, 1.0, 2, 1.5, 3, 2.0, 4, 2.5, 5, 3.0);

    public Property(double maxDailyCharge, double condominiumFee, double iptuFee, char category,
            int amountOfBedrooms) {
        this.maxDailyCharge = maxDailyCharge;
        this.condominiumFee = condominiumFee;
        this.iptuFee = iptuFee;
        this.category = category;
        this.amountOfBedrooms = amountOfBedrooms;
    }

    public double getMaxDailyCharge() {
        return maxDailyCharge;
    }

    public double getCondominiumFee() {
        return condominiumFee;
    }

    public double getIptuFee() {
        return iptuFee;
    }

    public char getCategory() {
        return category;
    }

    public double getFcat() {
        return FCATS.get(category);
    }

    public double getFqto() {
        if (amountOfBedrooms > 5) {
            return FQTOS.get(5);
        }
        return FQTOS.get(amountOfBedrooms);
    }
}
