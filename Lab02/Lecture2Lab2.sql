SET SERVEROUTPUT ON
DECLARE
    v_salary NUMBER(6) := 6000;
    v_sal_hike VARCHAR2(5) := '1000';
    v_total_salary v_salary%TYPE;
BEGIN
    v_total_salary := v_salary + v_sal_hike;
    DBMS_OUTPUT.PUT_LINE(v_total_salary);
END;
/

SELECT SYSDATE from DUAL;


DECLARE
    v_outer_variable VARCHAR2(20) := 'GLOBAL VARIABLE';
BEGIN
    DECLARE
        v_inner_variable VARCHAR2(20) := 'LOCAL VARIABLE';
    BEGIN
        DBMS_OUTPUT.PUT_LINE(v_inner_variable);
        DBMS_OUTPUT.PUT_LINE(v_outer_variable);
    END;
    DBMS_OUTPUT.PUT_LINE(v_outer_variable);
END; 
/

BEGIN <<outer>>
DECLARE
    v_father_name VARCHAR2(20) := 'Patrick';
    v_date_of_birth DATE := '20-APR-1972';
BEGIN
    DECLARE
        v_child_name VARCHAR2(20) := 'MIKE';
        v_date_of_birth DATE := '12-DEC-2002';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Father''s Name:' || v_father_name);
        DBMS_OUTPUT.PUT_LINE('Date of Birth:' || outer.v_date_of_birth);
        DBMS_OUTPUT.PUT_LINE('Date of Birth:' || v_date_of_birth);
        DBMS_OUTPUT.PUT_LINE('Child''s Name:' || v_child_name);
    END;
    DBMS_OUTPUT.PUT_LINE('Date of Birth:' || v_date_of_birth);
END; 
END outer;
/

---------------------------------------------------Lab -----------------------------------------

SET SERVEROUTPUT ON
--VARIABLE b_basic_percent NUMBER
--VARIABLE b_pf_percent NUMBER
DECLARE 
    v_basic_percent NUMBER := 45;
    v_pf_percent NUMBER := 12;
    v_fname VARCHAR2(15);
    v_emp_sal NUMBER(10);
BEGIN
    /*:b_basic_percent := 45;
    :b_pf_percent := 12;*/
    SELECT first_name, salary INTO v_fname, v_emp_sal FROM employees WHERE employee_id = 110;
    DBMS_OUTPUT.PUT_LINE(' Hello ' || v_fname);
    DBMS_OUTPUT.PUT_LINE(' Your Salary is: ' || v_emp_sal);
    DBMS_OUTPUT.PUT_LINE(' Your Contribution towards PF: ' || v_emp_sal * v_basic_percent/100 * v_pf_percent/ 100);
END;
    /*DBMS_OUTPUT.PUT_LINE('Today is:' || v_today);
    DBMS_OUTPUT.PUT_LINE('Tomorrow is: ' || v_tomorrow);*/
/
--PRINT b_basic_percent
--PRINT b_pf_percent  








