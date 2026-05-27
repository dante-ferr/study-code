public class ContaEspecial extends ContaCorrente {
    private double taxaDebitoMensal;
    private double limite;

    public ContaEspecial(String titular, String agencia, double saldo, double taxaDebitoMensal, double limite) {
        super(titular, agencia, saldo);
        this.taxaDebitoMensal = taxaDebitoMensal;
        this.limite = limite;
    }

    public double getTaxaDebitoMensal() {
        return taxaDebitoMensal;
    }

    public void setTaxaDebitoMensal(double taxaDebitoMensal) {
        this.taxaDebitoMensal = taxaDebitoMensal;
    }

    public double getLimite() {
        return limite;
    }

    public void setLimite(double limite) {
        this.limite = limite;
    }

    @Override
    public boolean sacar(double valor) {
        if (valor > 0 && valor <= saldo + limite) {
            saldo -= valor;
            return true;
        }
        return false;
    }

    public void cobrarTaxaMensal() {
        saldo -= taxaDebitoMensal;
    }
}
