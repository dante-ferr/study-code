package empresa;

import java.util.Scanner;

public class EntradaDados {
    private Scanner scanner;

    public EntradaDados() {
        scanner = new Scanner(System.in);
    }

    public String lerNome() {
        System.out.print("Nome: ");
        return scanner.nextLine();
    }

    public String lerCpf() {
        String cpf;
        do {
            System.out.print("CPF: ");
            cpf = scanner.nextLine();
        } while (cpf.length() != 11);
        return cpf;
    }

    public String lerDepartamento() {
        System.out.print("Departamento: ");
        return scanner.nextLine();
    }

    public int lerOpcao() {
        System.out.print("Opção: ");
        return scanner.nextInt();
    }

    public int lerSalario() {
        System.out.print("Salário: ");
        return scanner.nextInt();
    }
}
