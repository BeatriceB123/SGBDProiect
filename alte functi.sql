create or replace FUNCTION  get_region_transaction_datas RETURN VARCHAR2 AS
    v_city customer.city%TYPE;
    v_valoare transaction_history.money_amount%TYPE;
    
    CURSOR v_datas IS SELECT city, SUM(ABS(money_amount))FROM transaction_history 
        JOIN customer ON (customer.id_customer = transaction_history.id_account_from OR customer.id_customer = transaction_history.id_account_to )
        GROUP BY city;  
        
    TYPE value_of_region_tab IS TABLE OF NUMBER INDEX BY customer.city%TYPE;
    asocieri value_of_region_tab; --tabel ce va retine valoarea pentru fiecare regiune, deci regiune - valoare
    
    TYPE region_tab IS TABLE OF VARCHAR2(50) INDEX BY VARCHAR2(20);
    t_country region_tab; --tabel ce va retine asocierea oras - regiune
    
    --TYPE varr IS VARRAY(25) OF varchar2(25);
    --lista_orase_NE varr := varr('Botosani','Suceava','Iasi','Neamt','Bacau','Vaslui');
    
    v_response VARCHAR2(32700); 
    l_idx    VARCHAR2(20);
BEGIN
 DBMS_OUTPUT.PUT_LINE('*asdasdasdasd' ); 
  v_response := '';
  t_country('Botosani') := 'NE';
  t_country('Suceava') := 'NE';
  t_country('Iasi') := 'NE';
  t_country('Neamt') := 'NE';
  t_country('Bacau') := 'NE';
  t_country('Vaslui') := 'NE';
  t_country('Bucuresti') := 'Bucuresti';
  t_country('Galati') := 'SE';
  t_country('Tecuci') := 'SE';
  t_country('Braila') := 'SE';
  t_country('Vrancea') := 'SE';
  t_country('Buzau') := 'SE';
  t_country('Cluj') := 'NV';
  t_country('Bihor') := 'NV';
  t_country('Brasov') := 'Centru';
  t_country('City') := 'Other';
  
  asocieri('NE') := 0; 
  asocieri('SE') := 0; 
  asocieri('NV') := 0; 
  asocieri('Centru') := 0; 
  asocieri('Bucuresti') := 0; 
  asocieri('Other') := 0; 
  
  OPEN v_datas;
    LOOP
        FETCH v_datas INTO v_city, v_valoare;
        EXIT WHEN v_datas%NOTFOUND;
        if(t_country.exists(v_city)) then
          asocieri(t_country(v_city)):= asocieri(t_country(v_city)) + v_valoare;
        else 
          asocieri('Other') := asocieri('Other') + v_valoare;
        End if; 
    END LOOP;
    CLOSE v_datas;
    
    l_idx := asocieri.FIRST;
    while (l_idx IS NOT NULL)
    LOOP
        v_response := CONCAT( v_response, l_idx || '*' || asocieri(l_idx) || '*'); 
        l_idx := asocieri.NEXT(l_idx);
    END LOOP;
    
    RETURN v_response; 
END;
/

DECLARE
  v_output varchar2(32700); 
BEGIN
  v_output := get_region_transaction_datas();
  DBMS_OUTPUT.PUT_LINE('Response for java:' || v_output); 
END; 



create or replace FUNCTION  get_city_transaction_datas RETURN varchar2 AS
    v_city customer.city%TYPE;
    v_valoare transaction_history.money_amount%TYPE;
    v_city_total customer.city%TYPE;
    v_valoare_total transaction_history.money_amount%TYPE;
    CURSOR v_city_and_transaction  IS  select city, 0 from (select distinct(city) from customer); 
    CURSOR v_datas IS select city, abs(money_amount) 
        from transaction_history 
        join customer on (customer.id_customer = transaction_history.id_account_from OR customer.id_customer = transaction_history.id_account_to )
        order by id_transaction;
    TYPE MyTab IS TABLE OF NUMBER INDEX BY customer.city%TYPE;
    asocieri MyTab;
    v_response varchar2(32700); 
BEGIN
  v_response := ''; 
  OPEN v_city_and_transaction;
    LOOP
        FETCH v_city_and_transaction INTO v_city, v_valoare;
        EXIT WHEN v_city_and_transaction%NOTFOUND;
        asocieri(v_city) := 0;
    END LOOP;
    CLOSE v_city_and_transaction;

  OPEN v_datas;
    LOOP
        FETCH v_datas INTO v_city_total, v_valoare_total;
        EXIT WHEN v_datas%NOTFOUND;
        asocieri(v_city_total):= asocieri(v_city_total) + v_valoare_total; 
    END LOOP;
    CLOSE v_datas;
    
    OPEN v_city_and_transaction;
    LOOP
        FETCH v_city_and_transaction INTO v_city, v_valoare;
        EXIT WHEN v_city_and_transaction%NOTFOUND;
        --DBMS_OUTPUT.PUT_LINE(v_city||'*'|| asocieri(v_city)||'*');
        v_response := CONCAT(v_response, v_city||'*'|| asocieri(v_city)||'*');
    END LOOP;
    CLOSE v_city_and_transaction;
    return v_response;
END;

