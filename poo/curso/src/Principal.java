import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Principal {
    private static List<Curso> cursos = new ArrayList<>();
    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        int opcao = -1;
        while (opcao != 0) {
            System.out.println("\n--- MENU ---");
            System.out.println("1. Registrar Curso de Graduacao");
            System.out.println("2. Registrar Curso de Pos-Graduacao");
            System.out.println("3. Consultar Total de Disciplinas (Todos os Cursos)");
            System.out.println("4. Consultar Carga Horaria (Pos-Graduacoes)");
            System.out.println("5. Consultar Prazo Maximo de Extensao de um Curso");
            System.out.println("6. Exibir Detalhes de um Curso");
            System.out.println("7. Carregar Cursos de Teste");
            System.out.println("0. Sair");
            System.out.print("Escolha: ");
            try {
                opcao = Integer.parseInt(scanner.nextLine());
            } catch (Exception e) {
                System.out.println("Opcao invalida!");
                continue;
            }

            switch (opcao) {
                case 1:
                    registrarGraduacao();
                    break;
                case 2:
                    registrarPosGraduacao();
                    break;
                case 3:
                    consultarTotalDisciplinas();
                    break;
                case 4:
                    consultarCargaHorariaPos();
                    break;
                case 5:
                    consultarPrazoExtensao();
                    break;
                case 6:
                    exibirDetalhes();
                    break;
                case 7:
                    carregarMassaTestes();
                    break;
                case 0:
                    System.out.println("Sistema encerrado.");
                    break;
                default:
                    System.out.println("Opcao invalida!");
            }
        }
    }

    private static void registrarGraduacao() {
        System.out.print("Codigo: ");
        String codigo = scanner.nextLine();
        System.out.print("Nome: ");
        String nome = scanner.nextLine();
        System.out.print("Area: ");
        String area = scanner.nextLine();
        System.out.print("Disciplinas Obrigatorias: ");
        int ob = Integer.parseInt(scanner.nextLine());
        System.out.print("Disciplinas Optativas: ");
        int op = Integer.parseInt(scanner.nextLine());

        cursos.add(new Graduacao(codigo, nome, area, ob, op));
        System.out.println("Curso cadastrado!");
    }

    private static void registrarPosGraduacao() {
        System.out.print("Codigo: ");
        String codigo = scanner.nextLine();
        System.out.print("Nome: ");
        String nome = scanner.nextLine();
        System.out.print("Area: ");
        String area = scanner.nextLine();
        System.out.print("Disciplinas Obrigatorias: ");
        int ob = Integer.parseInt(scanner.nextLine());
        System.out.print("Disciplinas Optativas: ");
        int op = Integer.parseInt(scanner.nextLine());
        System.out.print("Nivel (Mestrado/Doutorado): ");
        String nivel = scanner.nextLine();
        System.out.print("Carga Horaria Total: ");
        int ch = Integer.parseInt(scanner.nextLine());

        cursos.add(new PosGraduacao(codigo, nome, area, ob, op, nivel, ch));
        System.out.println("Curso cadastrado!");
    }

    private static void consultarTotalDisciplinas() {
        System.out.println("\n--- Disciplinas por Curso ---");
        for (Curso c : cursos) {
            System.out.println("Curso: " + c.getNome() + " - Total de Disciplinas: " + c.getQuantidadeTotalDisciplinas());
        }
    }

    private static void consultarCargaHorariaPos() {
        System.out.println("\n--- Carga Horaria de Cursos de Pos ---");
        for (Curso c : cursos) {
            if (c instanceof PosGraduacao) {
                PosGraduacao pos = (PosGraduacao) c;
                System.out.println("Curso: " + pos.getNome() + " - Carga Horaria: " + pos.getCargaHorariaTotal() + " horas");
            }
        }
    }

    private static void consultarPrazoExtensao() {
        System.out.print("Codigo do curso: ");
        String codigo = scanner.nextLine();
        Curso c = buscarCurso(codigo);
        if (c != null) {
            System.out.println("Curso: " + c.getNome());
            System.out.println("Prazo Maximo de Extensao: " + c.getPrazoExtensaoMaximo() + " anos");
        } else {
            System.out.println("Curso nao encontrado!");
        }
    }

    private static void exibirDetalhes() {
        System.out.print("Codigo do curso: ");
        String codigo = scanner.nextLine();
        Curso c = buscarCurso(codigo);
        if (c != null) {
            c.exibirDetalhes();
        } else {
            System.out.println("Curso nao encontrado!");
        }
    }

    private static void carregarMassaTestes() {
        cursos.add(new Graduacao("CC", "Ciencia da Computacao", "Exatas", 28, 6));
        cursos.add(new PosGraduacao("MIA", "Mestrado em IA", "Tecnologia", 8, 4, "Mestrado", 360));
        cursos.add(new PosGraduacao("DCD", "Doutorado em Ciencia de Dados", "Tecnologia", 12, 6, "Doutorado", 720));
        System.out.println("Massa de testes carregada!");
    }

    private static Curso buscarCurso(String codigo) {
        for (Curso c : cursos) {
            if (c.getCodigo().equalsIgnoreCase(codigo)) {
                return c;
            }
        }
        return null;
    }
}
