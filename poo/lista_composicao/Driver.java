public class Driver {
    private String name;
    private String id;
    private DriverLicense license;

    public Driver(String name, String id) {
        this.name = name;
        this.id = id;
    }

    public Driver(String name, String id, DriverLicense license) {
        this.name = name;
        this.id = id;
        this.license = license;
    }

    public Driver(String name, String id, String licenseNumber, char category) {
        this.name = name;
        this.id = id;
        this.license = new DriverLicense(licenseNumber, category);
    }

    public void changeCategory(char newCategory) {
        if (license != null) license.setCategory(newCategory);
    }

    public void addPoints(int points) {
        if (license != null) license.addPoints(points);
    }

    public int getPoints() {
        return license != null ? license.getPoints() : 0;
    }

    public boolean isLicenseCanceled() {
        return license != null && !license.isActive();
    }
}
