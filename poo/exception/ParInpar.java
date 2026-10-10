package exception;

public class ParInpar {
    public void imprimePar(int numero) throws ExcecaoImpar {
        if (numero % 2 == 0) {
            System.out.println("Par");
        } else {
            throw new ExcecaoImpar();
        }
    }
}
