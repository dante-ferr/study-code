package agenda;

import java.util.ArrayList;

public class Agenda {
    private ArrayList<Contact> contacts;

    public Agenda() {
        this.contacts = new ArrayList<>();
    }

    public void addContact(String name, String phone) {
        this.contacts.add(new Contact(name, phone));
    }

    public void removeContactByName(String name) {
        for (Contact contact : this.contacts) {
            if (contact.getName().equals(name)) {
                this.contacts.remove(contact);
                return;
            }
        }
    }

    public void removeContactByPhone(String phone) {
        for (Contact contact : this.contacts) {
            if (contact.getPhone().equals(phone)) {
                this.contacts.remove(contact);
                return;
            }
        }
    }

    public void changeContactPhone(String name, String newPhone) {
        for (Contact contact : this.contacts) {
            if (contact.getName().equals(name)) {
                contact.setPhone(newPhone);
                return;
            }
        }
    }

    public void printContacts() {
        for (Contact contact : this.contacts) {
            System.out.println(contact.getName() + ": " + contact.getPhone());
        }
    }

    public int getAmountOfContacts() {
        return this.contacts.size();
    }
}
