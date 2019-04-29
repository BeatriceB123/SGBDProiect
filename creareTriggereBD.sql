--prevents the user from dropping any table. Replace 'dba2' with current user's username.  
CREATE OR REPLACE TRIGGER drop_trigger
  BEFORE DROP ON dba2.SCHEMA
  BEGIN
    RAISE_APPLICATION_ERROR (
      num => -20000,
      msg => 'Cannot drop this table.');
  END;
/  

--the six following triggers prevent the deletion of data from all six tables
CREATE OR REPLACE TRIGGER delete_exchange_rate
  BEFORE DELETE ON exchange_rate
  BEGIN
    RAISE_APPLICATION_ERROR (
      num => -20001,
      msg => 'Cannot delete anything from exchange_rate table.');
  END;
/  
  
CREATE OR REPLACE TRIGGER delete_bank
  BEFORE DELETE ON bank
  BEGIN
    RAISE_APPLICATION_ERROR (
      num => -20002,
      msg => 'Cannot delete anything from bank table.');
  END;
/ 

CREATE OR REPLACE TRIGGER delete_staff
  BEFORE DELETE ON staff
  BEGIN
    RAISE_APPLICATION_ERROR (
      num => -20003,
      msg => 'Cannot delete anything from staff table.');
  END;
/ 

CREATE OR REPLACE TRIGGER delete_bank_account
  BEFORE DELETE ON bank_account
  BEGIN
    RAISE_APPLICATION_ERROR (
      num => -20004,
      msg => 'Cannot delete anything from bank_account table.');
  END;
/ 

CREATE OR REPLACE TRIGGER delete_customer
  BEFORE DELETE ON customer
  BEGIN
    RAISE_APPLICATION_ERROR (
      num => -20005,
      msg => 'Cannot delete anything from customer table.');
  END;
/ 

CREATE OR REPLACE TRIGGER delete_transaction_history
  BEFORE DELETE ON transaction_history
  BEGIN
    RAISE_APPLICATION_ERROR (
      num => -20006,
      msg => 'Cannot delete anything from transaction_history table.');
  END;
/ 
 
--the following triggers prevent updating data that should not be updated or with invalid data
CREATE OR REPLACE TRIGGER update_exchange_rate
  BEFORE UPDATE of id_rate, initial_currency, to_GBP, to_EUR, to_RON, to_RUB ON exchange_rate
  BEGIN
    RAISE_APPLICATION_ERROR (
      num => -20007,
      msg => 'Cannot update anything on exchange_rate table.');
  END;
/

CREATE OR REPLACE TRIGGER update_bank
  BEFORE UPDATE OF id_bank ON bank
  BEGIN
    RAISE_APPLICATION_ERROR (
      num => -20008,
      msg => 'Cannot update id on bank table.');
  END;
/  
  
CREATE OR REPLACE TRIGGER update_staff
  BEFORE UPDATE OF id_staff, date_of_birth ON staff
  BEGIN
    RAISE_APPLICATION_ERROR (
      num => -20009,
      msg => 'Cannot update id or date of birth on staff table.');
  END;
/   
  
CREATE OR REPLACE TRIGGER update_bank_account
  BEFORE UPDATE OF id_account, id_customer ON bank_account
  BEGIN
    RAISE_APPLICATION_ERROR (
      num => -20010,
      msg => 'Cannot update id_account or id_customer on bank_account table.');
  END;
/ 

CREATE OR REPLACE TRIGGER update_customer
  BEFORE UPDATE OF id_customer, date_of_birth ON customer
  BEGIN
    RAISE_APPLICATION_ERROR (
      num => -20011,
      msg => 'Cannot update id or date of birth on customer table.');
  END;
/    
  
CREATE OR REPLACE TRIGGER update_transaction_history
  BEFORE UPDATE of id_transaction, id_bank, id_staff, id_account_from, id_account_to, id_rate, transaction_type, transaction_date, transaction_hour, money_amount ON transaction_history
  BEGIN
    RAISE_APPLICATION_ERROR (
      num => -20012,
      msg => 'Cannot update anything on transaction_history table.');
  END;
/   
  
SET DEFONE OFF;
CREATE OR REPLACE TRIGGER update_staff_rows
  FOR UPDATE OF salary, job_position, f_name, l_name, phone_number, email, city ON staff
  COMPOUND TRIGGER
  v_id staff.id_staff%type;
  BEFORE EACH ROW IS
  BEGIN
    v_id := :OLD.id_staff;
    IF(:NEW.salary > :OLD.salary+700) THEN
    RAISE_APPLICATION_ERROR (
      num => -20013,
      msg => 'Illegal raise value detected.');
    END IF;
    IF(:NEW.job_position NOT IN('Intern','Teller','Administrator','Security','Cleaner','Consultant')) THEN
    RAISE_APPLICATION_ERROR (
      num => -20014,
      msg => 'Invalid job position detected.');
    END IF;
    IF(LENGTH(:NEW.phone_number)<>10 OR TRANSLATE(:NEW.phone_number,'0123456789','0000000000') <> '0000000000') THEN
    RAISE_APPLICATION_ERROR (
      num => -20015,
      msg => 'Invalid phone number detected.');
    END IF;
    IF(:NEW.email NOT LIKE '%@%.%') THEN
    RAISE_APPLICATION_ERROR (
      num => -20016,
      msg => 'Invalid email address detected.');
    END IF;
    IF(:NEW.f_name <>upper(SUBSTR(:NEW.f_name,1,1))||lower(SUBSTR(:NEW.f_name,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20017,
      msg => 'Invalid first name detected.');
    END IF;
    IF(:NEW.l_name <>upper(SUBSTR(:NEW.l_name,1,1))||lower(SUBSTR(:NEW.l_name,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20018,
      msg => 'Invalid last name detected.');
    END IF;
    IF(:NEW.city <>upper(SUBSTR(:NEW.city,1,1))||lower(SUBSTR(:NEW.city,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20019,
      msg => 'Invalid city name detected.');
    END IF;
    END BEFORE EACH ROW;
    
    AFTER STATEMENT IS BEGIN
      UPDATE staff SET updated_at = sysdate WHERE id_staff = v_id;
    END AFTER STATEMENT;
  END;
/  
 
SET DEFONE OFF;
CREATE OR REPLACE TRIGGER update_bank_rows
  FOR UPDATE OF city, name ON bank
  COMPOUND TRIGGER
  v_id bank.id_bank%type;
  BEFORE EACH ROW IS
  BEGIN
    v_id := :OLD.id_bank;
    IF(:NEW.name <>upper(SUBSTR(:NEW.name,1,1))||lower(SUBSTR(:NEW.name,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20020,
      msg => 'Invalid name detected.');
    END IF;
    IF(:NEW.city <>upper(SUBSTR(:NEW.city,1,1))||lower(SUBSTR(:NEW.city,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20021,
      msg => 'Invalid city name detected.');
    END IF;
    END BEFORE EACH ROW;
    
    AFTER STATEMENT IS BEGIN
      UPDATE bank SET updated_at = sysdate WHERE id_bank = v_id;
    END AFTER STATEMENT;
  END;
/  

SET DEFONE OFF;
CREATE OR REPLACE TRIGGER update_bank_account_rows
  FOR UPDATE OF account_type, monetary_value ON bank_account
  COMPOUND TRIGGER
  v_id bank_account.id_account%type;
  BEFORE EACH ROW IS
  BEGIN
    v_id := :OLD.id_account;
    IF(:NEW.monetary_value <> :OLD.monetary_value AND :NEW.account_type = 'Frozen') THEN
    RAISE_APPLICATION_ERROR (
      num => -20022,
      msg => 'Account is frozen.');
    END IF;
    IF(:NEW.monetary_value > :OLD.monetary_value+50000 OR :NEW.monetary_value < :OLD.monetary_value-50000) THEN
    RAISE_APPLICATION_ERROR (
      num => -20023,
      msg => 'Illegal deposit value detected.');
    END IF;
    IF(:NEW.account_type NOT IN('Zero','Normal','Savings','Retirement','Frozen')) THEN
    RAISE_APPLICATION_ERROR (
      num => -20024,
      msg => 'Invalid account type detected.');
    END IF;
    END BEFORE EACH ROW;
    
    AFTER STATEMENT IS BEGIN
      UPDATE bank_account SET updated_at = sysdate WHERE id_account = v_id;
    END AFTER STATEMENT;
  END;
/ 

SET DEFONE OFF;
CREATE OR REPLACE TRIGGER update_customer_rows
  FOR UPDATE OF f_name, l_name, phone_number, email, city ON customer
  COMPOUND TRIGGER
  v_id customer.id_customer%type;
  BEFORE EACH ROW IS
  BEGIN
    v_id := :OLD.id_customer;
    IF(LENGTH(:NEW.phone_number)<>10 OR TRANSLATE(:NEW.phone_number,'0123456789','0000000000') <> '0000000000') THEN
    RAISE_APPLICATION_ERROR (
      num => -20025,
      msg => 'Invalid phone number detected.');
    END IF;
    IF(:NEW.email NOT LIKE '%@%.%') THEN
    RAISE_APPLICATION_ERROR (
      num => -20026,
      msg => 'Invalid email address detected.');
    END IF;
    IF(:NEW.f_name <>upper(SUBSTR(:NEW.f_name,1,1))||lower(SUBSTR(:NEW.f_name,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20027,
      msg => 'Invalid first name detected.');
    END IF;
    IF(:NEW.l_name <>upper(SUBSTR(:NEW.l_name,1,1))||lower(SUBSTR(:NEW.l_name,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20028,
      msg => 'Invalid last name detected.');
    END IF;
    IF(:NEW.city <>upper(SUBSTR(:NEW.city,1,1))||lower(SUBSTR(:NEW.city,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20029,
      msg => 'Invalid city name detected.');
    END IF;
    END BEFORE EACH ROW;
    
    AFTER STATEMENT IS BEGIN
      UPDATE customer SET updated_at = sysdate WHERE id_customer = v_id;
    END AFTER STATEMENT;
  END;
/  

--the following triggers prevent inserting invalid or illegal data
SET DEFONE OFF;
CREATE OR REPLACE TRIGGER insert_customer
  FOR INSERT ON customer
  COMPOUND TRIGGER
  v_id customer.id_customer%type;
  BEFORE EACH ROW IS
  BEGIN
    v_id := :NEW.id_customer;
    IF(LENGTH(:NEW.phone_number)<>10 OR TRANSLATE(:NEW.phone_number,'0123456789','0000000000') <> '0000000000') THEN
    RAISE_APPLICATION_ERROR (
      num => -20030,
      msg => 'Invalid phone number detected.');
    END IF;
    IF(:NEW.email NOT LIKE '%@%.%') THEN
    RAISE_APPLICATION_ERROR (
      num => -20031,
      msg => 'Invalid email address detected.');
    END IF;
    IF(:NEW.f_name <>upper(SUBSTR(:NEW.f_name,1,1))||lower(SUBSTR(:NEW.f_name,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20032,
      msg => 'Invalid first name detected.');
    END IF;
    IF(:NEW.l_name <>upper(SUBSTR(:NEW.l_name,1,1))||lower(SUBSTR(:NEW.l_name,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20033,
      msg => 'Invalid last name detected.');
    END IF;
    IF(:NEW.city <>upper(SUBSTR(:NEW.city,1,1))||lower(SUBSTR(:NEW.city,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20034,
      msg => 'Invalid city name detected.');
    END IF;
    END BEFORE EACH ROW;
    
    AFTER STATEMENT IS BEGIN
      UPDATE customer SET created_at = sysdate WHERE id_customer = v_id;
      UPDATE customer SET updated_at = sysdate WHERE id_customer = v_id;
    END AFTER STATEMENT;
  END;
/  

SET DEFONE OFF;
CREATE OR REPLACE TRIGGER insert_bank_account
  FOR INSERT  ON bank_account
  COMPOUND TRIGGER
  v_id bank_account.id_account%type;
  BEFORE EACH ROW IS
  BEGIN
    v_id := :NEW.id_account;
    IF(:NEW.monetary_value > 100000 OR :NEW.monetary_value < 0) THEN
    RAISE_APPLICATION_ERROR (
      num => -20035,
      msg => 'Illegal deposit value detected.');
    END IF;
    IF(:NEW.account_type NOT IN('Zero','Normal','Savings','Retirement')) THEN
    RAISE_APPLICATION_ERROR (
      num => -20036,
      msg => 'Invalid account type detected.');
    END IF;
    END BEFORE EACH ROW;
    
    AFTER STATEMENT IS BEGIN
      UPDATE bank_account SET updated_at = sysdate WHERE id_account = v_id;
      UPDATE bank_account SET created_at = sysdate WHERE id_account = v_id;
    END AFTER STATEMENT;
  END;
/ 

SET DEFONE OFF;
CREATE OR REPLACE TRIGGER insert_bank
  FOR INSERT ON bank
  COMPOUND TRIGGER
  v_id bank.id_bank%type;
  BEFORE EACH ROW IS
  BEGIN
    v_id := :NEW.id_bank;
    IF(:NEW.name <>upper(SUBSTR(:NEW.name,1,1))||lower(SUBSTR(:NEW.name,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20037,
      msg => 'Invalid name detected.');
    END IF;
    IF(:NEW.city <>upper(SUBSTR(:NEW.city,1,1))||lower(SUBSTR(:NEW.city,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20038,
      msg => 'Invalid city name detected.');
    END IF;
    END BEFORE EACH ROW;
    
    AFTER STATEMENT IS BEGIN
      UPDATE bank SET updated_at = sysdate WHERE id_bank = v_id;
      UPDATE bank SET created_at = sysdate WHERE id_bank = v_id;
    END AFTER STATEMENT;
  END;
/  

SET DEFONE OFF;
CREATE OR REPLACE TRIGGER insert_staff
  FOR INSERT ON staff
  COMPOUND TRIGGER
  v_id staff.id_staff%type;
  BEFORE EACH ROW IS
  BEGIN
    v_id := :NEW.id_staff;
    IF(:NEW.salary > 10000) THEN
    RAISE_APPLICATION_ERROR (
      num => -20039,
      msg => 'Illegal salary value detected.');
    END IF;
    IF(:NEW.job_position NOT IN('Intern','Teller','Administrator','Security','Cleaner','Consultant')) THEN
    RAISE_APPLICATION_ERROR (
      num => -20040,
      msg => 'Invalid job position detected.');
    END IF;
    IF(LENGTH(:NEW.phone_number)<>10 OR TRANSLATE(:NEW.phone_number,'0123456789','0000000000') <> '0000000000') THEN
    RAISE_APPLICATION_ERROR (
      num => -20041,
      msg => 'Invalid phone number detected.');
    END IF;
    IF(:NEW.email NOT LIKE '%@%.%') THEN
    RAISE_APPLICATION_ERROR (
      num => -20042,
      msg => 'Invalid email address detected.');
    END IF;
    IF(:NEW.f_name <>upper(SUBSTR(:NEW.f_name,1,1))||lower(SUBSTR(:NEW.f_name,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20043,
      msg => 'Invalid first name detected.');
    END IF;
    IF(:NEW.l_name <>upper(SUBSTR(:NEW.l_name,1,1))||lower(SUBSTR(:NEW.l_name,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20044,
      msg => 'Invalid last name detected.');
    END IF;
    IF(:NEW.city <>upper(SUBSTR(:NEW.city,1,1))||lower(SUBSTR(:NEW.city,2))) THEN
    RAISE_APPLICATION_ERROR (
      num => -20045,
      msg => 'Invalid city name detected.');
    END IF;
    END BEFORE EACH ROW;
    
    AFTER STATEMENT IS BEGIN
      UPDATE staff SET updated_at = sysdate WHERE id_staff = v_id;
      UPDATE staff SET created_at = sysdate WHERE id_staff = v_id;
    END AFTER STATEMENT;
  END;
/  

SET DEFONE OFF;
CREATE OR REPLACE TRIGGER insert_exchange_rate
  FOR INSERT ON exchange_rate
  COMPOUND TRIGGER
  v_id exchange_rate.id_rate%type;
  BEFORE EACH ROW IS
  BEGIN
    v_id := :NEW.id_rate;
    IF(:NEW.initial_currency NOT IN('RUB','GBP','RON','EUR')) THEN
    RAISE_APPLICATION_ERROR (
      num => -20046,
      msg => 'Invalid currency type detected.');
    END IF;
    IF((:NEW.initial_currency = 'GBP' AND :NEW.to_GBP <> 1) OR :NEW.to_GBP <= 0) THEN
    RAISE_APPLICATION_ERROR (
      num => -20047,
      msg => 'Invalid GBP exchange rate detected.');
    END IF;
    IF((:NEW.initial_currency = 'EUR' AND :NEW.to_EUR <> 1) OR :NEW.to_EUR <= 0) THEN
    RAISE_APPLICATION_ERROR (
      num => -20048,
      msg => 'Invalid EUR exchange rate detected.');
    END IF;
    IF((:NEW.initial_currency = 'RON' AND :NEW.to_RON <> 1) OR :NEW.to_RON <= 0) THEN
    RAISE_APPLICATION_ERROR (
      num => -20049,
      msg => 'Invalid RON exchange rate detected.');
    END IF;
    IF((:NEW.initial_currency = 'RUB' AND :NEW.to_RUB <> 1) OR :NEW.to_RUB <= 0) THEN
    RAISE_APPLICATION_ERROR (
      num => -20050,
      msg => 'Invalid RUB exchange rate detected.');
    END IF;
    END BEFORE EACH ROW;
    
    AFTER STATEMENT IS BEGIN
      UPDATE exchange_rate SET updated_at = sysdate WHERE id_rate = v_id;
      UPDATE exchange_rate SET created_at = sysdate WHERE id_rate = v_id;
    END AFTER STATEMENT;
  END;
/ 

SET DEFONE OFF;
CREATE OR REPLACE TRIGGER insert_transaction
  FOR INSERT ON transaction_history
  COMPOUND TRIGGER
  v_id transaction_history.id_transaction%type;
  v_type transaction_history.transaction_type%type;
  v_account1 bank_account.id_account%type;
  v_account2 bank_account.id_account%type;
  v_value transaction_history.money_amount%type;
  v_original_amount bank_account.monetary_value%type;
  v_exchange exchange_rate.to_ron%type;
  v_acc_type bank_account.account_type%type;
  BEFORE EACH ROW IS
  BEGIN
    v_id := :NEW.id_transaction;
    v_type := :NEW.transaction_type;
    v_account1 := :NEW.id_account_to;
    v_account2 := :NEW.id_account_from;
    v_value := :NEW.money_amount;
    SELECT * INTO v_acc_type FROM (SELECT account_type FROM bank_account WHERE id_account = v_account2);
    SELECT * INTO v_exchange FROM (SELECT to_ron FROM exchange_rate WHERE id_rate = :NEW.id_rate);
    SELECT * INTO v_original_amount FROM (SELECT monetary_value FROM bank_account WHERE id_account = v_account2);
    v_value := v_value * v_exchange;
    IF(:NEW.transaction_type NOT IN('Salary','Deposit','Check','Withdraw')) THEN
    RAISE_APPLICATION_ERROR (
      num => -20051,
      msg => 'Invalid transaction type detected.');
    END IF;
    IF(v_value > 50000 OR v_value < -50000) THEN
    RAISE_APPLICATION_ERROR (
      num => -20052,
      msg => 'Illegal monetary value detected.');
    END IF;
    IF(v_original_amount - v_value < -1000 AND v_acc_type <> 'Zero') THEN
    RAISE_APPLICATION_ERROR (
      num => -20053,
      msg => 'Cannot go beneath 1000 RON.');
    END IF;
    IF(v_original_amount - v_value < 0 AND v_acc_type = 'Zero') THEN
    RAISE_APPLICATION_ERROR (
      num => -20054,
      msg => 'Cannot go beneath 0 RON for Zero accounts.');
    END IF;
    IF(v_account1 <> v_account2 AND v_type='Withdraw') THEN
    RAISE_APPLICATION_ERROR (
      num => -20055,
      msg => 'Cannot withdraw money from another account.');
    END IF;
    IF(v_value <= 0) THEN
    RAISE_APPLICATION_ERROR (
      num => -20056,
      msg => 'Invalid monetary value.');
    END IF;                                
    END BEFORE EACH ROW;
    
    AFTER STATEMENT IS BEGIN
      UPDATE transaction_history SET updated_at = sysdate WHERE id_transaction = v_id;
      UPDATE transaction_history SET created_at = sysdate WHERE id_transaction = v_id;
      IF(v_type IN ('Check','Salary','Deposit')) THEN
        UPDATE bank_account SET monetary_value = monetary_value + v_value WHERE id_account = v_account1;
        UPDATE bank_account SET monetary_value = monetary_value - v_value WHERE id_account = v_account2;
      END IF;
      IF(v_type = 'Withdraw') THEN
        UPDATE bank_account SET monetary_value = monetary_value - v_value WHERE id_account = v_account1;
      END IF;
    END AFTER STATEMENT;
  END;
/ 
