package sample.view;

import controllers.BankController;
import entities.Bank;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.util.ArrayList;


public class BankView{
    public static ObservableList<Bank> banks = getBanks();
    public static BankController bankController = new BankController();

    //will return an observable list of banks
    private static ObservableList<Bank> getBanks() {
        ObservableList<Bank> banks = FXCollections.observableArrayList();
        bankController = new BankController();
        ArrayList<String> banksIds = bankController.getBanksIds();
        for (String banksId : banksIds) {
            Bank bank = bankController.getBankById(banksId);
            banks.add(bank);
        }
        return banks;
    }

    public static String getBankByIdButtonPushed(String id)
    {
        String bank = bankController.getBankById(id).toString();
        if(!bank.equals(""))
            return bank;
        return "invalid id";
    }

    public static void newBankButtonPushed(String city, String address, String name)
    {
        bankController.create(city, address, name);
        //String idBank = "66"; //cum iau ultima chestie adaugata in bd?
        //Bank bank = new Bank(idBank, cityTextField.getText(), addressTextField.getText(), nameTextField.getText());
        //banks.add(bank);
        banks = getBanks();
    }

    public static void updateBankButtonPushed(String id, String city, String address, String name)
    {
        bankController.update(id, city, address, name);
        banks = getBanks();
    }
}
