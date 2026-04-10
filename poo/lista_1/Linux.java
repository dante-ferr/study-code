import java.time.LocalDateTime;

class Tv {
    private String marca;
    private String modelo;
    private String estado;
    private String canal;
    private String senha;

    public Tv (String marca, String modelo) {
        this.marca = marca;
        this.modelo = modelo;
    }

    public Tv (String marca, String modelo, String senha) {
        this.marca = marca;
        this.modelo = modelo;
        this.senha = senha;
    }

    public void ligar() {
        this.estado = "Ligado";
        System.out.println("Tv ligada");
    }

    public void ligar(String canal, LocalDateTime horario) {
        LocalDateTime now = LocalDateTime.now();

        if (now.isAfter(horario) || now.isEqual(horario)) {
            this.estado = "Ligado";
            this.canal = canal;

            System.out.println("Tv ligada no canal " + canal);
        }
        else {
            System.out.println("Ainda não chegou o horário!");
        }
    }

    public void ligar(String canal, String senha) {
        if (senha.equals(this.senha)) {
            this.estado = "Ligado";
            this.canal = canal;

            System.out.println("Tv ligada no canal " + canal);
        }
        else {
            System.out.println("Senha incorreta!");
        }
    }
}

class Linux {
    public static void main(String[] args) {
        Tv tv1 = new Tv("Dantv", "DTF-67");
        tv1.ligar();
        tv1.ligar("canal1", LocalDateTime.now());

        Tv tv2 = new Tv("Dantv", "DTF-67", "123");
        tv2.ligar("canal2", "1234");
    }

    private static void greetUser(String name) {
        System.out.println("Hello, " + name + "!");
    }
}