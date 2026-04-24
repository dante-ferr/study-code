package poll;

import java.util.ArrayList;

public class PollManager {
    private ArrayList<Poll> polls;

    public PollManager() {
        polls = new ArrayList<>();
    }

    public void createPoll(String question, String[] answers) {
        polls.add(new Poll(polls.size(), question, answers));
    }

    public Poll getPoll(int id) {
        return polls.get(id);
    }
}
