package sample;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class Main extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception{
        Parent root = FXMLLoader.load(getClass().getResource("sample.fxml"));
        primaryStage.setTitle("Hello World");
        primaryStage.setScene(new Scene(root));
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }

    /*public static void things() {
        try {
            ExchangeRateController exchangeRateController = new ExchangeRateController();
            TransactionController transactionController = new TransactionController();
            BankController bankController = new BankController();
            CustomerController customerController = new CustomerController();
            StaffController staffController = new StaffController();
            AccountController accountController = new AccountController();

            //exchangeRateController.create(1.16F,5.54F,84.28F,0.86F,4.76F,72.47F,0.18F,0.21F,15.23F,0.012F,0.014F,0.066F);
            //exchangeRateController.findById(15022);
            //transactionController.create(10, 123, 120, 120, "RON", "Withdraw", 120);
            //transactionController.mostActiveDay(2,2019);
            //transactionController.monthlyMoneySum(1,2019);
            //transactionController.findById(5);
            //bankController.create("Galati","Strada Voievod nr 7", "Elizabeta");
            //bankController.update(66, "Galati", "Strada Locotenent nr 14", null);
            //bankController.findById(66);
            //customerController.create("Andrei", "Ionescu", "Iasi", "andrei.ionescu@gmail.com", "0724073104","05-APR-80", "Zero", 100);
            //customerController.update(300018, "Andrei", "Serban", null, null, "0742073421");
            //customerController.findById(300018);
            //staffController.create(30, "John", "Doe", "Suceava", "jondo@yahoo.com","0724030303","09APR87","Teller",3000);
            //staffController.update(10003, 31, null, null, null, null, "0744123456", "Consultant");
            //staffController.salaryIncrease(10003, 100);
            //staffController.employeeOfTheMonth(3,2019,300);
            //staffController.findById(10003);
            //accountController.create(20, "Zero", 1000);
            //accountController.update(550008, null, 1400);
            //accountController.freeze(550008);
            //accountController.check(3);
            accountController.findById(3);
            Database.commit();
        } catch (SQLException e) {
            System.err.println(e);
            Database.rollback();
        }
    }*/
}
