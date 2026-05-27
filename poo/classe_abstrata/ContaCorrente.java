public class ContaCorrente extends Conta {
    public ContaCorrente(String titular, String agencia, double saldo) {
        super(titular, agencia, saldo);
    }

    @Override
    public boolean sacar(double valor) {
        if (valor > 0 && valor <= saldo) {
            saldo -= valor;
            return true;
        }
        return false;
    }
}
