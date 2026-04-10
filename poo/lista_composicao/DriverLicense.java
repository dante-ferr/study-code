public class DriverLicense {
    private String number;
    private boolean active;
    private char category;
    private int points;

    public DriverLicense(String number, char category) {
        this.number = number;
        this.category = category;
        this.active = true;
        this.points = 0;
    }

    public void addPoints(int points) {
        this.points += points;
        if (this.points > 30) {
            this.active = false;
        }
    }

    public void setCategory(char category) {
        this.category = category;
    }

    public int getPoints() {
        return this.points;
    }

    public boolean isActive() {
        return this.active;
    }
}
