package exception;

public class Main {
    public static void main(String[] args) {
        ParInpar parInpar = new ParInpar();
        try {
            parInpar.imprimePar(2);
        } catch (ExcecaoImpar e) {
            System.out.println(e.getMessage());
        }

        try {
            parInpar.imprimePar(3);
        } catch (ExcecaoImpar e) {
            System.out.println(e.getMessage());
        }

        try {
            Circulo circulo = new Circulo(-1, -1, -1);
        } catch (IllegalArgumentException e) {
            System.out.println(e.getMessage());
        }

        try {
            Circulo circulo = new Circulo(1, 1, 1);
        } catch (IllegalArgumentException e) {
            System.out.println(e.getMessage());
        }
    }
}
