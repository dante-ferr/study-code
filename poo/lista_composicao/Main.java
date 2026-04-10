public class Main {
    public static void main(String[] args) {
        // --- Exercício 1: Condutor e Carteira ---
        System.out.println("--- Exercício 1 ---");
        DriverLicense myLicense = new DriverLicense("ABC-1234", 'B');
        Driver d1 = new Driver("Dante", "123.456.789-00", myLicense);
        
        d1.addPoints(35); 
        System.out.println("Pontos: " + d1.getPoints());
        System.out.println("Está cancelada: " + (d1.isLicenseCanceled() ? "Sim" : "Não"));

        // --- Exercício 2: Contrato de Aluguel ---
        System.out.println("\n--- Exercício 2 ---");
        Guarantor g = new Guarantor("John Doe", "000.111.222-33", 5000.0);
        RentalContract contract = new RentalContract(101, 1200.0, 24, 0.1, 3, g);
        
        System.out.println("Valor da prestação sem juros: " + contract.getBaseInstallment());
        System.out.println("Valor da prestação com atraso: " + contract.getInstallmentWithLateFee());
        System.out.println("Ordem de despejo disparada? " + (contract.shouldIssueEviction() ? "Sim" : "Não"));

        // --- Exercício 3: Cinema ---
        System.out.println("\n--- Exercício 3 ---");
        CinemaClient client = new CinemaClient("Alice", 10);
        System.out.println("Preço na segunda-feira: R$ " + client.calculateTicketValue("Monday"));
        System.out.println("Preço na quarta-feira (Promoção): R$ " + client.calculateTicketValue("Wednesday"));

        // --- Exercício 4: Comparação (Sobrecarga) ---
        System.out.println("\n--- Exercício 4 ---");
        Comparison comp = new Comparison(10.0);
        
        System.out.println("10.0 é igual ao valor da classe (10.0)? " + (comp.isEqual(10.0) ? "Sim" : "Não"));
        System.out.println("5.0 é menor que o valor da classe? " + (comp.isLessThan(5.0) ? "Sim" : "Não"));
        
        System.out.println("5.0 é igual a 5.0? " + (comp.isEqual(5.0, 5.0) ? "Sim" : "Não"));
        System.out.println("20.0 é maior que 15.0? " + (comp.isGreater(20.0, 15.0) ? "Sim" : "Não"));
    }
}