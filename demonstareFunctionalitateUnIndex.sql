set serveroutput on; 
begin 
  DBMS_OUTPUT.PUT_LINE(most_active_day_with_select(12, 2018));
end; 

CREATE INDEX transaction_date_index on transaction_history(transaction_date); 
CREATE INDEX eotm on transaction_history(id_staff, transaction_date);

drop index transaction_date_index; 
drop index EOTM; 

  SELECT "NUMBER", extract(DAY FROM transaction_date)
FROM
  (SELECT COUNT(*) AS "NUMBER",
    transaction_date
  FROM transaction_history
  WHERE extract(YEAR FROM transaction_date) = 2018
  AND extract(MONTH FROM transaction_Date)  = 12
  GROUP BY TRANSACTION_DATE
  ORDER BY "NUMBER" DESC
  )
WHERE rownum < 2;