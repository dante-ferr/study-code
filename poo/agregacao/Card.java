public class Card {
    private Destinatary destinatary;
    private String emissaryName;
    private String message;
    private String deliveryTime;
    private int cost;

    public Card(Destinatary destinatary, String emissaryName, String message, String deliveryTime) {
        this.destinatary = destinatary;
        this.emissaryName = emissaryName;
        this.message = message;
        this.deliveryTime = deliveryTime;
        this.cost = 30;
    }

    public Card(Destinatary destinatary, String emissaryName, String message) {
        this.destinatary = destinatary;
        this.emissaryName = emissaryName;
        this.message = message;
        this.deliveryTime = "0000";
        this.cost = 30;

        destinatary = this.getDestinatary();
    }

    public Destinatary getDestinatary() {
        return this.destinatary;
    }

    public String getEmissaryName() {
        return this.emissaryName;
    }

    public String getMessage() {
        return this.message;
    }

    public String getDeliveryTime() {
        return this.deliveryTime;
    }

    public void setDeliveryTime(String time) {
        this.deliveryTime = time;
    }

    public int getCost() {
        return this.cost;
    }
}