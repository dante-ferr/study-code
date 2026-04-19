package moradia;

public class Main {
    public static void main(String[] args) {
        Property property = new Property(100.00, 860.00, 221.00, 'F', 2);

        Rent rent = new Rent(property, 360, 2);

        RentStatement statement =
                new RentStatement("Rua dos Estudantes, 123", "Avenida do Proprietário, 987", rent);

        System.out.println("--- DETALHES DO EXTRATO ---");
        for (StatementLine line : statement.getLines()) {
            String description = line.getDescription();

            if (description.equals("Gross Rent")) {
                description = "Valor Bruto da Locação";
            } else if (description.equals("Condominium")) {
                description = "Taxa Condominial";
            }

            System.out.printf("%s: R$ %.2f%n", description, line.getAmount());
        }

        System.out.println("\n--- RESUMO ---");
        System.out.printf("Valor Total do Contrato (12 meses): R$ %.2f%n", rent.getTotalCost());
        System.out.printf("Custo Mensal Equivalente: R$ %.2f%n", rent.getMonthlyEquivalentCost());
        System.out.printf("Custo Mensal por Morador (2 pessoas): R$ %.2f%n",
                rent.getMonthlyCostPerResident());
    }
}
