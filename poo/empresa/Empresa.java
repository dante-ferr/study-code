package empresa;

import java.util.ArrayList;

public class Empresa {
    public String gerenteNome;
    private ArrayList<Empregado> empregados;

    public Empresa(String gerenteNome) {
        this.gerenteNome = gerenteNome;

        this.empregados = new ArrayList<>();
    }

}
