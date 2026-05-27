public abstract class Curso {
    protected String codigo;
    protected String nome;
    protected String area;
    protected int numeroVagas;
    protected double taxaMatricula;

    public Curso(String codigo, String nome, String area, int numeroVagas, double taxaMatricula) {
        this.codigo = codigo;
        this.nome = nome;
        this.area = area;
        this.numeroVagas = numeroVagas;
        this.taxaMatricula = taxaMatricula;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public int getNumeroVagas() {
        return numeroVagas;
    }

    public void setNumeroVagas(int numeroVagas) {
        this.numeroVagas = numeroVagas;
    }

    public double getTaxaMatricula() {
        return taxaMatricula;
    }

    public void setTaxaMatricula(double taxaMatricula) {
        this.taxaMatricula = taxaMatricula;
    }

    public abstract double calcularPreco(boolean antesMatricula, boolean temConvenio);
}
