package controllers;

import database.Database;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.chart.PieChart;

import java.math.BigInteger;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


public class StatisticsController {
    private ObservableList<PieChart.Data> data= FXCollections.observableArrayList();

    private void initializeDataAboutCity()
    {
        Map<String, Integer> dataFromDatabase = getCityTransactionDatasAsMap();
        for (Map.Entry<String, Integer> entry : dataFromDatabase.entrySet()) {
            System.out.println(entry.getKey() + "/" + entry.getValue());
            data.add(new PieChart.Data(entry.getKey(),entry.getValue()));
        }
    }

    private static Map<String, Integer> getCityTransactionDatasAsMap(){
        Map<String, Integer> dataFromDatabase = new HashMap<>();
        Connection con = Database.getConnection();
        String call = "{ ? = call get_city_transaction_datas() }";
        CallableStatement statement = null;
        System.out.println("Datas: "  + "NONE");
        try {
            statement = con.prepareCall(call);
            statement.registerOutParameter(1, Types.VARCHAR);
            statement.execute();
            String sqlOutput =  statement.getString(1);
            System.out.println("Datas: "  + sqlOutput);

            String lastKey = "";
            StringBuilder curentValue = new StringBuilder("");
            for(int i = 0 ; i < sqlOutput.length() ; ++i)
            {
                if(sqlOutput.charAt(i) == '*')
                {
                    if(lastKey.equals("")) //we have here a key
                        lastKey = curentValue.toString();
                    else //we have a value for last key
                    {
                        dataFromDatabase.put(lastKey, Integer.parseInt(curentValue.toString()));
                        lastKey = "";
                    }
                    curentValue = new StringBuilder("");
                }
                else
                    curentValue.append(sqlOutput.charAt(i));
            }
        } catch (SQLException e) {
            String[] result = e.getMessage().split("\\R", 2);
        }
        return dataFromDatabase;
    }

    public ObservableList<PieChart.Data> getData(){
        initializeDataAboutCity();
        return data;
    }

}
