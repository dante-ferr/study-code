public class ContaPoupanca extends Conta {
    private double rendimentoMensal;

    public ContaPoupanca(String titular, String agencia, double saldo, double rendimentoMensal) {
        super(titular, agencia, saldo);
        this.rendimentoMensal = rendimentoMensal;
    }

    public double getRendimentoMensal() {
        return rendimentoMensal;
    }

    public void setRendimentoMensal(double rendimentoMensal) {
        this.rendimentoMensal = rendimentoMensal;
    }

    @Override
    public boolean sacar(double valor) {
        if (valor > 0 && valor <= saldo) {
            saldo -= valor;
            return true;
        }
        return false;
    }

    public void creditarRendimento() {
        saldo += saldo * rendimentoMensal;
    }
}
