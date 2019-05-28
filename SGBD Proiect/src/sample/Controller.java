package sample;

import controllers.*;
import entities.Bank;
import entities.Customer;
import entities.ExchangeRate;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.PieChart;
import javafx.scene.chart.XYChart;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.util.converter.NumberStringConverter;
import sample.view.BankView;
import sample.view.CustomerView;

import java.net.URL;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import static sample.Datas.isNumeric;
import static sample.view.BankView.*;

public class Controller implements Initializable {
    private StatisticsController statisticsController = new StatisticsController();
    private ExchangeRateController exchangeRateController = new ExchangeRateController();
    private AccountController accountController = new AccountController();
    private StaffController staffController = new StaffController();

    public ObservableList<ExchangeRate> exchangeRates = getExchangesRates();

    //private static int numberOfStaffsInPage = 20;

    //configure the bank table
    @FXML private TableView<Bank> bankTableView;
    @FXML private TableColumn<Bank, String> bankNameColumn;
    @FXML private TableColumn<Bank, String> bankCityColumn;
    @FXML private TableColumn<Bank, String> bankAddressColumn;
    @FXML private TableColumn<Bank, Integer> idBankColumn;

    //These instance variables are used to create new Bank objects
    @FXML private TextField bankNameTextField;
    @FXML private TextField bankCityTextField;
    @FXML private TextField bankAddressTextField;
    @FXML private TextField idBankTextField;
    @FXML private Label bankResponse;

    //configure the customers table
    @FXML private TableView<Customer> customerTableView;
    @FXML private TableColumn<Customer, String> idCustomerColumn;
    @FXML private TableColumn<Customer, String> customerFirstNameColumn;
    @FXML private TableColumn<Customer, String> customerLastNameColumn;
    @FXML private TableColumn<Customer, String> customerCityColumn;
    @FXML private TableColumn<Customer, String> customerPhoneNumberColumn;
    @FXML private TableColumn<Customer, String> customerEmailColumn;
    @FXML private TableColumn<Customer, LocalDate> customerBirthColumn;
    @FXML private TableColumn<Customer, LocalDate> customerCreateAccountColumn;
    @FXML private TableColumn<Customer, LocalDate> customerUpdateAccountColumn;

    //These instance variables are used to create new Bank objects
    @FXML private TextField idCustomerTextField;
    @FXML private TextField customerFirstNameTextField;
    @FXML private TextField customerLastNameTextField;
    @FXML private TextField customerCityTextField;
    @FXML private TextField customerPhoneNumberTextField;
    @FXML private TextField customerEmailTextField;
    @FXML private DatePicker customerDateOfBirthDateField;
    @FXML private Label customerResponse;

    @FXML private TextField customerFromIndex = new TextField();

    @FXML private TextField idEmployeeToIncreaseSalary;
    @FXML private TextField amountToIncreaseSalary;
    @FXML private Label staffResponse;
    @FXML private ComboBox monthListForEmployee = new ComboBox();
    @FXML private ComboBox yearListForEmployee = new ComboBox();
    @FXML private TextField rewardEmployeeWith;
    @FXML private TextField idForEmployeeToFind;

    @FXML private PieChart pieChartForRegionStatistics;
    @FXML private Label regionStatisticsResponse;

    @FXML private PieChart pieChartForCityStatistics;
    @FXML private Label cityStatisticsResponse;

    //(int gbp, int eur, int ron, int rub)
    @FXML private TableView<ExchangeRate> exchangeRateTableViewFromGBP;
    @FXML private TableView<ExchangeRate> exchangeRateTableViewFromEUR;
    @FXML private TableView<ExchangeRate> exchangeRateTableViewFromRON;
    @FXML private TableView<ExchangeRate> exchangeRateTableViewFromRUB;

    @FXML private  TableColumn<ExchangeRate, String> gbpToEur;
    @FXML private  TableColumn<ExchangeRate, String> gbpToRon;
    @FXML private  TableColumn<ExchangeRate, String> gbpToRub;
    @FXML private  TableColumn<ExchangeRate, String> eurToGbp;
    @FXML private  TableColumn<ExchangeRate, String> eurToRon;
    @FXML private  TableColumn<ExchangeRate, String> eurToRub;
    @FXML private  TableColumn<ExchangeRate, String> ronToGbp;
    @FXML private  TableColumn<ExchangeRate, String> ronToEur;
    @FXML private  TableColumn<ExchangeRate, String> ronToRub;
    @FXML private  TableColumn<ExchangeRate, String> rubToGbp;
    @FXML private  TableColumn<ExchangeRate, String> rubToEur;
    @FXML private  TableColumn<ExchangeRate, String> rubToRon;

    //accountController
    @FXML private TextField idAccount;
    @FXML private Label accountResponse;


    //staff statistics
    @FXML private NumberAxis xAxisForStaff = new NumberAxis();
    @FXML private NumberAxis yAxisForStaff = new NumberAxis();
    @FXML private LineChart<Number,Number> lineChartForStaff = new LineChart<>(xAxisForStaff,yAxisForStaff);

    @FXML private TextField idStaffForTransactionEvolutionStatistics;
    @FXML private TextField yearForTransactionEvolutionStatistics;
    @FXML private Label responseForTransactionEvolutionStatistics;


    //bank statistics
    @FXML private NumberAxis xAxisForBank = new NumberAxis();
    @FXML private NumberAxis yAxisForBank = new NumberAxis();
    @FXML private LineChart<Number,Number> lineChartForBank = new LineChart<>(xAxisForBank,yAxisForBank);

    @FXML private TextField idBankForTransactionEvolutionStatistics;
    @FXML private TextField yearBankForTransactionEvolutionStatistics;
    @FXML private Label responseBankForTransactionEvolutionStatistics;

    @Override
    public void initialize(URL location, ResourceBundle resources) {

        //set up the columns in the bank table
        bankNameColumn.setCellValueFactory(new PropertyValueFactory<Bank, String>("name"));
        bankAddressColumn.setCellValueFactory(new PropertyValueFactory<Bank, String>("address"));
        bankCityColumn.setCellValueFactory(new PropertyValueFactory<Bank, String>("city"));
        idBankColumn.setCellValueFactory(new PropertyValueFactory<Bank, Integer>("idBank"));

        //set up the columns in the customer table
        idCustomerColumn.setCellValueFactory(new PropertyValueFactory<Customer, String>("idCustomer"));
        customerFirstNameColumn.setCellValueFactory(new PropertyValueFactory<Customer, String>("fname"));
        customerLastNameColumn.setCellValueFactory(new PropertyValueFactory<Customer, String>("lname"));
        customerCityColumn.setCellValueFactory(new PropertyValueFactory<Customer, String>("city"));
        customerBirthColumn.setCellValueFactory(new PropertyValueFactory<Customer, LocalDate>("birthday"));
        customerEmailColumn.setCellValueFactory(new PropertyValueFactory<Customer, String>("email"));
        customerPhoneNumberColumn.setCellValueFactory(new PropertyValueFactory<Customer, String>("phoneNumber"));
        customerCreateAccountColumn.setCellValueFactory(new PropertyValueFactory<Customer, LocalDate>("createdAt"));
        customerUpdateAccountColumn.setCellValueFactory(new PropertyValueFactory<Customer, LocalDate>("updatedAt"));

        customerFromIndex.setTextFormatter(new TextFormatter<>(new NumberStringConverter()));

        //load data
        bankTableView.setItems(banks);

        monthListForEmployee.getItems().addAll(Datas.monthsLongForm);
        yearListForEmployee.getItems().addAll(Datas.years);

        //refreshChartCityStatisticsButtonPushed();
        //refreshChartRegionStatisticsButtonPushed();

        //set up the columns in the exchange rate table //(int gbp, int eur, int ron, int rub)
        gbpToEur.setCellValueFactory(new PropertyValueFactory<ExchangeRate, String>("gbpToEur"));
        gbpToRon.setCellValueFactory(new PropertyValueFactory<ExchangeRate, String>("gbpToRon"));
        gbpToRub.setCellValueFactory(new PropertyValueFactory<ExchangeRate, String>("gbpToRub"));

        eurToGbp.setCellValueFactory(new PropertyValueFactory<ExchangeRate, String>("eurToGbp"));
        eurToRon.setCellValueFactory(new PropertyValueFactory<ExchangeRate, String>("eurToRon"));
        eurToRub.setCellValueFactory(new PropertyValueFactory<ExchangeRate, String>("eurToRub"));

        ronToGbp.setCellValueFactory(new PropertyValueFactory<ExchangeRate, String>("ronToGbp"));
        ronToEur.setCellValueFactory(new PropertyValueFactory<ExchangeRate, String>("ronToEur"));
        ronToRub.setCellValueFactory(new PropertyValueFactory<ExchangeRate, String>("ronToRub"));

        rubToGbp.setCellValueFactory(new PropertyValueFactory<ExchangeRate, String>("rubToGbp"));
        rubToEur.setCellValueFactory(new PropertyValueFactory<ExchangeRate, String>("rubToEur"));
        rubToRon.setCellValueFactory(new PropertyValueFactory<ExchangeRate, String>("rubToRon"));
    }


    private XYChart.Series<Number, Number> getSeriesForChartFromData (String datas, int year) {
        XYChart.Series<Number, Number> series = new XYChart.Series<>();

        String[] arrOfStr = datas.split("@");

        for (String a : arrOfStr)
        {
            if(a.substring(0, 4).equals(String.valueOf(year))) {
                System.out.print(a + '-');
                int month = Integer.parseInt(a.substring(5, 7));
                int amount = Integer.parseInt(a.substring(8));

                series.getData().add(new XYChart.Data(month, amount));
            }
        }
        return series;
    }

    private void setChartBankStatistics(String datas, int year){
        lineChartForBank.getData().add(getSeriesForChartFromData(datas, year));
    }

    private void setChartStaffStatistics(String datas, int year){
        lineChartForStaff.getData().add(getSeriesForChartFromData(datas, year));
    }

    public void refreshChartBankTransactionInTimeButtonPushed() {
        lineChartForBank.getData().clear();
        responseBankForTransactionEvolutionStatistics.setText("Chart cleared");
    }

    public void refreshChartStaffTransactionInTimeButtonPushed() {
        lineChartForStaff.getData().clear();
        responseForTransactionEvolutionStatistics.setText("Chart cleared");
    }

    public void generateStaffTransactionsStatisticsInTimeButtonPushed() {
        try {
            if(idStaffForTransactionEvolutionStatistics.getText() == null)
                throw new Exception("null id");
            if(yearForTransactionEvolutionStatistics.getText() == null)
                throw new Exception("null year");

            int id = Integer.parseInt(idStaffForTransactionEvolutionStatistics.getText());
            int year = Integer.parseInt(yearForTransactionEvolutionStatistics.getText());

            String result = staffController.getStaffTotalAmountInTime(id);

            setChartStaffStatistics(result, year);

            responseForTransactionEvolutionStatistics.setText("Succes");
        }
        catch (Exception e) {
            responseForTransactionEvolutionStatistics.setText("Parameter error\n" + e.getMessage());
        }
    }

    public void generateBankTransactionsStatisticsInTimeButtonPushed() {
        try {
            if(idBankForTransactionEvolutionStatistics.getText() == null)
                throw new Exception("null id");
            if(yearBankForTransactionEvolutionStatistics.getText() == null)
                throw new Exception("null year");

            int id = Integer.parseInt(idBankForTransactionEvolutionStatistics.getText());
            int year = Integer.parseInt(yearBankForTransactionEvolutionStatistics.getText());

            String result = bankController.getBankTotalAmountInTime(id);

            setChartBankStatistics(result, year);

            responseBankForTransactionEvolutionStatistics.setText("Succes");
        }
        catch (Exception e) {
            responseBankForTransactionEvolutionStatistics.setText("Parameter error\n" + e.getMessage());
        }
    }

    public void genrateStatementAccountButtonPushed(){
        accountResponse.setText(accountController.generateStatement(Integer.parseInt(idAccount.getText())));
    }

    public void checkAccountButtonPushed(){
        accountResponse.setText(accountController.check(Integer.parseInt(idAccount.getText())));
    }

    private ObservableList<ExchangeRate> getExchangesRates() {
        ObservableList<ExchangeRate> exchangeRates = FXCollections.observableArrayList();
        ExchangeRate exchangeRate = exchangeRateController.getLastExchangeRate();
        exchangeRates.add(exchangeRate);
        return exchangeRates;
    }

    public void refreshLastExchangeRateButtonPushed() {
        exchangeRates = getExchangesRates();
        exchangeRateTableViewFromGBP.setItems(exchangeRates);
        exchangeRateTableViewFromEUR.setItems(exchangeRates);
        exchangeRateTableViewFromRON.setItems(exchangeRates);
        exchangeRateTableViewFromRUB.setItems(exchangeRates);
    }

    public void addRealExchangeRateButtonPushed() {
        exchangeRateController.createReal();
    }

    public void refreshChartRegionStatisticsButtonPushed() {
        long startTime = System.currentTimeMillis();
        pieChartForRegionStatistics.setData(statisticsController.getDataForRegionStatistics());
        long estimatedTime = System.currentTimeMillis() - startTime;
        regionStatisticsResponse.setText("Total time elapsed: " + (double)estimatedTime/1000 + " seconds");
    }

    public void refreshChartCityStatisticsButtonPushed() {
        long startTime = System.currentTimeMillis();
        pieChartForCityStatistics.setData(statisticsController.getDataForCityStatistics());
        long estimatedTime = System.currentTimeMillis() - startTime;
        cityStatisticsResponse.setText("Total time elapsed: " + (double)estimatedTime/1000 + " seconds");
    }

    public void findEmplyeeByIdButtonPushed() {
        StaffController staffController = new StaffController();
        staffResponse.setText(isNumeric(idForEmployeeToFind.getText())?staffController.findById(Integer.parseInt(idForEmployeeToFind.getText())):"invalid id");
    }

    public void getEmployeeOfTheMonthButtonPushed() {
        StaffController staffController = new StaffController();
        int month = Datas.monthsLongFormDecoder.get(monthListForEmployee.getValue().toString());
        int year = Integer.parseInt(yearListForEmployee.getValue().toString());
        int reward= Integer.parseInt(rewardEmployeeWith.getText());
        staffResponse.setText(staffController.employeeOfTheMonth(month, year, reward));
    }

    public void increaseSalaryButtonPushed() {
        StaffController staffController = new StaffController();
        if(!Datas.isNumeric(idEmployeeToIncreaseSalary.getText()) || !Datas.isNumeric(amountToIncreaseSalary.getText())) {
            staffResponse.setText("wrong parameters");
        } else {
            int id = Integer.parseInt(idEmployeeToIncreaseSalary.getText());
            int amount = Integer.parseInt(amountToIncreaseSalary.getText());
            staffResponse.setText(staffController.salaryIncrease(id, amount));
        }
    }

    private void showFromPage(String page){
        page = page.replaceAll(",", "");
        CustomerController customerController = new CustomerController();

        ArrayList<String> customers = customerController.getCustomersIdsFromPage(page , CustomerView.numberOfCustomersInPage);

        ObservableList<Customer> customersAux = FXCollections.observableArrayList();

        for (String customer : customers) {
            customersAux.add((Customer) customerController.getCustomerById(customer));
            System.out.println(customerController.getCustomerById(customer));
        }

        customerTableView.setItems(customersAux);
    }

    private String addToStringAndRemainPozitive(String initial, int add) {
        int result = Integer.parseInt(initial.replaceAll(",", "")) + add;
        if(result <  1)
            result = 1;
        return String.valueOf(result);
    }

    private void handlePages(int add) {
        if(customerFromIndex.getText().equals("")) {
            if(add < 0)
            {
                showFromPage("1");
                customerFromIndex.setText("1");
            } else {
                lastPageCustomerButtonPushed();
            }
        } else {
            String page = addToStringAndRemainPozitive(customerFromIndex.getText(), add);
            showFromPage(page);
            customerFromIndex.setText(page);
        }
    }

    public void showCustomersButtonPushed() {
        if(customerFromIndex != null)
            showFromPage(customerFromIndex.getText());
        else
            showFromPage("1");
    }

    public void smallerSignCustomerButtonPushed(){
        handlePages(-1);
    }

    public void muchSmallerSignCustomerButtonPushed(){
        handlePages(-10);
    }

    public void biggerSignCustomerButtonPushed(){
        handlePages(1);
    }

    public void muchBiggerSignCustomerButtonPushed(){
        handlePages(10);
    }

    public void lastPageCustomerButtonPushed(){
        int numberOfCustomers = CustomerController.getCustomersIds().size();
        String page = String.valueOf((int) Math.ceil((double)numberOfCustomers / (double)CustomerView.numberOfCustomersInPage));
        customerFromIndex.setText(page);
        showFromPage(page);
    }

    public void getCustomerSQLInjectionButtonPushed(){
        CustomerController customerController = new CustomerController();
        customerResponse.setText(customerController.getCustomersWithIdForDemonstratingSQLInjection(idCustomerTextField.getText()).toString());
    }

    public void getCustomerButtonPushed() {
        CustomerController customerController = new CustomerController();
        customerResponse.setText(customerController.getCustomerById(idCustomerTextField.getText()).toString());
    }

    public void newCustomerButtonPushed(){
        CustomerController customerController = new CustomerController();

        customerResponse.setText(customerController.create(customerFirstNameTextField.getText(), customerLastNameTextField.getText(), customerCityTextField.getText(),  customerEmailTextField.getText(),
                customerPhoneNumberTextField.getText(), Datas.extractDateInSQLFormFromLocalDate(customerDateOfBirthDateField.getValue()), "Normal", 0));
    }

    //(int id, String firstName, String lastName, String city, String email, String phoneNumber)
    public void updateCustomerButtonPushed() {
        CustomerController customerController = new CustomerController();
        customerResponse.setText(customerController.update(idCustomerTextField.getText(), customerFirstNameTextField.getText(), customerLastNameTextField.getText(), customerCityTextField.getText(),
                customerEmailTextField.getText(), customerPhoneNumberTextField.getText()));
    }

    public void newBankButtonPushed(){
        BankView.newBankButtonPushed(bankCityTextField.getText(), bankAddressTextField.getText(), bankNameTextField.getText());
        bankTableView.setItems(banks);
        bankResponse.setText(BankView.getBankByIdButtonPushed(idBankTextField.getText()));
    }

    public void updateBankButtonPushed(){
        BankView.updateBankButtonPushed(idBankTextField.getText(), bankCityTextField.getText(), bankAddressTextField.getText(), bankNameTextField.getText());
        bankTableView.setItems(banks);
        bankResponse.setText(BankView.getBankByIdButtonPushed(idBankTextField.getText()));
    }

    public void getBankButtonPushed() {
        bankResponse.setText(BankView.getBankByIdButtonPushed(idBankTextField.getText()));
    }
}
