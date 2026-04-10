public class Comparison {
    private double value;

    public Comparison(double value) {
        this.value = value;
    }

    public boolean isEqual(double number) {
        return this.value == number;
    }

    public boolean isEqual(double number1, double number2) {
        return number1 == number2;
    }

    public boolean isLessThan(double number) {
        return number < this.value;
    }

    public boolean isGreater(double number1, double number2) {
        return number1 > number2;
    }
}
