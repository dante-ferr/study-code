package exception;

public class Circulo {
    int coordenadaX;
    int coordenadaY;
    int raio;

    public Circulo(int coordenadaX, int coordenadaY, int raio) {
        if (raio < 0) {
            throw new IllegalArgumentException("Raio não pode ser negativo");
        }
        if (raio == 0) {
            throw new IllegalArgumentException("Raio não pode ser zero");
        }
        if (coordenadaX < 0) {
            throw new IllegalArgumentException("Coordenada X não pode ser negativa");
        }
        if (coordenadaY < 0) {
            throw new IllegalArgumentException("Coordenada Y não pode ser negativa");
        }

        this.coordenadaX = coordenadaX;
        this.coordenadaY = coordenadaY;
        this.raio = raio;
    }
}
