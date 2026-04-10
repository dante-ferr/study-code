package conta_titular;

public class Person {
    private String name;
    private String cpf;
    private String address;
    private String favoritecolor;

    public Person(String name, String cpf, String address, String favoritecolor) {
        this.name = name;
        this.cpf = cpf;
        this.address = address;
        this.favoritecolor = favoritecolor;
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

    public String getFavoritecolor() {
        return this.favoritecolor;
    }
}
