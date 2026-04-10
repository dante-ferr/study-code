import java.util.ArrayList;
import java.util.List;

class Room {
    private String name;
    private double area;

    public Room(String name) {
        this.name = name;
        this.area = 0.0;
    }

    public Room(String name, double area) {
        this.name = name;
        this.area = area;
    }
}

/**
 * Exercício 1 - Composição Forte:
 * Crie uma classe House que componha fortemente objetos Room. 
 * A classe House deve gerenciar o ciclo de vida de seus cômodos. 
 * Implemente sobrecarga de método para adicionar um cômodo apenas pelo nome ou pelo nome e área.
 */
class House {
    private List<Room> rooms;

    public House() {
        this.rooms = new ArrayList<>();
    }

    public void addRoom(String name) {
        this.rooms.add(new Room(name));
    }

    public void addRoom(String name, double area) {
        this.rooms.add(new Room(name, area));
    }
}

class Player {
    private String name;

    public Player(String name) {
        this.name = name;
    }
}

/**
 * Exercício 2 - Composição Fraca:
 * Crie uma classe Team que componha fracamente objetos Player. 
 * Os jogadores podem existir independentemente do time. 
 * Implemente sobrecarga de método para adicionar um único jogador ou um array de jogadores ao time.
 */
class Team {
    private List<Player> players;

    public Team() {
        this.players = new ArrayList<>();
    }

    public void addPlayer(Player player) {
        this.players.add(player);
    }

    public void addPlayer(Player[] newPlayers) {
        for (Player p : newPlayers) {
            this.players.add(p);
        }
    }
}

public class Main {
    public static void main(String[] args) {
        House myHouse = new House();
        myHouse.addRoom("Living Room");
        myHouse.addRoom("Bedroom", 15.5);

        Player player1 = new Player("John");
        Player player2 = new Player("Doe");
        Player player3 = new Player("Smith");

        Team myTeam = new Team();
        myTeam.addPlayer(player1);
        myTeam.addPlayer(new Player[]{player2, player3});
    }
}