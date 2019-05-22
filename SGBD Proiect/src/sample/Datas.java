package sample;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class Datas {
    public static ArrayList<String> monthsLongForm = new ArrayList<String>(Arrays.asList("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"));

    public static final ArrayList<Integer> days = new ArrayList<Integer>(
            Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19));

    //04-DEC-56  //dd-MMM-yy
    //1968-02-05 00:00:00
    public static DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd 00:00:00");


    public static Map<String, String> monthsShortForm = Collections.unmodifiableMap(
            new HashMap<String, String>() {{
                put("01", "JAN");
                put("02", "FEB");
                put("03", "MAR");
                put("04", "APR");
                put("05", "MAY");
                put("06", "JUN");
                put("07", "JUL");
                put("08", "AUG");
                put("09", "SEP");
                put("10", "OCT");
                put("11", "NOV");
                put("12", "DEC");
            }});

    public static Map<Integer, String> Numbers = Collections.unmodifiableMap(
            new HashMap<Integer, String>() {{
                put(0, "0");
                put(1, "1");
                put(2, "2");
                put(3, "3");
                put(4, "4");
                put(5, "5");
                put(6, "6");
                put(7, "7");
                put(8, "8");
                put(9, "9");
                put(10, "10");
                put(11, "11");
                put(12, "12");
                put(13, "13");
                put(14, "14");
                put(15, "15");
                put(16, "16");
                put(17, "17");
                put(18, "18");
                put(19, "19");
                put(20, "20");
                put(21, "21");
                put(22, "22");
                put(23, "23");
                put(24, "24");
                put(25, "25");
                put(26, "26");
                put(27, "27");
                put(28, "28");
                put(29, "29");
            }});


    public static String extractDateInSQLFormFromLocalDate(LocalDate localDate)
    {
        if(localDate == null)
            return "";

        StringBuilder dateinSql = new StringBuilder();
        String dateInitial = localDate.toString();

        StringBuilder monthNumber = new StringBuilder();
        monthNumber.append(dateInitial.charAt(5))
                .append(dateInitial.charAt(6));

        String monthWord = Datas.monthsShortForm.get(monthNumber.toString()) ;

        dateinSql.append(dateInitial.charAt(8))
                .append(dateInitial.charAt(9))
                .append("-");

        dateinSql.append(monthWord);

        dateinSql.append("-")
                .append(dateInitial.charAt(2))
                .append(dateInitial.charAt(3));

        return dateinSql.toString();
    }
}
