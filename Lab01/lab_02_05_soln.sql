SET SERVEROUTPUT ON
    VARIABLE b_basic_percent NUMBER;
    VARIABLE b_pf_percent NUMBER;
DECLARE
    v_today DATE;
    today DATE := SYSDATE;
    v_tomorrow  today%TYPE;
BEGIN
    v_tomorrow := today + 1;
    DBMS_OUTPUT.PUT_LINE('Hello World');
    DBMS_OUTPUT.PUT_LINE('TODAY IS :' || today);
    DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
    :b_basic_percent := 45;
    :b_pf_percent := 12;
END;
/
PRINT b_basic_percent;
PRINT b_pf_percent;


SET SERVEROUT ON SIZE 1000000;
DECLARE
    v_first_name EMPLOYEES.FIRST_NAME%TYPE;
    v_last_name EMPLOYEES.LAST_NAME%TYPE;
    n_employee_id EMPLOYEES.EMPLOYEE_ID%TYPE;
    d_hire_date EMPLOYEES.HIRE_DATE%TYPE;
BEGIN
   SELECT employee_id, first_name, last_name, hire_date
   INTO n_employee_id, v_first_name, v_last_name, d_hire_date
   FROM employees WHERE employee_id = 200;
   DBMS_OUTPUT.PUT_LINE(v_first_name);
   DBMS_OUTPUT.PUT_LINE(v_last_name);
   DBMS_OUTPUT.PUT_LINE(d_hire_date);
END;   
/



