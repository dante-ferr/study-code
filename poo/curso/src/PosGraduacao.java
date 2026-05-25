public class PosGraduacao extends Curso {
    private String nivel;
    private int cargaHorariaTotal;

    public PosGraduacao(String codigo, String nome, String area, int disciplinasObrigatorias, 
                        int disciplinasOptativas, String nivel, int cargaHorariaTotal) {
        super(codigo, nome, area, disciplinasObrigatorias, disciplinasOptativas);
        this.nivel = nivel;
        this.cargaHorariaTotal = cargaHorariaTotal;
    }

    public String getNivel() {
        return nivel;
    }

    public void setNivel(String nivel) {
        this.nivel = nivel;
    }

    public int getCargaHorariaTotal() {
        return cargaHorariaTotal;
    }

    public void setCargaHorariaTotal(int cargaHorariaTotal) {
        this.cargaHorariaTotal = cargaHorariaTotal;
    }

    @Override
    public double getPrazoExtensaoMaximo() {
        if (nivel.equalsIgnoreCase("Mestrado")) {
            return 1.0;
        } else if (nivel.equalsIgnoreCase("Doutorado")) {
            return 1.5;
        }
        return 0.0;
    }

    @Override
    public void exibirDetalhes() {
        System.out.println("--- Detalhes do Curso de Pos-Graduacao ---");
        System.out.println("Codigo: " + getCodigo());
        System.out.println("Nome: " + getNome());
        System.out.println("Area: " + getArea());
        System.out.println("Nivel: " + nivel);
        System.out.println("Carga Horaria Total: " + cargaHorariaTotal + " horas");
        System.out.println("Disciplinas Obrigatorias: " + getDisciplinasObrigatorias());
        System.out.println("Disciplinas Optativas: " + getDisciplinasOptativas());
        System.out.println("Total de Disciplinas: " + getQuantidadeTotalDisciplinas());
        System.out.println("Prazo Maximo de Extensao: " + getPrazoExtensaoMaximo() + " anos");
    }
}
