package sample.view;

import com.intellij.codeInsight.template.postfix.templates.SoutPostfixTemplate;
import controllers.BankController;
import controllers.CustomerController;
import entities.Bank;
import entities.Customer;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.util.ArrayList;

public class CustomerView {
    public static CustomerController customerController;
    public static int numberOfCustomersInPage = 20;

    //will return an observable list of customers
    private static ObservableList<Customer> getCustomers() {
        ObservableList<Customer> customers = FXCollections.observableArrayList();
        customerController = new CustomerController();
        ArrayList<String> customersIds = customerController.getCustomersIds();
        for (String customerId : customersIds) {
            Customer customer = (Customer) customerController.getCustomerById(customerId);
            customers.add(customer);
        }
        return customers;
    }

    public static String getCustomerByIdButtonPushed(String id)
    {
        if(customerController.getCustomerById(id) != null)
            return customerController.getCustomerById(id).toString();
        return "no content for this id";
    }

    public static void newCustomerButtonPushed(String firstName, String lastName, String city, String email, String phoneNumber, String dateOfBirth, String accountType, int accountValue)
    {
        customerController.create(firstName, lastName, city, email, phoneNumber, dateOfBirth, accountType, accountValue);

    }
}
