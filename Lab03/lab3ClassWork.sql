SET SERVEROUTPUT ON
DECLARE
    v_fname VARCHAR2(25);
BEGIN
    SELECT first_name INTO v_fname FROM employees WHERE employee_id=200;
    DBMS_OUTPUT.PUT_LINE('First Name is: '|| v_fname);
END;
/

SET SERVEROUTPUT ON
DECLARE
    v_emp_hiredate employees.hire_date%TYPE;
    v_emp_salary employees.salary%TYPE;
BEGIN
    SELECT hire_date, salary INTO v_emp_hiredate,v_emp_salary  FROM employees WHERE employee_id=100;
    DBMS_OUTPUT.PUT_LINE('Hire Date is: '|| v_emp_hiredate);
    DBMS_OUTPUT.PUT_LINE('Salary is: '|| v_emp_salary);
END;
/

SET SERVEROUTPUT ON
DECLARE
    v_sum_sal NUMBER(10,2);
    v_min_sal v_sum_sal%TYPE;
    v_deptno NUMBER NOT NULL := 60;
BEGIN
    SELECT SUM(salary), MIN(salary) --group function
    INTO v_sum_sal, v_min_sal
    FROM employees 
    WHERE department_id=v_deptno;
    DBMS_OUTPUT.PUT_LINE('The SUM of Salary is: '|| v_sum_sal);
    DBMS_OUTPUT.PUT_LINE('The MIN of Salary is: '|| v_min_sal);
END;
/

SET SERVEROUTPUT ON
DECLARE
    hire_date employees.hire_date%TYPE; -- gives an error because you are using the same name of column as variable
    sysdate hire_date%TYPE; --              
    employee_id employees.employee_id%TYPE := 176; 
BEGIN
    SELECT hire_date, sysdate
    INTO hire_date, sysdate
    FROM employees 
    WHERE employee_id=employee_id;
END;
/

SELECT * FROM employees;

BEGIN
    INSERT INTO employees(employee_id, first_name, last_name, email, hire_date, job_id, salary) --insert data
    VALUES (employees_seq.NEXTVAL, 'RUTH', 'Cores', 'RCORES', CURRENT_DATE, 'AD_ASST', 4000); 
END;
/

DECLARE
    sal_increase employees.salary%TYPE := 800;
BEGIN
    UPDATE employees --update data
    SET salary = salary + sal_increase
    WHERE job_id = 'ST_CLERK';
END;
/

DECLARE
    deptno employees.department_id%TYPE := 800;
BEGIN
    DELETE FROM employees --delete data
    WHERE department_id = deptno;
END;
/

SET SERVEROUTPUT ON
DECLARE
    v_rows_deleted VARCHAR2(30);
    v_empno employees.employee_id%TYPE := 207;
BEGIN
    DELETE FROM employees --delete data
    WHERE employee_id = v_empno;
    v_rows_deleted := (SQL%ROWCOUNT || ' row deleted.');
    DBMS_OUTPUT.PUT_LINE (v_rows_deleted);
END;
/

DECLARE 
    v_myage number := 31;
BEGIN
    IF v_myage < 11
    THEN
        DBMS_OUTPUT.PUT_LINE('I am a child');
    ELSE
        DBMS_OUTPUT.PUT_LINE('I am not a child');
    END IF;    
END;
/

DECLARE 
    v_myage number := 31;
BEGIN
    IF v_myage < 11
    THEN
        DBMS_OUTPUT.PUT_LINE('I am a child');
    ELSIF v_myage < 20 THEN
        DBMS_OUTPUT.PUT_LINE('In am young');
    ELSIF v_myage < 30 THEN
        DBMS_OUTPUT.PUT_LINE('Im in my twenties');
    ELSIF v_myage < 40 THEN
        DBMS_OUTPUT.PUT_LINE('Im in my thirties');
    ELSE
        DBMS_OUTPUT.PUT_LINE('I am always young');
    END IF;    
END;
/

SET VERIFY OFF
DECLARE
    v_grade CHAR(1) := UPPER('&grade');
    v_appraisal VARCHAR2(20);
BEGIN
    v_appraisal := CASE
        WHEN v_grade = 'A' THEN 'Excellent'
        --WHEN 'B' THEN 'Very GOOD'
        --WHEN 'C' THEN 'Good'
        WHEN v_grade IN ('B','C') THEN 'Good'
        ELSE 'No SUCH GRADE' 
    END;
    DBMS_OUTPUT.PUT_LINE ('Grade ' || v_grade || ' Appraisal ' || v_appraisal);
END;
/

SET SERVEROUTPUT ON
DECLARE
   deptid NUMBER;
   deptname VARCHAR2(20);
   emps NUMBER;
   mngid NUMBER:= 108;
BEGIN
     CASE  mngid
         WHEN  108 THEN 
            SELECT department_id, department_name INTO deptid, deptname 
                FROM departments WHERE manager_id=108;
            SELECT count(*) INTO emps FROM employees WHERE 
               department_id=deptid;
         WHEN  200 THEN 
            SELECT department_id, department_name INTO deptid, deptname 
                FROM departments WHERE manager_id=200;
            SELECT count(*) INTO emps FROM employees WHERE 
               department_id=deptid;
         WHEN  121 THEN 
            SELECT department_id, department_name INTO deptid, deptname 
                FROM departments WHERE manager_id=121;
            SELECT count(*) INTO emps FROM employees WHERE 
               department_id=deptid;        
     END CASE;
DBMS_OUTPUT.PUT_LINE ('You are working in the '|| deptname||' department. There are '||emps ||' employees in this department');
END;
/

select * FROM locations;
DECLARE
    v_countryid locations.country_id%TYPE := 'CA';
    v_loc_id locations.location_id%TYPE;
    v_counter NUMBER(2) := 1;
    v_new_city locations.city%TYPE := 'Montreal';
BEGIN
    SELECT MAX(location_id) INTO v_loc_id FROM locations
    WHERE country_id = v_countryid;
    LOOP
        INSERT INTO locations(location_id, city, country_id)
        VALUES((v_loc_id + v_counter), v_new_city, v_countryid);
        v_counter := v_counter + 1;
        EXIT WHEN v_counter > 3;
    END LOOP;
END;
/
select * FROM locations;
rollback;
/

Select * FROM locations;
DECLARE
    v_countryid locations.country_id%TYPE := 'CA';
    v_loc_id locations.location_id%TYPE;
    v_new_city locations.city%TYPE := 'Montreal';
BEGIN
    SELECT MAX(location_id) INTO v_loc_id
    FROM locations
    WHERE country_id = v_countryid;
    FOR i IN 1..3 LOOP
        INSERT INTO locations(location_id, city, country_id)
        VALUES((v_loc_id + i), v_new_city, v_countryid );
    END LOOP;
END;
/
Select * FROM locations;
/
ROLLBACK;
/

DECLARE
    v_total SIMPLE_INTEGER := 0;
BEGIN
    FOR i IN 1..10 LOOP
        v_total := v_total + 1;
        DBMS_OUTPUT.PUT_LINE('Total is: ' || v_total);
        CONTINUE WHEN i > 5;
        v_total := v_total + i;
        DBMS_OUTPUT.PUT_LINE('Out of LOOP total is: ' || v_total);
    END Loop;    
END;
/





















