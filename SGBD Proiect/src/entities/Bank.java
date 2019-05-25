package entities;

import javafx.beans.property.SimpleStringProperty;

public class Bank {
    private SimpleStringProperty name;
    private SimpleStringProperty address;
    private SimpleStringProperty city;
    private SimpleStringProperty idBank;

    public Bank(String idBank, String city, String address, String name) {
        this.name = new SimpleStringProperty(name);
        this.address = new SimpleStringProperty(address);
        this.city = new SimpleStringProperty(city);
        this.idBank = new SimpleStringProperty(idBank);
    }

    public Bank()
    {
        this.name = new SimpleStringProperty("");
        this.address = new SimpleStringProperty("");
        this.city = new SimpleStringProperty("");
        this.idBank = new SimpleStringProperty("");
    }

    public String getName() {
        return name.get();
    }

    public SimpleStringProperty nameProperty() {
        return name;
    }

    public void setName(String name) {
        this.name.set(name);
    }

    public String getAddress() {
        return address.get();
    }

    public SimpleStringProperty addressProperty() {
        return address;
    }

    public void setAddress(String address) {
        this.address.set(address);
    }

    public String getCity() {
        return city.get();
    }

    public SimpleStringProperty cityProperty() {
        return city;
    }

    public void setCity(String city) {
        this.city.set(city);
    }

    public String getIdBank() {
        return idBank.get();
    }

    public SimpleStringProperty idBankProperty() {
        return idBank;
    }

    public void setIdBank(String idBank) {
        this.idBank.set(idBank);
    }

    @Override
    public String toString() {
        if (idBank.toString().equals("StringProperty [value: ]"))
            return "invalid bank";
        return "Bank Id: " + getIdBank() + ", city: " + getCity() + ", address: " +
                getAddress() + ", name: " + getName();
    }
}
