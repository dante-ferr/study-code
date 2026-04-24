package poll;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;

public class Poll {
    private int id;
    private String question;
    private ArrayList<String> answers;
    private HashMap<Integer, Integer> votes;
    private HashSet<String> voters;

    public Poll(int id, String question, String[] answers) {
        this.id = id;
        this.question = question;
        this.answers = new ArrayList<>(Arrays.asList(answers));
        this.votes = new HashMap<>();
        this.voters = new HashSet<>();
    }

    public void vote(int answerIndex, String voterName) {
        if (answerIndex < 0 || answerIndex >= answers.size() || voters.contains(voterName)) {
            return;
        }

        votes.put(answerIndex, votes.getOrDefault(answerIndex, 0) + 1);
        voters.add(voterName);
    }

    public HashMap<Integer, Integer> getResults() {
        return new HashMap<>(votes);
    }

    public int getWinner() {
        int winner = -1;
        int maxVotes = 0;

        for (var entry : votes.entrySet()) {
            if (entry.getValue() > maxVotes) {
                maxVotes = entry.getValue();
                winner = entry.getKey();
            }
        }
        return winner;
    }

    public String getQuestion() {
        return question;
    }
}
