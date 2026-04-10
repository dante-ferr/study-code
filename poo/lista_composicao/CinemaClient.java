public class CinemaClient {
    private String name;
    private int age;

    public CinemaClient(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public double calculateTicketValue(String dayOfWeek) {
        String day = dayOfWeek.toLowerCase();
        if (age < 14 || age > 65 || day.equals("wednesday") || day.equals("thursday")) {
            return 8.0;
        }
        return 16.0;
    }
}
