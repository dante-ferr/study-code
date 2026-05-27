public class Graduacao extends Curso {
    private int disciplinasObrigatorias;
    private int disciplinasOptativas;

    public Graduacao(String codigo, String nome, String area, int numeroVagas, double taxaMatricula, int disciplinasObrigatorias, int disciplinasOptativas) {
        super(codigo, nome, area, numeroVagas, taxaMatricula);
        this.disciplinasObrigatorias = disciplinasObrigatorias;
        this.disciplinasOptativas = disciplinasOptativas;
    }

    public int getDisciplinasObrigatorias() {
        return disciplinasObrigatorias;
    }

    public void setDisciplinasObrigatorias(int disciplinasObrigatorias) {
        this.disciplinasObrigatorias = disciplinasObrigatorias;
    }

    public int getDisciplinasOptativas() {
        return disciplinasOptativas;
    }

    public void setDisciplinasOptativas(int disciplinasOptativas) {
        this.disciplinasOptativas = disciplinasOptativas;
    }

    public int getCargaTotalDisciplinas() {
        return disciplinasObrigatorias + disciplinasOptativas;
    }

    @Override
    public double calcularPreco(boolean antesMatricula, boolean temConvenio) {
        double desconto = 0.0;
        if (antesMatricula) {
            desconto += 0.10;
        }
        if (temConvenio) {
            desconto += 0.06;
        }
        return taxaMatricula * (1.0 - desconto);
    }
}
