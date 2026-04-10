package conta_titular;

public class Holder {
    private String name;
    private String cpf;
    private String address;

    public Holder(String name, String cpf, String address) {
        this.name = name;
        this.cpf = cpf;
        this.address = address;
    }

    public String getName() {
        return this.name;
    }

    public String getCpf() {
        return this.cpf;
    }

    public String getAddress() {
        return this.address;
    }
}
