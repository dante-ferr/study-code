package empresa;

public class Empregado {
    private String nome;
    private String funcao;
    private int matricula;
    private String departamento;
    private double salario;
    public static double salarioMin = 1600;

    public Empregado(String nome, String funcao, int matricula, String departamento, double salario) {
        this.nome = nome;
        this.funcao = funcao;
        this.matricula = matricula;
        this.departamento = departamento;
        this.salario = salario;
    }
}
