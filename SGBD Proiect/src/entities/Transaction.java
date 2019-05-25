package entities;

import javafx.beans.property.SimpleStringProperty;

import java.time.LocalDate;

public class Transaction {
    private SimpleStringProperty fname;
    private SimpleStringProperty lname;
    private SimpleStringProperty city;
    private SimpleStringProperty idCustomer;
    private SimpleStringProperty email;
    private SimpleStringProperty phoneNumber;
    private LocalDate birthday;
    private LocalDate createdAt;
    private LocalDate updatedAt;

}
