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

    public static String extractDateInSQLFormFromLocalDate(LocalDate localDate)
    {
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
