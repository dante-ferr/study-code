public class Graduacao extends Curso {

    public Graduacao(String codigo, String nome, String area, int disciplinasObrigatorias, int disciplinasOptativas) {
        super(codigo, nome, area, disciplinasObrigatorias, disciplinasOptativas);
    }

    @Override
    public double getPrazoExtensaoMaximo() {
        return 2.0;
    }

    @Override
    public void exibirDetalhes() {
        System.out.println("--- Detalhes do Curso de Graduacao ---");
        System.out.println("Codigo: " + getCodigo());
        System.out.println("Nome: " + getNome());
        System.out.println("Area: " + getArea());
        System.out.println("Disciplinas Obrigatorias: " + getDisciplinasObrigatorias());
        System.out.println("Disciplinas Optativas: " + getDisciplinasOptativas());
        System.out.println("Total de Disciplinas: " + getQuantidadeTotalDisciplinas());
        System.out.println("Prazo Maximo de Extensao: " + getPrazoExtensaoMaximo() + " anos");
    }
}
