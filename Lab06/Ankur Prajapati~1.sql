CREATE OR REPLACE PROCEDURE raise_salary
(p_id IN employees.employee_id%TYPE,
p_percent IN NUMBER)
IS
BEGIN
    UPDATE employees
    SET salary = salary * (1 + p_percent/100)
    WHERE employee_id = p_id;
END raise_salary;

EXECUTE raise_salary(176,10)
select * from employees


CREATE OR REPLACE PROCEDURE query_emp
(p_id IN employees.employee_id%TYPE,
p_name OUT employees.last_name%TYPE,
p_salary OUT employees.salary%TYPE) IS
BEGIN
    SELECT last_name, salary INTO p_name, p_salary
    FROM employees
    WHERE employee_id = p_id;
END query_emp;
/

SET SERVEROUTPUT ON
DECLARE
    v_emp_name employees.last_name%TYPE;
    v_emp_sal employees.salary%TYPE;
BEGIN
    query_emp(171, v_emp_name, v_emp_sal);
    DBMS_OUTPUT.PUT_LINE(v_emp_name || ' earns' || to_char(v_emp_sal, '$999,999.0'));
END;
/


CREATE OR REPLACE PROCEDURE format_phone (p_phone_no IN OUT VARCHAR2) IS
BEGIN
    p_phone_no := '(' || SUBSTR(p_phone_no,1,3) ||
                    ') ' || SUBSTR(p_phone_no,4,3) ||
                    '-' || SUBSTR(p_phone_no,7);
END format_phone;
/

VARIABLE b_phone_no VARCHAR2(15)
EXECUTE :b_phone_no := '8006330575'
    PRINT b_phone_no
EXECUTE format_phone (:b_phone_no)
    PRINT b_phone_no

CREATE OR REPLACE PROCEDURE add_dept(
p_name IN departments.department_name%TYPE,
p_loc IN departments.location_id%TYPE) IS
BEGIN
    INSERT INTO departments(department_id, department_name, location_id)
    VALUES (departments_seq.NEXTVAL, p_name, p_loc);
END add_dept;
/
---Positional Notation
EXECUTE add_dept('TRAINING', 2500);
---named Location
EXECUTE add_dept(p_loc=>2400, p_name=> 'EDUCATION');


SELECT * FROM DEPARTMENTS

CREATE OR REPLACE PROCEDURE add_dept(
p_name IN departments.department_name%TYPE := 'UNKNOWN',
p_loc IN departments.location_id%TYPE DEFAULT 1700) IS
BEGIN
    INSERT INTO departments(department_id, department_name, location_id) 
    VALUES (departments_seq.NEXTVAL, p_name, p_loc);
END add_dept;

EXECUTE add_dept
EXECUTE add_dept('ADVERTISING', p_loc => 1200)
EXECUTE add_dept(p_loc => 1200)

CREATE OR REPLACE PROCEDURE add_department(
p_name VARCHAR2, p_mgr NUMBER, p_loc NUMBER) IS
BEGIN
    INSERT INTO DEPARTMENTS(department_id, department_name, manager_id, location_id)
    VALUES (DEPARTMENTS_SEQ.NEXTVAL, p_name, p_mgr, p_loc);
    DBMS_OUTPUT.PUT_LINE('Added Department: ' || p_name);
/*EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Err: adding dept: ' || p_name);*/
END;


CREATE OR REPLACE PROCEDURE create_departments IS
BEGIN
    add_department('Media', 100, 1708);
    add_department('Editing', 99, 1800);
    add_department('Advertising', 101, 1800);
END;

EXECUTE create_departments

SELECT * FROM DEPARTMENTS


CREATE OR REPLACE FUNCTION get_sal(p_id employees.employee_id%TYPE) RETURN NUMBER IS
v_sal employees.salary%TYPE := 0;
BEGIN
    SELECT SALARY
    INTO v_sal
    FROM employees
    WHERE employee_id = p_id;
    RETURN v_sal;
END get_sal;
/

EXECUTE dbms_output.put_line(get_sal(100))

SELECT job_id, get_sal(employee_id) FROM employees


CREATE OR REPLACE FUNCTION tax(p_value IN NUMBER)
    RETURN NUMBER IS
BEGIN
    RETURN (p_value * 0.08);
END tax;
/
SELECT employee_id, last_name, salary, tax(salary)
FROM employees
WHERE department_id = 100;

CREATE OR REPLACE FUNCTION dml_call_sql(p_sal NUMBER)
RETURN NUMBER IS
BEGIN
    INSERT INTO employees (employee_id, last_name, email, hire_date, job_id, salary)
    VALUES (1, 'Frost', 'jfrost@gmail.com', SYSDATE, 'SA_MAN', p_sal);
    RETURN (p_sal+100);
END;

UPDATE employees
    SET SALARY = dml_call_sql(2000)
    WHERE employee_id = 170;
    
CREATE OR REPLACE FUNCTION f(
p_parameter_1 IN NUMBER DEFAULT 1,
p_parameter_5 IN NUMBER DEFAULT 5)
RETURN NUMBER
IS 
v_var NUMBER;
BEGIN
    v_var:=p_parameter_1 + (p_parameter_5 * 2);
    RETURN v_var;
END f;
/

SELECT f(p_parameter_5 => 10) FROM DUAL;















