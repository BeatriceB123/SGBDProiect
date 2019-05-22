package entities;

import javafx.beans.property.SimpleStringProperty;

import java.time.LocalDate;

public class Customer {
    private SimpleStringProperty fname;
    private SimpleStringProperty lname;
    private SimpleStringProperty city;
    private SimpleStringProperty idCustomer;
    private SimpleStringProperty email;
    private SimpleStringProperty phoneNumber;
    private LocalDate birthday;
    private LocalDate createdAt;
    private LocalDate updatedAt;

    public Customer(String fname, String lname, String city, String idCustomer, String email, String phoneNumber, LocalDate birthday)
    {
        this.fname = new SimpleStringProperty(fname);
        this.lname = new SimpleStringProperty(lname);
        this.city = new SimpleStringProperty(city);
        this.idCustomer = new SimpleStringProperty(idCustomer);
        this.email = new SimpleStringProperty(email);
        this.phoneNumber = new SimpleStringProperty(phoneNumber);
        this.birthday = birthday;
    }

    @Override
    public String toString() {
        return fname.getValue() + " " + lname.getValue() + ", from " + city.getValue() + ", with id: " + idCustomer.getValue() + " \nemail: " +
                email.getValue() + " \nphone number: " + phoneNumber.getValue() + "\nbirthdate: " +  birthday;
    }

    public LocalDate getBirthday() {
        return birthday;
    }

    public void setBirthday(LocalDate birthday) {
        this.birthday = birthday;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDate getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDate updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getFname() {
        return fname.get();
    }

    public SimpleStringProperty fnameProperty() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname.set(fname);
    }

    public String getLname() {
        return lname.get();
    }

    public SimpleStringProperty lnameProperty() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname.set(lname);
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

    public String getIdCustomer() {
        return idCustomer.get();
    }

    public SimpleStringProperty idCustomerProperty() {
        return idCustomer;
    }

    public void setIdCustomer(String idCustomer) {
        this.idCustomer.set(idCustomer);
    }

    public String getEmail() {
        return email.get();
    }

    public SimpleStringProperty emailProperty() {
        return email;
    }

    public void setEmail(String email) {
        this.email.set(email);
    }

    public String getPhoneNumber() {
        return phoneNumber.get();
    }

    public SimpleStringProperty phoneNumberProperty() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber.set(phoneNumber);
    }
}
