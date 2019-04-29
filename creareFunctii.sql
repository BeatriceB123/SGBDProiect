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
    p_id_staff IN INT, p_id_bank IN INT, p_f_name IN VARCHAR2, p_l_name IN VARCHAR2, p_city IN VARCHAR2, p_email IN VARCHAR2, p_phone_number IN VARCHAR2, p_job_position IN VARCHAR2, p_salary IN VARCHAR2)
RETURN VARCHAR2
AS
  v_id_bank staff.id_bank%type;
  v_f_name staff.f_name%type;
  v_l_name staff.l_name%type;
  v_city staff.city%type;
  v_email staff.email%type;
  v_phone_number staff.phone_number%type;
  v_job_position staff.job_position%type;
  v_salary staff.salary%type;
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
  IF (p_salary IS NULL) THEN
    SELECT * INTO v_salary FROM (SELECT salary FROM staff WHERE id_staff = p_id_staff);
    ELSE v_salary := p_salary;
  END IF;
  IF (p_id_bank IS NULL) THEN
    SELECT * INTO v_id_bank FROM (SELECT salary FROM staff WHERE id_staff = p_id_staff);
    ELSE v_id_bank := p_id_bank;
  END IF;
  UPDATE staff SET f_name = v_f_name, l_name = v_l_name, city = v_city, email = v_email, phone_number = v_phone_number, job_position = v_job_position,
  id_bank = v_id_bank, salary = v_salary WHERE id_staff = p_id_staff;
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

CREATE OR REPLACE FUNCTION add_transaction(
    p_id_bank IN INT, p_id_staff IN INT, p_id_account_from IN INT, p_id_account_to IN INT, p_currency IN VARCHAR2, p_transaction_type IN VARCHAR2, p_date IN DATE, p_hour IN VARCHAR2, p_money_amount IN INT)
RETURN VARCHAR2
AS
  v_id_transaction transaction_history.id_transaction%type;
  v_id_rate exchange_rate.id_rate%type;
BEGIN
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
  INSERT INTO transaction_history VALUES (v_id_transaction + 1, p_id_bank, p_id_staff, p_id_account_from, p_id_account_to, v_id_rate, p_transaction_type, p_date, p_hour, p_money_amount, NULL, NULL);
  return 'Transaction finished successfully';
END;
/