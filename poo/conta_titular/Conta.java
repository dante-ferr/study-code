package conta_titular;

public class Conta {
    private int number;
    private Holder[] holders;

    public Conta(int number, Person person) {
        this.number = number;
        this.holders = new Holder[1];
        this.holders[0] = new Holder(person.getName(), person.getCpf(), person.getAddress());
    }

    public Conta(int number, Person[] people) {
        this.number = number;
        
        if (people.length == 0) {
            throw new IllegalArgumentException("A conta precisa ter pelo menos um titular.");
        }
        if (people.length > 3) {
            throw new IllegalArgumentException("A conta pode ter no máximo 3 titulares.");
        }

        this.holders = new Holder[people.length];
        for (int i = 0; i < people.length; i++) {
            Person person = people[i];
            this.holders[i] = new Holder(person.getName(), person.getCpf(), person.getName());
        }
    }

    public int getNumber() {
        return this.number;
    }

    public Holder[] getHolders() {
        return this.holders;
    }
}
