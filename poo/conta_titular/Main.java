package conta_titular;

public class Main {
    public static void main(String[] args) {
        Conta c1 = new Conta(1, new Person("Dante", "123.456.789-00", "Rua 1", "Blue"));

        System.out.println(c1.getNumber());
        System.out.println(c1.getHolders()[0].getName());

        Conta c2 = new Conta(2, new Person[] {
            new Person("André", "232.454.121-00", "Rua 2", "Ciano"),
            new Person("Guilherme", "578.340.210-00", "Rua 3", "Green")
        });

        System.out.println(c2.getNumber());
        System.out.println(c2.getHolders()[0].getName());
        System.out.println(c2.getHolders()[1].getName());
    }
}
