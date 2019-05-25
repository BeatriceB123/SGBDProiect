package sample;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class Datas {
    public static ArrayList<String> monthsLongForm = new ArrayList<String>(Arrays.asList("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"));

    public static Map<String, Integer> monthsLongFormDecoder = Collections.unmodifiableMap(
            new HashMap<String, Integer>() {{
                put("January", 1);
                put("February", 2);
                put("March", 3);
                put("April", 4);
                put("May", 5);
                put("June", 6);
                put("July", 7);
                put("August", 8);
                put("September", 9);
                put("October", 10);
                put("November", 11);
                put("December", 12);
            }});



    public static final ArrayList<Integer> years = new ArrayList<Integer>(
            Arrays.asList(1950, 1951, 1952, 1953, 1954, 1955, 1956, 1957, 1958, 1959, 1960, 1961, 1962, 1963, 1964, 1965, 1966, 1967, 1968, 1969, 1970, 1971, 1972, 1973, 1974, 1975, 1976, 1977, 1978, 1979, 1980, 1981, 1982, 1983, 1984, 1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020));

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

    public static boolean isNumeric(String str) {
        return str.matches("-?\\d+(\\.\\d+)?");  //match a number with optional '-' and decimal.
    }
}
