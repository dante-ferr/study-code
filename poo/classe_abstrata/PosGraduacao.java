public class PosGraduacao extends Curso {
    private int cargaHorariaMaxima;

    public PosGraduacao(String codigo, String nome, String area, int numeroVagas, double taxaMatricula, int cargaHorariaMaxima) {
        super(codigo, nome, area, numeroVagas, taxaMatricula);
        this.cargaHorariaMaxima = cargaHorariaMaxima;
    }

    public int getCargaHorariaMaxima() {
        return cargaHorariaMaxima;
    }

    public void setCargaHorariaMaxima(int cargaHorariaMaxima) {
        this.cargaHorariaMaxima = cargaHorariaMaxima;
    }

    @Override
    public double calcularPreco(boolean antesMatricula, boolean temConvenio) {
        double desconto = 0.0;
        if (antesMatricula) {
            desconto += 0.05;
        }
        if (temConvenio) {
            desconto += 0.05;
        }
        return taxaMatricula * (1.0 - desconto);
    }
}
