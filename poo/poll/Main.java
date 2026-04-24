package poll;

import java.util.Map;

public class Main {
    public static void main(String[] args) {
        PollManager manager = new PollManager();

        String[] opcoes = {"IntelliJ IDEA", "Eclipse", "VS Code", "NetBeans"};
        manager.createPoll("Qual a melhor IDE para trabalhar com Java?", opcoes);

        Poll idePoll = manager.getPoll(0);

        idePoll.vote(0, "Dante");
        idePoll.vote(2, "Alice");
        idePoll.vote(0, "Bob");
        idePoll.vote(1, "Charlie");

        idePoll.vote(0, "Dante");
        idePoll.vote(99, "Eve");

        System.out.println("--- RESULTADOS DA ENQUETE ---");
        System.out.println("Pergunta: " + idePoll.getQuestion());

        Map<Integer, Integer> results = idePoll.getResults();
        for (var entry : results.entrySet()) {
            String opcaoTexto = opcoes[entry.getKey()];
            System.out.println(opcaoTexto + ": " + entry.getValue() + " voto(s)");
        }

        int winnerIndex = idePoll.getWinner();
        if (winnerIndex != -1) {
            System.out.println("\nVencedor atual: " + opcoes[winnerIndex]);
        } else {
            System.out.println("\nAinda não há votos computados.");
        }
    }
}
