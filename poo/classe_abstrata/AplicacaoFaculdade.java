public class AplicacaoFaculdade {
    public Graduacao criarCursoGraduacao(String codigo, String nome, String area, int numeroVagas, double taxaMatricula, int disciplinasObrigatorias, int disciplinasOptativas) {
        return new Graduacao(codigo, nome, area, numeroVagas, taxaMatricula, disciplinasObrigatorias, disciplinasOptativas);
    }

    public PosGraduacao criarCursoPosGraduacao(String codigo, String nome, String area, int numeroVagas, double taxaMatricula, int cargaHorariaMaxima) {
        return new PosGraduacao(codigo, nome, area, numeroVagas, taxaMatricula, cargaHorariaMaxima);
    }

    public void consultarInformacoes(Curso curso) {
        if (curso instanceof Graduacao) {
            Graduacao grad = (Graduacao) curso;
            System.out.println("Nome do curso: " + grad.getNome());
            System.out.println("Total de disciplinas: " + grad.getCargaTotalDisciplinas());
        } else if (curso instanceof PosGraduacao) {
            PosGraduacao pos = (PosGraduacao) curso;
            System.out.println("Nome do curso: " + pos.getNome());
            System.out.println("Carga horária máxima: " + pos.getCargaHorariaMaxima() + " horas");
        }
    }
}
