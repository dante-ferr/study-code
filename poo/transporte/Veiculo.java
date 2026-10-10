package transporte;

public abstract class Veiculo {
    private String marca;
    private String modelo;
    private int velMaxima;

    public Veiculo(String marca, String modelo, int velMaxima) {
        this.marca = marca;
        this.modelo = modelo;
        this.velMaxima = velMaxima;
    }
}
