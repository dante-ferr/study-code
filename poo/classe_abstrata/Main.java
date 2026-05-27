public class Main {
    public static void main(String[] args) {
        System.out.println("=== TESTE DO SISTEMA BANCARIO ===");

        ContaCorrente cc = new ContaCorrente("Ana Silva", "1234-5", 1000.0);
        System.out.println("Conta Corrente criada para: " + cc.getTitular() + " | Saldo inicial: R$" + cc.getSaldo());
        
        cc.depositar(500.0);
        System.out.println("Deposito de R$500 realizado. Saldo: R$" + cc.getSaldo());
        
        boolean saqueCC1 = cc.sacar(1200.0);
        System.out.println("Tentativa de saque de R$1200. Sucesso? " + saqueCC1 + " | Saldo: R$" + cc.getSaldo());
        
        boolean saqueCC2 = cc.sacar(300.0);
        System.out.println("Tentativa de saque de R$300. Sucesso? " + saqueCC2 + " | Saldo: R$" + cc.getSaldo());

        System.out.println();

        ContaEspecial ce = new ContaEspecial("Bruno Souza", "5432-1", 500.0, 25.0, 1000.0);
        System.out.println("Conta Especial criada para: " + ce.getTitular() + " | Saldo: R$" + ce.getSaldo() + " | Limite: R$" + ce.getLimite() + " | Taxa mensal: R$" + ce.getTaxaDebitoMensal());
        
        boolean saqueCE1 = ce.sacar(1200.0);
        System.out.println("Tentativa de saque de R$1200 (usa saldo + limite). Sucesso? " + saqueCE1 + " | Saldo: R$" + ce.getSaldo());
        
        ce.cobrarTaxaMensal();
        System.out.println("Taxa mensal cobrada. Saldo: R$" + ce.getSaldo());
        
        boolean saqueCE2 = ce.sacar(500.0);
        System.out.println("Tentativa de saque de R$500. Sucesso? " + saqueCE2 + " | Saldo: R$" + ce.getSaldo());

        System.out.println();

        ContaPoupanca cp = new ContaPoupanca("Carla Dias", "9876-5", 2000.0, 0.005);
        System.out.println("Conta Poupanca criada para: " + cp.getTitular() + " | Saldo: R$" + cp.getSaldo() + " | Taxa de rendimento: " + (cp.getRendimentoMensal() * 100) + "%");
        
        cp.creditarRendimento();
        System.out.println("Rendimento creditado. Saldo: R$" + cp.getSaldo());
        
        boolean saqueCP = cp.sacar(500.0);
        System.out.println("Tentativa de saque de R$500. Sucesso? " + saqueCP + " | Saldo: R$" + cp.getSaldo());

        System.out.println("\n=== TESTE DO SISTEMA DA FACULDADE ===");

        AplicacaoFaculdade app = new AplicacaoFaculdade();

        Graduacao grad = app.criarCursoGraduacao("G01", "Bacharelado em Ciencia da Computacao", "Exatas", 40, 1200.0, 30, 10);
        System.out.println("Curso de Graduacao criado com sucesso.");
        
        PosGraduacao pos = app.criarCursoPosGraduacao("P01", "Mestrado em Ciencia da Computacao", "Exatas", 15, 1800.0, 360);
        System.out.println("Curso de Pos-Graduacao criado com sucesso.");

        System.out.println();
        System.out.println("--- Consulta de Informacoes dos Cursos ---");
        app.consultarInformacoes(grad);
        System.out.println();
        app.consultarInformacoes(pos);

        System.out.println();
        System.out.println("--- Consultas de Precos e Descontos (Graduacao) ---");
        System.out.println("Taxa de matricula padrao: R$" + grad.getTaxaMatricula());
        System.out.println("Preco antes da matricula (10% desconto): R$" + grad.calcularPreco(true, false));
        System.out.println("Preco com convenio irmao (6% desconto): R$" + grad.calcularPreco(false, true));
        System.out.println("Preco com ambos os descontos (16% desconto): R$" + grad.calcularPreco(true, true));

        System.out.println();
        System.out.println("--- Consultas de Precos e Descontos (Pos-Graduacao) ---");
        System.out.println("Taxa de matricula padrao: R$" + pos.getTaxaMatricula());
        System.out.println("Preco antes da matricula (5% desconto): R$" + pos.calcularPreco(true, false));
        System.out.println("Preco com convenio ex-aluno (5% desconto): R$" + pos.calcularPreco(false, true));
        System.out.println("Preco com ambos os descontos (10% desconto): R$" + pos.calcularPreco(true, true));
    }
}
