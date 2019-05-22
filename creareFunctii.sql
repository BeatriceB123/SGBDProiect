CREATE INDEX transaction_date_index
on transaction_history(transaction_date); 

CREATE INDEX eotm
on transaction_history(id_staff, transaction_date); 

CREATE INDEX eotm2
on staff(job_position, id_staff); 

CREATE OR REPLACE FUNCTION new_customer(
    p_f_name IN VARCHAR2, p_l_name IN VARCHAR2, p_city IN VARCHAR2, p_email IN VARCHAR2, p_phone_number IN VARCHAR2, p_date_of_birth IN DATE, p_account_type IN VARCHAR2, p_value IN INT)
RETURN VARCHAR2
AS
  v_id customer.id_customer%type;
  v_id_bank bank_account.id_account%type;
BEGIN
  SELECT * INTO v_id FROM (SELECT count(*) FROM customer);
  SELECT * INTO v_id_bank FROM (SELECT count(*) FROM bank_account);
  v_id := v_id + 1;
  v_id_bank := v_id_bank + 1;
  INSERT INTO customer VALUES (v_id, p_f_name, p_l_name, p_city, p_email, p_phone_number, p_date_of_birth, NULL, NULL);
  INSERT INTO bank_account VALUES (v_id_bank, v_id, p_account_type, p_value, NULL, NULL);
  COMMIT;
  return 'Successfully created new customer.';
END;
/

CREATE OR REPLACE FUNCTION update_customer(
    p_id_customer IN INT, p_f_name IN VARCHAR2, p_l_name IN VARCHAR2, p_city IN VARCHAR2, p_email IN VARCHAR2, p_phone_number IN VARCHAR2)
RETURN VARCHAR2
AS
  v_f_name customer.f_name%type;
  v_l_name customer.l_name%type;
  v_city customer.city%type;
  v_email customer.email%type;
  v_phone_number customer.phone_number%type;
BEGIN
  IF (p_id_customer IS NULL) THEN
    return 'Customer id cannot be null';
  END IF;
  IF (p_f_name IS NULL) THEN
    SELECT * INTO v_f_name FROM (SELECT f_name FROM customer WHERE id_customer = p_id_customer);
    ELSE v_f_name := p_f_name;
  END IF;
  IF (p_l_name IS NULL) THEN
    SELECT * INTO v_l_name FROM (SELECT l_name FROM customer WHERE id_customer = p_id_customer);
    ELSE v_l_name := p_l_name;
  END IF;
  IF (p_email IS NULL) THEN
    SELECT * INTO v_email FROM (SELECT email FROM customer WHERE id_customer = p_id_customer);
    ELSE v_email := p_email;
  END IF;
  IF (p_city IS NULL) THEN
    SELECT * INTO v_city FROM (SELECT city FROM customer WHERE id_customer = p_id_customer);
    ELSE v_city := p_city;
  END IF;
  IF (p_phone_number IS NULL) THEN
    SELECT * INTO v_phone_number FROM (SELECT phone_number FROM customer WHERE id_customer = p_id_customer);
    ELSE v_phone_number := p_phone_number;
  END IF;
  UPDATE customer SET f_name = v_f_name, l_name = v_l_name, city = v_city, email = v_email, phone_number = v_phone_number WHERE id_customer = p_id_customer;
  COMMIT;
  return 'Successfully updated customer.';
END;
/

CREATE OR REPLACE FUNCTION new_staff(
    p_id_bank IN INT, p_f_name IN VARCHAR2, p_l_name IN VARCHAR2, p_city IN VARCHAR2, p_email IN VARCHAR2, p_phone_number IN VARCHAR2, p_date_of_birth IN DATE, p_job_position IN VARCHAR2, p_salary IN INT)
RETURN VARCHAR2
AS
  v_id staff.id_staff%type;
BEGIN
  SELECT * INTO v_id FROM (SELECT count(*) FROM staff);
  v_id := v_id + 1;
  INSERT INTO staff VALUES (v_id, p_id_bank, p_f_name, p_l_name, p_city, p_email, p_phone_number, p_date_of_birth, p_job_position, p_salary, NULL, NULL);
  COMMIT;
  return 'Successfully created new staff member.';
END;
/

CREATE OR REPLACE FUNCTION update_staff(
    p_id_staff IN INT, p_id_bank IN INT, p_f_name IN VARCHAR2, p_l_name IN VARCHAR2, p_city IN VARCHAR2, p_email IN VARCHAR2, p_phone_number IN VARCHAR2, p_job_position IN VARCHAR2)
RETURN VARCHAR2
AS
  v_id_bank staff.id_bank%type;
  v_f_name staff.f_name%type;
  v_l_name staff.l_name%type;
  v_city staff.city%type;
  v_email staff.email%type;
  v_phone_number staff.phone_number%type;
  v_job_position staff.job_position%type;
BEGIN
  IF (p_id_staff IS NULL) THEN
    return 'Staff id cannot be null';
  END IF;
  IF (p_f_name IS NULL) THEN
    SELECT * INTO v_f_name FROM (SELECT f_name FROM staff WHERE id_staff = p_id_staff);
    ELSE v_f_name := p_f_name;
  END IF;
  IF (p_l_name IS NULL) THEN
    SELECT * INTO v_l_name FROM (SELECT l_name FROM staff WHERE id_staff = p_id_staff);
    ELSE v_l_name := p_l_name;
  END IF;
  IF (p_email IS NULL) THEN
    SELECT * INTO v_email FROM (SELECT email FROM staff WHERE id_staff = p_id_staff);
    ELSE v_email := p_email;
  END IF;
  IF (p_city IS NULL) THEN
    SELECT * INTO v_city FROM (SELECT city FROM staff WHERE id_staff = p_id_staff);
    ELSE v_city := p_city;
  END IF;
  IF (p_phone_number IS NULL) THEN
    SELECT * INTO v_phone_number FROM (SELECT phone_number FROM staff WHERE id_staff = p_id_staff);
    ELSE v_phone_number := p_phone_number;
  END IF;
  IF (p_job_position IS NULL) THEN
    SELECT * INTO v_job_position FROM (SELECT job_position FROM staff WHERE id_staff = p_id_staff);
    ELSE v_job_position := p_job_position;
  END IF;
  IF (p_id_bank IS NULL) THEN
    SELECT * INTO v_id_bank FROM (SELECT id_bank FROM staff WHERE id_staff = p_id_staff);
    ELSE v_id_bank := p_id_bank;
  END IF;
  UPDATE staff SET f_name = v_f_name, l_name = v_l_name, city = v_city, email = v_email, phone_number = v_phone_number, job_position = v_job_position,
  id_bank = v_id_bank WHERE id_staff = p_id_staff;
  COMMIT;
  return 'Successfully updated staff member.';
END;
/

CREATE OR REPLACE FUNCTION new_account(
    p_id_customer IN INT, p_account_type IN VARCHAR2, p_value IN INT)
RETURN VARCHAR2
AS
  v_id_bank bank_account.id_account%type;
BEGIN
  SELECT * INTO v_id_bank FROM (SELECT count(*) FROM bank_account);
  v_id_bank := v_id_bank + 1;
  INSERT INTO bank_account VALUES (v_id_bank, p_id_customer, p_account_type, p_value, NULL, NULL);
  COMMIT;
  return 'Successfully created new bank account.';
END;
/

CREATE OR REPLACE FUNCTION update_account(
    p_id_account IN INT, p_account_type IN VARCHAR2, p_value IN INT)
RETURN VARCHAR2
AS
  v_account_type bank_account.account_type%type;
  v_monetary_value bank_account.monetary_value%type;
BEGIN
  IF (p_id_account IS NULL) THEN
    return 'Account id cannot be null';
  END IF;
  IF (p_account_type IS NULL) THEN
    SELECT * INTO v_account_type FROM (SELECT account_type FROM bank_account WHERE id_account = p_id_account);
    ELSE v_account_type := p_account_type;
  END IF;
  IF (p_value IS NULL) THEN
    SELECT * INTO v_monetary_value FROM (SELECT monetary_value FROM bank_account WHERE id_account = p_id_account);
    ELSE v_monetary_value := p_value;
  END IF;
  UPDATE bank_account SET account_type = v_account_type, monetary_value = v_monetary_value WHERE id_account = p_id_account;
  COMMIT;
  return 'Successfully updated bank account.';
END;
/

CREATE OR REPLACE FUNCTION new_bank(
    p_city IN VARCHAR2, p_address IN VARCHAR2, p_name IN VARCHAR2)
RETURN VARCHAR2
AS
  v_id_bank bank.id_bank%type;
BEGIN
  SELECT * INTO v_id_bank FROM (SELECT count(*) FROM bank);
  v_id_bank := v_id_bank + 1;
  INSERT INTO bank VALUES (v_id_bank, p_city, p_address, p_name, NULL, NULL);
  COMMIT;
  return 'Successfully created new bank.';
END;
/

CREATE OR REPLACE FUNCTION update_bank(
    p_id_bank IN INT, p_city IN VARCHAR2, p_address IN VARCHAR2, p_name IN VARCHAR2)
RETURN VARCHAR2
AS
  v_city bank.city%type;
  v_address bank.address%type;
  v_name bank.name%type;
BEGIN
  IF (p_id_bank IS NULL) THEN
    return 'Bank id cannot be null';
  END IF;
  IF (p_name IS NULL) THEN
    SELECT * INTO v_name FROM (SELECT name FROM bank WHERE id_bank = p_id_bank);
    ELSE v_name := p_name;
  END IF;
  IF (p_city IS NULL) THEN
    SELECT * INTO v_city FROM (SELECT city FROM bank WHERE id_bank = p_id_bank);
    ELSE v_city := p_city;
  END IF;
  IF (p_address IS NULL) THEN
    SELECT * INTO v_address FROM (SELECT address FROM bank WHERE id_bank = p_id_bank);
    ELSE v_address := p_address;
  END IF;
  UPDATE bank SET name = v_name, city = v_city, address = v_address WHERE id_bank = p_id_bank;
  COMMIT;
  return 'Successfully updated bank.';
END;
/

CREATE OR REPLACE FUNCTION add_exchange_rate(
    GBP_to_EUR IN FLOAT, GBP_to_RON IN FLOAT, GBP_to_RUB IN FLOAT,
    EUR_to_GBP IN FLOAT, EUR_to_RON IN FLOAT, EUR_to_RUB IN FLOAT,
    RON_to_GBP IN FLOAT, RON_to_EUR IN FLOAT, RON_to_RUB IN FLOAT,
    RUB_to_GBP IN FLOAT, RUB_to_EUR IN FLOAT, RUB_to_RON IN FLOAT)
RETURN VARCHAR2
AS
  v_id exchange_rate.id_rate%type;
BEGIN
  SELECT * INTO v_id FROM (SELECT count(*) FROM exchange_rate);
  v_id := v_id + 1;
  INSERT INTO exchange_rate VALUES (v_id, 'GBP', 1, GBP_to_EUR, GBP_to_RON, GBP_to_RUB, NULL, NULL);
  INSERT INTO exchange_rate VALUES (v_id + 1, 'EUR', EUR_to_GBP, 1, EUR_to_RON, EUR_to_RUB, NULL, NULL);
  INSERT INTO exchange_rate VALUES (v_id + 2, 'RON', RON_to_GBP, RON_to_EUR, 1, RON_to_RUB, NULL, NULL);
  INSERT INTO exchange_rate VALUES (v_id + 3, 'RUB', RUB_to_GBP, RUB_to_EUR, RUB_to_RON, 1, NULL, NULL);
  COMMIT;
  return 'Successfully added the new exchange rates.';
END;
/

CREATE OR REPLACE FUNCTION account_freeze(p_id_account IN INT)
RETURN VARCHAR2
AS
BEGIN
  IF (p_id_account IS NULL) THEN
    return 'Account id cannot be null';
  END IF;
  UPDATE bank_account SET account_type = 'Frozen' WHERE id_account = p_id_account;
  COMMIT;
  return 'Given account has been successfully frozen';
END;
/

CREATE OR REPLACE PROCEDURE account_check(p_id_account IN INT, p_message OUT VARCHAR2)
AS
  v_nr_transactions INT;
  v_today DATE;
BEGIN
  IF (p_id_account IS NULL) THEN
    p_message := 'Account id cannot be null';
  END IF;
  v_today := to_date(sysdate,'DD-MON-YY');
  SELECT * INTO v_nr_transactions FROM (SELECT COUNT(*) FROM transaction_history WHERE id_account_from = p_id_account AND transaction_date LIKE v_today);
  IF(v_nr_transactions > 10) THEN
  UPDATE bank_account SET account_type = 'Frozen' WHERE id_account = p_id_account;
  COMMIT;
  p_message := 'Too many transactions registered today. Account has been frozen.';
  END IF;
  p_message := 'Status is ok, only '||v_nr_transactions||' transactions found for today';
END;
/

CREATE OR REPLACE FUNCTION add_transaction(
    p_id_bank IN INT, p_id_staff IN INT, p_id_account_from IN INT, p_id_account_to IN INT, p_currency IN VARCHAR2, p_transaction_type IN VARCHAR2, p_money_amount IN INT)
RETURN VARCHAR2
AS
  v_id_transaction transaction_history.id_transaction%type;
  v_id_rate exchange_rate.id_rate%type;
  v_msg VARCHAR2(100);
BEGIN
  v_msg := account_check(p_id_account_from);
  IF (v_msg = 'Too many transactions registered today. Account has been frozen.') THEN
    return 'Transaction failed. Account is frozen due to a suspicious number of transactions made recently.';
  END IF;
  SELECT * INTO v_id_transaction FROM (SELECT count(*) FROM transaction_history);
  SELECT * INTO v_id_rate FROM (SELECT count(*) FROM exchange_rate);
  CASE
    WHEN p_currency = 'GBP' THEN
      v_id_rate := v_id_rate - 3;
    WHEN p_currency = 'EUR' THEN
      v_id_rate := v_id_rate - 2;
    WHEN p_currency = 'RON' THEN
      v_id_rate := v_id_rate - 1;
    WHEN p_currency = 'RUB' THEN
      v_id_rate := v_id_rate - 0;
    ELSE return 'Invalid currency type';
    END CASE;
  INSERT INTO transaction_history VALUES (v_id_transaction + 1, p_id_bank, p_id_staff, p_id_account_from, p_id_account_to, v_id_rate, p_transaction_type, sysdate, TO_CHAR(SYSDATE,'hh24:mi'), p_money_amount, NULL, NULL);
  return 'Transaction finished successfully';
END;
/

CREATE OR REPLACE FUNCTION most_active_day(month_number IN INT, year_number IN INT) RETURN VARCHAR2 AS
  TYPE varr IS VARRAY(1000) OF varchar2(255);
  v_month VARCHAR2(4);
  v_transaction_number INT;
  v_transaction_total INT;
  v_number_aux INT;
  v_total_aux INT;
  v_year INT;
  v_month_list varr := varr('JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC');
  v_day INT;
BEGIN
  IF(year_number < 2018 OR year_number > 2050) THEN
    return 'Invalid year';
  END IF;
  v_day := 0;
  v_year := SUBSTR(year_number, 3, 4);
  v_transaction_number := 0;
  v_transaction_total := 0;
  IF(month_number < 1 OR month_number > 12) THEN
    return 'Invalid month number';
  END IF;
  v_month := v_month_list(month_number);
  FOR v_i IN 1..31 LOOP
    v_number_aux := 0;
    v_total_aux := 0;
    IF(v_i < 10) THEN
      SELECT * INTO v_number_aux FROM (SELECT COUNT(*) FROM transaction_history WHERE transaction_date LIKE '0'||v_i||'-'||v_month||'-'||v_year);
    ELSIF (v_i >= 10) THEN
      SELECT * INTO v_number_aux FROM (SELECT COUNT(*) FROM transaction_history WHERE transaction_date LIKE v_i||'-'||v_month||'-'||v_year);
    END IF;
    IF (v_number_aux > v_transaction_number) THEN
      v_transaction_number := v_number_aux;
      v_day := v_i;
    END IF;
  END LOOP;
  IF (v_day = 0) THEN return 'No transactions found';
  ELSE
  return 'Most active day is day number '||v_day||' with '||v_transaction_number||' total transactions made.';
  END IF;
END;
/
 
CREATE OR REPLACE FUNCTION monthly_money_sum(month_number IN INT, year_number IN INT) RETURN VARCHAR2 AS
  TYPE varr IS VARRAY(1000) OF varchar2(255);
  v_month VARCHAR2(4);
  v_total_RON INT;
  v_total_EUR INT;
  v_total_RUB INT;
  v_total_GBP INT;
  v_year INT;
  v_month_list varr := varr('JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC');
  v_total INT;
BEGIN  
  IF(year_number < 2018 OR year_number > 2050) THEN
    return 'Invalid year';
  END IF;
  v_year := SUBSTR(year_number, 3, 4);
  v_total_RON := 0;
  v_total_EUR := 0;
  v_total_GBP := 0;
  v_total_RUB := 0;
  v_total := 0;
  IF(month_number < 1 OR month_number > 12) THEN
    return 'Invalid month number';
  END IF;
  v_month := v_month_list(month_number);
  FOR v_i IN (SELECT t.money_amount, e.initial_currency, e.to_RON FROM transaction_history t JOIN exchange_rate e ON e.id_rate = t.id_rate WHERE transaction_date LIKE '%'||v_month||'-'||v_year)
  LOOP
    CASE
      WHEN v_i.initial_currency = 'GBP' THEN v_total_GBP := v_total_GBP + ABS(v_i.money_amount);
      WHEN v_i.initial_currency = 'EUR' THEN v_total_EUR := v_total_EUR + ABS(v_i.money_amount);
      WHEN v_i.initial_currency = 'RON' THEN v_total_RON := v_total_RON + ABS(v_i.money_amount);
      WHEN v_i.initial_currency = 'RUB' THEN v_total_RUB := v_total_RUB + ABS(v_i.money_amount);
    END CASE;
    v_total := v_total + ABS(v_i.money_amount) * v_i.to_RON;
  END LOOP;
  IF (v_total = 0) THEN return 'No transactions found';
  ELSE return 'In the given month and year, the RON transactions add up to '||v_total_RON||', the GBP transactions add up to '||v_total_GBP||
  ', the EUR transactions add up to '||v_total_EUR||' and the RUB transactions add up to '||v_total_RUB||'. Converted total is '||v_total||' RON.';
  END IF;
END;
/

CREATE OR REPLACE FUNCTION salary_increase(
    p_id_staff IN INT, p_increase IN INT)
RETURN VARCHAR2
AS
BEGIN
  IF (p_id_staff IS NULL) THEN
    return 'Staff id cannot be null';
  END IF;
  IF (p_increase IS NULL) THEN
    return 'The value cannot be null';
  END IF;
  UPDATE staff SET salary = salary + p_increase WHERE id_staff = p_id_staff;
  COMMIT;
  return 'Successfully increased the salary of given staff member.';
END;
/

CREATE OR REPLACE FUNCTION employee_of_the_month(month_number IN INT, year_number IN INT, raise_value IN INT) RETURN VARCHAR2 AS
  TYPE varr IS VARRAY(1000) OF varchar2(255);
  v_month VARCHAR2(4);
  v_number_of_transactions INT;
  v_number_of_transactions_aux INT;
  v_id_staff staff.id_staff%type;
  v_year INT;
  v_month_list varr := varr('JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC');
  v_msg VARCHAR2(500);
BEGIN
  IF(year_number < 2018 OR year_number > 2050) THEN
    return 'Invalid year';
  END IF;
  IF(raise_value < 0 OR raise_value > 500 OR raise_value = NULL) THEN
    return 'Invalid raise value';
  END IF;
  v_number_of_transactions := 0;
  v_number_of_transactions_aux := 0;
  v_id_staff := 0;
  v_year := SUBSTR(year_number, 3, 4);
  IF(month_number < 1 OR month_number > 12) THEN
    return 'Invalid month number';
  END IF;
  v_month := v_month_list(month_number);
  FOR v_i IN (SELECT id_staff FROM staff WHERE job_position IN ('Consultant','Teller')) LOOP
    SELECT * INTO v_number_of_transactions_aux FROM (SELECT COUNT(*) FROM transaction_history WHERE id_staff = v_i.id_staff AND transaction_date LIKE '%'||v_month||'-'||v_year);
    IF(v_number_of_transactions_aux > v_number_of_transactions) THEN
      v_number_of_transactions := v_number_of_transactions_aux;
      v_id_staff := v_i.id_staff;
    END IF;
  END LOOP;
  v_msg := salary_increase(v_id_staff, raise_value);
  IF(v_id_staff = 0) THEN return 'No transactions found in that given month and year'; 
  ELSE return 'Employee of the month is the employee with id '||v_id_staff||' and has been successfully given a raise.';
  END IF;
END;
/
