public abstract class Curso {
    private String codigo;
    private String nome;
    private String area;
    private int disciplinasObrigatorias;
    private int disciplinasOptativas;

    public Curso(String codigo, String nome, String area, int disciplinasObrigatorias, int disciplinasOptativas) {
        this.codigo = codigo;
        this.nome = nome;
        this.area = area;
        this.disciplinasObrigatorias = disciplinasObrigatorias;
        this.disciplinasOptativas = disciplinasOptativas;
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

    public int getQuantidadeTotalDisciplinas() {
        return disciplinasObrigatorias + disciplinasOptativas;
    }

    public abstract double getPrazoExtensaoMaximo();

    public abstract void exibirDetalhes();
}
