DROP TABLE exchange_rate CASCADE CONSTRAINTS;
/
DROP TABLE bank CASCADE CONSTRAINTS;
/
DROP TABLE staff CASCADE CONSTRAINTS;
/
DROP TABLE customer CASCADE CONSTRAINTS;
/
DROP TABLE bank_account CASCADE CONSTRAINTS;
/
DROP TABLE transaction_history CASCADE CONSTRAINTS;
/

CREATE TABLE exchange_rate (
  id_rate INT NOT NULL PRIMARY KEY,
  initial_currency VARCHAR2(15) NOT NULL,
  to_GBP FLOAT NOT NULL,
  to_EUR FLOAT NOT NULL,
  to_RON FLOAT NOT NULL,
  to_RUB FLOAT NOT NULL,
  created_at DATE,
  updated_at DATE
)
/

CREATE TABLE bank (
  id_bank INT NOT NULL PRIMARY KEY,
  city VARCHAR2(20) NOT NULL,
  address VARCHAR2(100) NOT NULL,
  name VARCHAR2(60) NOT NULL,
  created_at DATE,
  updated_at DATE
)
/

CREATE TABLE staff (
  id_staff INT NOT NULL PRIMARY KEY,
  id_bank INT NOT NULL,
  f_name VARCHAR2(60) NOT NULL,
  l_name VARCHAR2(60) NOT NULL,
  city VARCHAR2(20) NOT NULL,
  email VARCHAR2(60) NOT NULL,
  phone_number VARCHAR2(13) NOT NULL,
  date_of_birth DATE NOT NULL,
  job_position VARCHAR2(20) NOT NULL,
  salary INT NOT NULL,
  created_at DATE,
  updated_at DATE,
  CONSTRAINT fk_staff_id_bank
  FOREIGN KEY (id_bank)
  REFERENCES bank(id_bank)
)
/

CREATE TABLE customer (
  id_customer INT NOT NULL PRIMARY KEY,
  f_name VARCHAR2(60) NOT NULL,
  l_name VARCHAR2(60) NOT NULL,
  city VARCHAR2(20) NOT NULL,
  email VARCHAR2(60) NOT NULL,
  phone_number VARCHAR2(11) NOT NULL,
  date_of_birth DATE NOT NULL,
  created_at DATE,
  updated_at DATE
)
/

CREATE TABLE bank_account (
  id_account INT NOT NULL PRIMARY KEY,
  id_customer INT NOT NULL,
  account_type VARCHAR2(20) NOT NULL,
  monetary_value INT NOT NULL,
  created_at DATE,
  updated_at DATE,
  CONSTRAINT fk_bank_account_id_customer
  FOREIGN KEY (id_customer)
  REFERENCES customer(id_customer)
)
/

CREATE TABLE transaction_history (
  id_transaction INT NOT NULL PRIMARY KEY,
  id_bank INT NOT NULL,
  id_staff INT NOT NULL,
  id_account_from INT NOT NULL,
  id_account_to INT NOT NULL,
  id_rate INT NOT NULL,
  transaction_type VARCHAR2(30) NOT NULL,
  transaction_date DATE NOT NULL,
  transaction_hour VARCHAR2(6) NOT NULL,
  money_amount INT NOT NULL,
  created_at DATE,
  updated_at DATE,
  CONSTRAINT transaction_id_bank
  FOREIGN KEY (id_bank)
  REFERENCES bank(id_bank),
  CONSTRAINT transaction_id_staff
  FOREIGN KEY (id_staff)
  REFERENCES staff(id_staff),
  CONSTRAINT transaction_account_from
  FOREIGN KEY (id_account_from)
  REFERENCES bank_account(id_account),
  CONSTRAINT transaction_account_to
  FOREIGN KEY (id_account_to)
  REFERENCES bank_account(id_account),
  CONSTRAINT transaction_id_rate
  FOREIGN KEY (id_rate)
  REFERENCES exchange_rate(id_rate)
)
/

SET SERVEROUTPUT ON;
DECLARE
  TYPE varr IS VARRAY(1000) OF varchar2(255);
  lista_nume varr := varr('Alexanndrei','Ayaey','Agae','Agape','Alexeyi','Alexiis','Amarghioaleici','Ambrocian','Andoneseiscu',
  'Anita','Antochian','Antoniu','Bagaene','Bejenariele','Balcescundru','Buducu','Caimanel','Carbunel','Carpel',
  'Catanescu','Cerbescu','Craciun','Damiane','Damoce','Daneliuce','Danielescu','Danilia','Eduardo','Eustache','Freraruc','Ferestraoarul',
  'Fierarulmetin','Filimondru','Filipel','Florescuol','Folrevaiter','Framosuc','Freunza','Garcea','Ghergu','Ghermansil','Ghibirdice','Giosaenu','Girtlan','Giurgilae',
  'Grozavescu','Guramare','Habascu','Haraebunagluma','Hardonoff','Harpa','Heidel','Herscovician', 'Iancuel','Ichimandrascu','Iftimeseieieie','Ilie','Insuratelunu','Ioneseiie','Ionesiscu','Ionitael',
  'Jitarriucu','Jitcaman','Joldrescuboi','Juravled','Larionuaiuardsan','Lataescu','Latuaman','Lazarescu','Leleleu', 'Lunguscurt','Lupascua','Lupu','Macaroriu','Macoveschielel','Maftei','Maganues','Mangalagiugiu',
  'Matiescu','Matranana','Maximminim','Mazareanuun','Mazilurel','Mazures','Melniciuc-puieca-ce','Micumare', 'Minghelghel','Minuti','Mirondrei','Mitanna','Moisael','Moniry-abyaneh-ce','Morairescu',
  'Neghina','Negruscu','Negruser','Negrutu','Nemtoc','Netedu','Nica', 'Palihocviciel','Pantiru','Pantiruc','Paparuz','Pascaru','Patachiel',
  'Vinatoruel','Vladel','Voaides','Vrabianu','Vulpescu','Zamosteanu','Zazuleac');
  lista_prenume varr := varr('Adina','Alexandra','Claudia','Codrina','Cristina','Daniela','Daria','Delia','Denisa','Diana','Emma','Gabriela','Georgiana','Ileana','Ilona','Ioana','Iolanda','Irina','Iulia','Iuliana','Larisa','Laura','Loredana','Madalina','Malina','Manuela','Maria','Raluca','Sabina','Sanziana','Simina','Simona','Stefana','Stefania',
  'Adrian','Bogdan','Camil','Catalin','Cezar','Ciprian','Claudiu','Codrin','Damian','Dan','Daniel','Danut','Darius','Denise','Dimitrie','Elvis','Emil','Ervin','Eugen','Eusebiu','Fabian','Filip','Florian','Florin','Gabriel','George','Gheorghe','Giani','Giulio','Iaroslav','Ilie','Ioan','Ion','Ionel','Ionut','Matei','Mihai','Mihail','Nicolae','Rares','Razvan','Richard','Robert','Samuel','Sebastian','Sergiu','Silviu','Stefan','Teodor','Teofil','Theodor','Tudor','Victor','Vlad','Vladimir','Vladut');
  lista_orase varr := varr('Galati','Bucuresti','Iasi','Tecuci','Brasov','Cluj','Braila','Suceava');
  lista_tipuri_tranzactie varr := varr('Deposit','Salary','Check','Withdraw');
  lista_valute varr := varr('GBP','EUR','RON','RUB');
  lista_tipuri_cont varr := varr('Zero','Normal','Savings','Retirement');
  lista_tipuri_pozitie varr := varr('Consultant','Intern','Administrator','Teller','Security','Cleaner');
  lista_numere varr := varr('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16');
  
  v_nume VARCHAR2(255);
  v_prenume VARCHAR2(255);
  v_oras VARCHAR2(255);
  v_adresa VARCHAR2(255);
  v_tranzactie VARCHAR2(255);
  v_valuta VARCHAR2(255);
  v_cont VARCHAR2(255);
  v_titlu VARCHAR2(255);
  v_email varchar2(70);
  v_data_nastere date;
  v_telefon VARCHAR2(255);
  v_id int;
  v_id_aux int;
  v_id_banca int;
  v_data_tranzactie date;
  v_ora varchar2(20);
  v_cantitate_monetara int;
  v_cnp varchar2(20);
  v_rata1 float;
  v_rata2 float;
  v_rata3 float;
  v_rata4 float;
  v_salariu int;
  
BEGIN
  FOR v_i IN 1..60 LOOP --se populeaza tabela bank
    v_oras := lista_orase(TRUNC(DBMS_RANDOM.VALUE(0,lista_orase.count))+1);
    v_adresa := 'Strada '||lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1)||
    ' numarul '||lista_numere(TRUNC(DBMS_RANDOM.VALUE(0,lista_numere.count))+1);
    v_nume := lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1);
    insert into bank values(v_i, v_oras, v_adresa, v_nume, sysdate, sysdate);
  END LOOP;
  
  FOR v_i IN 1..15000 LOOP --se populeaza tabela exchange_rate
    v_valuta := lista_valute(TRUNC(DBMS_RANDOM.VALUE(0,lista_valute.count))+1);
    CASE
    WHEN v_valuta = 'GBP' THEN
      v_rata1 := 1;
      v_rata2 := 0.8 + TRUNC(DBMS_RANDOM.VALUE,2);
      v_rata3 := 5 + TRUNC(DBMS_RANDOM.VALUE,2);
      v_rata4 := 80 + TRUNC(DBMS_RANDOM.VALUE * 10,2);
    WHEN v_valuta = 'EUR' THEN
      v_rata1 := 0.5 + TRUNC(DBMS_RANDOM.VALUE,2);
      v_rata2 := 1;
      v_rata3 := 4 + TRUNC(DBMS_RANDOM.VALUE,2);
      v_rata4 := 65 + TRUNC(DBMS_RANDOM.VALUE * 10,2);
    WHEN v_valuta = 'RON' THEN
      v_rata1 := TRUNC(DBMS_RANDOM.VALUE / 5,2);
      v_rata2 := TRUNC(DBMS_RANDOM.VALUE / 4,2);
      v_rata3 := 1;
      v_rata4 := 10 + TRUNC(DBMS_RANDOM.VALUE * 10,2);
    WHEN v_valuta = 'RUB' THEN
      v_rata1 := TRUNC(DBMS_RANDOM.VALUE / 10,2);
      v_rata2 := TRUNC(DBMS_RANDOM.VALUE / 8,2);
      v_rata3 := TRUNC(DBMS_RANDOM.VALUE / 5,2);
      v_rata4 := 1;
    END CASE;
    insert into exchange_rate values(v_i, v_valuta, v_rata1, v_rata2, v_rata3, v_rata4, sysdate, sysdate);
  END LOOP;
  
  FOR v_i IN 1..300000 LOOP --se populeaza tabela customer
     v_nume := lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1);
     v_prenume := lista_prenume(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume.count))+1);
     v_oras := lista_orase(TRUNC(DBMS_RANDOM.VALUE(0,lista_orase.count))+1);
     v_email := v_nume||'_'||v_prenume||to_char(TRUNC(DBMS_RANDOM.VALUE*100))||'@gmail.com';
     v_telefon := '07'||to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||
     to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||
     to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||
     to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)));
     v_data_nastere := TO_DATE('01-01-1954','MM-DD-YYYY')+TRUNC(DBMS_RANDOM.VALUE(0,7300));
     insert into customer values(v_i, v_nume, v_prenume, v_oras, v_email, v_telefon, v_data_nastere, sysdate, sysdate);
   END LOOP;
   
   FOR v_i IN 1..300000 LOOP --se populeaza tabela bank_account
     v_cont := 'Normal';
     IF (DBMS_RANDOM.VALUE(0,100)<90) THEN 
       v_cantitate_monetara := 1500 + TRUNC(DBMS_RANDOM.VALUE*3000,2);
     ELSE 
       v_cantitate_monetara := -100 - TRUNC(DBMS_RANDOM.VALUE*1000,2);
     END IF;
     insert into bank_account values(v_i, v_i, v_cont, v_cantitate_monetara, sysdate, sysdate);
   END LOOP;
   
   FOR v_i IN 300001..550000 LOOP --se populeaza tabela bank_account
     v_cont := lista_tipuri_cont(TRUNC(DBMS_RANDOM.VALUE(0,lista_tipuri_cont.count))+1);
    CASE
    WHEN v_cont = 'Zero' THEN
      v_cantitate_monetara := 200 + TRUNC(DBMS_RANDOM.VALUE*1000,2); --trebuie conditie ca sa nu poata fi pe minus
    WHEN v_cont = 'Normal' THEN
      IF (DBMS_RANDOM.VALUE(0,100)<90) THEN 
      v_cantitate_monetara := 1500 + TRUNC(DBMS_RANDOM.VALUE*3000,2);
      ELSE 
      v_cantitate_monetara := -100 - TRUNC(DBMS_RANDOM.VALUE*1000,2);
      END IF;
    WHEN v_cont = 'Savings' THEN
      v_cantitate_monetara := 3000 + TRUNC(DBMS_RANDOM.VALUE*5000,2);
    WHEN v_cont = 'Retirement' THEN
      v_cantitate_monetara := 1000 + TRUNC(DBMS_RANDOM.VALUE*100000,2);
    END CASE;
     insert into bank_account values(v_i, round(dbms_random.value(1,300000)), v_cont, v_cantitate_monetara, sysdate, sysdate);
   END LOOP;
   
   FOR v_i IN 1..10000 LOOP --se populeaza tabela staff
     v_nume := lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1);
     v_prenume := lista_prenume(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume.count))+1);
     v_oras := lista_orase(TRUNC(DBMS_RANDOM.VALUE(0,lista_orase.count))+1);
     v_email := v_nume||'_'||v_prenume||to_char(TRUNC(DBMS_RANDOM.VALUE*100))||'@gmail.com';
     v_telefon := '07'||to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||
     to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||
     to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||
     to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)));
     v_data_nastere := TO_DATE('01-01-1954','MM-DD-YYYY')+TRUNC(DBMS_RANDOM.VALUE(0,7300));
     v_titlu := lista_tipuri_pozitie(TRUNC(DBMS_RANDOM.VALUE(0,lista_tipuri_pozitie.count))+1);
     CASE
     WHEN v_titlu = 'Consultant' THEN
       v_salariu := 2000 + TRUNC(DBMS_RANDOM.VALUE*3000,2);
     WHEN v_titlu = 'Intern' THEN
       v_salariu := 1800;
     WHEN v_titlu = 'Administrator' THEN
       v_salariu := 3500 + TRUNC(DBMS_RANDOM.VALUE*4000,2);
     WHEN v_titlu = 'Teller' THEN
       v_salariu := 1800 + TRUNC(DBMS_RANDOM.VALUE*2000,2);
     WHEN v_titlu = 'Security' THEN
       v_salariu := 2000 + TRUNC(DBMS_RANDOM.VALUE*1500,2);
     WHEN v_titlu = 'Cleaner' THEN
       v_salariu := 1800 + TRUNC(DBMS_RANDOM.VALUE*1000,2);
     END CASE;
     insert into staff values(v_i, round(dbms_random.value(1,60)), 
     v_prenume, v_nume, v_oras, v_email, v_telefon, v_data_nastere, v_titlu, v_salariu, sysdate, sysdate);
   END LOOP;
   
   FOR v_i IN 1..2000000 LOOP --se populeaza tabela transaction_history
     v_tranzactie := lista_tipuri_tranzactie(TRUNC(DBMS_RANDOM.VALUE(0,lista_tipuri_tranzactie.count))+1);
     v_data_tranzactie := TO_DATE('01-01-2018','MM-DD-YYYY')+TRUNC(DBMS_RANDOM.VALUE(0,485));
     v_ora := to_char(TRUNC(DBMS_RANDOM.VALUE(0,2)))||to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)))||':'||
     to_char(TRUNC(DBMS_RANDOM.VALUE(0,5)))||to_char(TRUNC(DBMS_RANDOM.VALUE(0,9)));
     v_id := round(dbms_random.value(1,60));
     IF (v_tranzactie = 'Withdraw') THEN
       v_id_aux := v_id;
      ELSE
        LOOP
         v_id_aux := round(dbms_random.value(1,60));
           exit when v_id<>v_id_aux;
         END LOOP; 
     END IF;
     CASE
     WHEN v_tranzactie = 'Deposit' THEN
       v_cantitate_monetara := 500 + TRUNC(DBMS_RANDOM.VALUE*3000,2);
     WHEN v_tranzactie = 'Salary' THEN
       v_cantitate_monetara := 2000 + TRUNC(DBMS_RANDOM.VALUE*5000,2);
     WHEN v_tranzactie = 'Check' THEN
       v_cantitate_monetara := 500 + TRUNC(DBMS_RANDOM.VALUE*7000,2);
     WHEN v_tranzactie = 'Withdraw' THEN
       v_cantitate_monetara := -100 - TRUNC(DBMS_RANDOM.VALUE*1000,2);
     END CASE;  
     v_id_banca := round(dbms_random.value(1,60));
     insert into transaction_history values(v_i, v_id_banca,
     (SELECT * FROM (SELECT id_staff FROM staff WHERE (job_position = 'Teller' OR job_position = 'Consultant') AND id_bank = v_id_banca ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1),
     v_id_aux, v_id, round(dbms_random.value(1,15000)),
     v_tranzactie, v_data_tranzactie, v_ora, v_cantitate_monetara, sysdate, sysdate);
   END LOOP;
END;

CREATE INDEX staff_index
on staff(job_position, id_bank);

DELETE FROM BANK;
DELETE FROM EXCHANGE_RATE;
DELETE FROM CUSTOMER;
DELETE FROM BANK_ACCOUNT;
DELETE FROM STAFF;
DELETE FROM TRANSACTION_HISTORY;

SELECT * FROM BANK;
SELECT * FROM EXCHANGE_RATE;
SELECT * FROM CUSTOMER;
SELECT * FROM BANK_ACCOUNT;
SELECT * FROM STAFF;
SELECT * FROM TRANSACTION_HISTORY;




