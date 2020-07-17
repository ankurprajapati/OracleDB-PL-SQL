--Package Specification with the public variable and public procedure that are acessible outside the packages 
CREATE OR REPLACE PACKAGE comm_pkg IS
    v_std_comm NUMBER := 0.10; -- initialization to 0.10
    PROCEDURE reset_comm(p_new_comm NUMBER);
END comm_pkg;
/

CREATE OR REPLACE PACKAGE BODY comm_pkg IS
    FUNCTION validate(p_comm NUMBER) RETURN BOOLEAN IS
        v_max_comm employees.commission_pct%TYPE;
        BEGIN
            SELECT MAX(commission_pct) INTO v_max_comm
            FROM EMPLOYEES;
            RETURN (p_comm BETWEEN 0.0 AND v_max_comm);
        END validate;
        
      PROCEDURE reset_comm(p_new_comm NUMBER) IS
        BEGIN
            IF validate(p_new_comm) THEN
            v_std_comm := p_new_comm; --reset Public Variable
            ELSE RAISE_APPLICATION_ERROR(-20210, 'Bad Commission');    
            END IF;
        END reset_comm;
END comm_pkg;      
EXECUTE comm_pkg.reset_comm(0.15)

SELECT * FROM EMPLOYEES



--Expriment
CREATE OR REPLACE PROCEDURE reset_comm(v_sal NUMBER) IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello');
    DBMS_OUTPUT.PUT_LINE(v_sal);
END;
EXECUTE reset_comm(10);

EXECUTE comm_pkg.reset_comm(0.10);



--Creating and Using Bodiless Packages
CREATE OR REPLACE PACKAGE global_consts IS
  c_mile_2_kilo    CONSTANT  NUMBER  :=  1.6093;
  c_kilo_2_mile    CONSTANT  NUMBER  :=  0.6214;
  c_yard_2_meter   CONSTANT  NUMBER  :=  0.9144;
  c_meter_2_yard   CONSTANT  NUMBER  :=  1.0936;
END global_consts;
/

SET SERVEROUTPUT ON
BEGIN
  DBMS_OUTPUT.PUT_LINE('20 miles = ' ||
        20 * global_consts.c_mile_2_kilo || ' km');
END;
/

SET SERVEROUTPUT ON
CREATE OR REPLACE FUNCTION mtr2yrd(p_m NUMBER) RETURN NUMBER IS
BEGIN
  RETURN (p_m * global_consts.c_meter_2_yard);
END mtr2yrd;
/
EXECUTE DBMS_OUTPUT.PUT_LINE(mtr2yrd(1))





CREATE OR REPLACE PACKAGE dept_pkg IS
    PROCEDURE add_dept (
        p_deptno   departments.department_id%TYPE,
        p_name     departments.department_name%TYPE := 'unknown',
        p_loc      departments.location_id%TYPE := 1700
    );

    PROCEDURE add_dept (
        p_name   departments.department_name%TYPE := 'unknown',
        p_loc    departments.location_id%TYPE := 1700
    );

END dept_pkg;
/



CREATE OR REPLACE PACKAGE taxes_pkg IS
  FUNCTION tax (p_value IN NUMBER) RETURN NUMBER;
END taxes_pkg;
/
CREATE OR REPLACE PACKAGE BODY taxes_pkg IS
  FUNCTION tax (p_value IN NUMBER) RETURN NUMBER IS
    v_rate NUMBER := 0.08;
  BEGIN
    RETURN (p_value * v_rate);
  END tax;
END taxes_pkg;
/

SELECT taxes_pkg.tax(salary), salary, last_name FROM EMPLOYEES;

