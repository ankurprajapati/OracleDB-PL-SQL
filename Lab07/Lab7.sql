CREATE OR REPLACE PACKAGE JOB_PKG IS
    PROCEDURE add_job(p_id jobs.job_id%TYPE, p_title jobs.job_title%TYPE);
    PROCEDURE del_job(p_id jobs.job_id%TYPE);
    FUNCTION get_job(p_id IN jobs.job_id%TYPE) RETURN jobs.job_title%TYPE;
    PROCEDURE upd_job(p_id jobs.job_id%TYPE, p_title jobs.job_title%TYPE);
END JOB_PKG;
/
SHOW ERRORS;

CREATE OR REPLACE PACKAGE BODY JOB_PKG IS
    PROCEDURE add_job(p_id jobs.job_id%TYPE, p_title jobs.job_title%TYPE) IS --add_job Procedures
    BEGIN
        INSERT INTO JOBS (job_id, job_title) VALUES (p_id, p_title);
    END add_job;   
    PROCEDURE del_job(p_id jobs.job_id%TYPE) IS
    BEGIN
        DELETE FROM JOBS WHERE job_id = p_id;
        IF SQL%ROWCOUNT <= 0 THEN
            RAISE_APPLICATION_ERROR(-20203, 'Nothing to DELETE.');
        END IF;
    END del_job;
    FUNCTION get_job(p_id IN jobs.job_id%TYPE)
        RETURN jobs.job_title%TYPE IS
        v_title jobs.job_title%TYPE;
    BEGIN
        SELECT job_title INTO v_title FROM jobs WHERE job_id = p_id;
        RETURN v_title;
    END get_job;
    PROCEDURE UPD_JOB(p_id jobs.job_id%TYPE, p_title jobs.job_title%TYPE) IS
    BEGIN
        UPDATE JOBS SET job_title = p_title WHERE job_id = p_id;
        IF SQL%NOTFOUND THEN
            RAISE_APPLICATION_ERROR(-20202, 'NOTHING TO UPDATE');
        END IF;    
    END UPD_JOB;
END JOB_PKG;
/
SHOW ERRORS;

EXECUTE JOB_PKG.add_job('IT_SYSAN','System Analyst');

SELECT * FROM JOBS WHERE job_id = 'IT_SYSAN';






------------------------------------------------------------------------------------------Question 2 ------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE emp_pkg IS
    PROCEDURE add_employee( 
        p_first_name employees.first_name%TYPE, 
        p_last_name employees.last_name%TYPE, 
        p_email employees.email%TYPE, 
        p_job employees.job_id%TYPE DEFAULT 'SA_REP', 
        p_mgr employees.manager_id%TYPE DEFAULT 145, 
        p_sal employees.salary%TYPE DEFAULT 1000, 
        p_comm employees.commission_pct%TYPE DEFAULT 0, 
        p_deptid employees.department_id%TYPE DEFAULT 30);
        
    PROCEDURE get_employee(
        p_empid IN employees.employee_id%TYPE, 
        p_sal OUT employees.salary%TYPE, 
        p_job OUT employees.job_id%TYPE);
END emp_pkg;
/
SHOW ERRORS

--BODY of PACKAGE
CREATE OR REPLACE PACKAGE BODY emp_pkg IS
  FUNCTION valid_deptid(p_deptid IN departments.department_id%TYPE) RETURN BOOLEAN IS 
    v_dummy PLS_INTEGER; 
  BEGIN 
    SELECT 1 INTO v_dummy FROM departments WHERE department_id = p_deptid; 
    RETURN TRUE; 
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        RETURN FALSE; 
END valid_deptid; 

  PROCEDURE add_employee( 
    p_first_name employees.first_name%TYPE, 
    p_last_name employees.last_name%TYPE, 
    p_email employees.email%TYPE, 
    p_job employees.job_id%TYPE DEFAULT 'SA_REP', 
    p_mgr employees.manager_id%TYPE DEFAULT 145, 
    p_sal employees.salary%TYPE DEFAULT 1000, 
    p_comm employees.commission_pct%TYPE DEFAULT 0, 
    p_deptid employees.department_id%TYPE DEFAULT 30) IS
  BEGIN 
    IF valid_deptid(p_deptid) THEN 
      INSERT INTO employees(employee_id, first_name, last_name, email, job_id, manager_id, hire_date, salary, commission_pct, department_id) 
      VALUES (employees_seq.NEXTVAL, p_first_name, p_last_name, p_email, p_job, p_mgr, TRUNC(SYSDATE), p_sal, p_comm, p_deptid); 
    ELSE 
      RAISE_APPLICATION_ERROR (-20204, 'Invalid department ID. Try again.'); 
    END IF;
  END add_employee; 

  PROCEDURE get_employee(
    p_empid IN employees.employee_id%TYPE, 
    p_sal OUT employees.salary%TYPE, 
    p_job OUT employees.job_id%TYPE) IS 
  BEGIN 
    SELECT salary, job_id INTO p_sal, p_job FROM employees WHERE employee_id = p_empid; 
  END get_employee; 
END emp_pkg;
/
SHOW ERRORS

EXECUTE emp_pkg.add_employee('Jane', 'Harris', 'JAHARRIS', p_deptid => 15);

EXECUTE emp_pkg.add_employee('David', 'Smith', 'DASMITH', p_deptid => 80);

SELECT * FROM EMPLOYEES WHERE last_name = 'Smith';


  
  
  










------------------------------------------------------------------------Practice 2 - 1 --------------------------------------------------------------------------------------------  

CREATE OR REPLACE PACKAGE emp_pkg IS
  PROCEDURE add_employee( 
    p_first_name employees.first_name%TYPE, 
    p_last_name employees.last_name%TYPE, 
    p_email employees.email%TYPE, 
    p_job employees.job_id%TYPE DEFAULT 'SA_REP', 
    p_mgr employees.manager_id%TYPE DEFAULT 145, 
    p_sal employees.salary%TYPE DEFAULT 1000, 
    p_comm employees.commission_pct%TYPE DEFAULT 0, 
    p_deptid employees.department_id%TYPE DEFAULT 30);

/*----------------------------- New overloaded add_employee----------- */  
  PROCEDURE add_employee( 
    p_first_name employees.first_name%TYPE, 
    p_last_name employees.last_name%TYPE, 
    p_deptid employees.department_id%TYPE);
/*--------------------------------------------------------------------*/  
  PROCEDURE get_employee(
    p_empid IN employees.employee_id%TYPE, 
    p_sal OUT employees.salary%TYPE, 
    p_job OUT employees.job_id%TYPE);
END emp_pkg;
/
SHOW ERRORS

CREATE OR REPLACE PACKAGE BODY emp_pkg IS
  FUNCTION valid_deptid(p_deptid IN departments.department_id%TYPE) RETURN BOOLEAN IS 
    v_dummy PLS_INTEGER; 
  BEGIN 
    SELECT 1 
    INTO v_dummy 
    FROM departments 
    WHERE department_id = p_deptid; 
    RETURN TRUE; 
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
    RETURN FALSE; 
END valid_deptid; 

  PROCEDURE add_employee( 
    p_first_name employees.first_name%TYPE, 
    p_last_name employees.last_name%TYPE, 
    p_email employees.email%TYPE, 
    p_job employees.job_id%TYPE DEFAULT 'SA_REP', 
    p_mgr employees.manager_id%TYPE DEFAULT 145, 
    p_sal employees.salary%TYPE DEFAULT 1000, 
    p_comm employees.commission_pct%TYPE DEFAULT 0, 
    p_deptid employees.department_id%TYPE DEFAULT 30) IS 
  BEGIN 
    IF valid_deptid(p_deptid) THEN 
      INSERT INTO employees(employee_id, first_name, last_name, email, 
        job_id, manager_id, hire_date, salary, commission_pct, department_id) 
      VALUES (employees_seq.NEXTVAL, p_first_name, p_last_name, p_email, 
        p_job, p_mgr, TRUNC(SYSDATE), p_sal, p_comm, p_deptid); 
    ELSE 
      RAISE_APPLICATION_ERROR (-20204, 'Invalid department ID. Try again.'); 
    END IF; 
  END add_employee; 

/*------------------------------New overloaded add_employee----------- */    
/*------------------------------New overloaded add_employee procedure--*/

  PROCEDURE add_employee( 
    p_first_name employees.first_name%TYPE, 
    p_last_name employees.last_name%TYPE, 
    p_deptid employees.department_id%TYPE) IS
    p_email employees.email%type;
  BEGIN
    p_email := UPPER(SUBSTR(p_first_name, 1, 1)||SUBSTR(p_last_name, 1, 7));
    add_employee(p_first_name, p_last_name, p_email, p_deptid => p_deptid);
  END;

/* End declaration of the overloaded add_employee procedure */

  PROCEDURE get_employee(
    p_empid IN employees.employee_id%TYPE, 
    p_sal OUT employees.salary%TYPE, 
    p_job OUT employees.job_id%TYPE) IS 
  BEGIN 
    SELECT salary, job_id 
    INTO p_sal, p_job 
    FROM employees 
    WHERE employee_id = p_empid; 
  END get_employee; 
END emp_pkg;
/
SHOW ERRORS

EXECUTE emp_pkg.add_employee('Samuel', 'Joplin', 30);

SELECT * FROM EMPLOYEES WHERE last_name = 'Joplin';
















------------------------------------------------------------------------Practice 2 - 2 --------------------------------------------------------------------------------------------  
-- Package SPECIFICATION
SET SERVEROUTPUT ON
CREATE OR REPLACE PACKAGE emp_pkg IS
  PROCEDURE add_employee( 
    p_first_name employees.first_name%TYPE, 
    p_last_name employees.last_name%TYPE, 
    p_email employees.email%TYPE, 
    p_job employees.job_id%TYPE DEFAULT 'SA_REP', 
    p_mgr employees.manager_id%TYPE DEFAULT 145, 
    p_sal employees.salary%TYPE DEFAULT 1000, 
    p_comm employees.commission_pct%TYPE DEFAULT 0, 
    p_deptid employees.department_id%TYPE DEFAULT 30);
  PROCEDURE add_employee( 
    p_first_name employees.first_name%TYPE, 
    p_last_name employees.last_name%TYPE, 
    p_deptid employees.department_id%TYPE); 
  PROCEDURE get_employee(
    p_empid IN employees.employee_id%TYPE, 
    p_sal OUT employees.salary%TYPE, 
    p_job OUT employees.job_id%TYPE);
/*------------------------------New overloaded get_employees functions specs starts here:------------------------------*/
  FUNCTION get_employee(p_emp_id employees.employee_id%type)
    return employees%rowtype;
  FUNCTION get_employee(p_family_name employees.last_name%type)
    return employees%rowtype;
/*------------------------------New overloaded get_employees functions specs ends here.------------------------------*/

/*------------------------------New procedure init_departments spec----------------------------------------------- */
PROCEDURE init_departments;
/*------------------------------New print_employee print_employee procedure spec------------------------------*/
PROCEDURE print_employee(p_rec_emp employees%rowtype);
END emp_pkg;
/
SHOW ERRORS


-- Package BODY
CREATE OR REPLACE PACKAGE BODY emp_pkg IS
/*--------------------------------------New type------------------------------*/
TYPE boolean_tab_type IS TABLE OF BOOLEAN 
		  INDEX BY BINARY_INTEGER;
  valid_departments boolean_tab_type;

  FUNCTION valid_deptid(p_deptid IN departments.department_id%TYPE) RETURN BOOLEAN IS 
    v_dummy PLS_INTEGER; 
  BEGIN 
    RETURN valid_departments.exists(p_deptid); 
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
    RETURN FALSE; 
END valid_deptid; 

  PROCEDURE add_employee( 
    p_first_name employees.first_name%TYPE, 
    p_last_name employees.last_name%TYPE, 
    p_email employees.email%TYPE, 
    p_job employees.job_id%TYPE DEFAULT 'SA_REP', 
    p_mgr employees.manager_id%TYPE DEFAULT 145, 
    p_sal employees.salary%TYPE DEFAULT 1000, 
    p_comm employees.commission_pct%TYPE DEFAULT 0, 
    p_deptid employees.department_id%TYPE DEFAULT 30) IS 
  BEGIN 
    IF valid_deptid(p_deptid) THEN 
      INSERT INTO employees(employee_id, first_name, last_name, email, job_id, manager_id, hire_date, salary, commission_pct, department_id) 
      VALUES (employees_seq.NEXTVAL, p_first_name, p_last_name, p_email, p_job, p_mgr, TRUNC(SYSDATE), p_sal, p_comm, p_deptid); 
    ELSE 
      RAISE_APPLICATION_ERROR (-20204, 'Invalid department ID. Try again.'); 
    END IF; 
  END add_employee; 
  
  PROCEDURE add_employee( 
    p_first_name employees.first_name%TYPE, 
    p_last_name employees.last_name%TYPE, 
    p_deptid employees.department_id%TYPE) IS
    p_email employees.email%type;
  BEGIN
    p_email := UPPER(SUBSTR(p_first_name, 1, 1)||SUBSTR(p_last_name, 1, 7));
    add_employee(p_first_name, p_last_name, p_email, p_deptid => p_deptid);
  END;

  PROCEDURE get_employee(
    p_empid IN employees.employee_id%TYPE, 
    p_sal OUT employees.salary%TYPE, 
    p_job OUT employees.job_id%TYPE) IS 
  BEGIN 
    SELECT salary, job_id INTO p_sal, p_job FROM employees WHERE employee_id = p_empid; 
  END get_employee; 

/*------------------------------New get_employee function declaration starts here------------------------------*/
FUNCTION get_employee(p_emp_id employees.employee_id%type)
    return employees%rowtype IS
    rec_emp employees%rowtype;
  BEGIN
    SELECT * INTO rec_emp FROM employees WHERE employee_id = p_emp_id;
    RETURN rec_emp;
  END;
  FUNCTION get_employee(p_family_name employees.last_name%type)
    return employees%rowtype IS
    rec_emp employees%rowtype;
  BEGIN
    SELECT * INTO rec_emp FROM employees WHERE last_name = p_family_name;
    RETURN rec_emp;
  END;
/*------------------------------New overloaded get_employee function declaration ends here------------------------------*/
/*------------------------------New print_employees procedure declaration.----------------------------------------------*/
PROCEDURE print_employee(p_rec_emp employees%rowtype) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(p_rec_emp.department_id ||' '|| 
                         p_rec_emp.employee_id||' '||
                         p_rec_emp.first_name||' '||
                         p_rec_emp.last_name||' '||
                         p_rec_emp.job_id||' '||
                         p_rec_emp.salary);
  END;
  
/*------------------------------New init_departments procedure declaration.------------------------------*/
PROCEDURE init_departments IS
  BEGIN
    FOR rec IN (SELECT department_id FROM departments)
    LOOP
      valid_departments(rec.department_id) := TRUE;
    END LOOP;
  END;
  
/*------------------------------call the new init_departments procedure.------------------------------*/
BEGIN
  init_departments;
END emp_pkg;
/
SHOW ERRORS

SET SERVEROUTPUT ON

EXECUTE EMP_PKG.INIT_DEPARTMENTS;

EXECUTE emp_pkg.add_employee('James', 'Bond', 15);
/
/*-------------------------------------------------------------*/
SELECT * FROM EMPLOYEES WHERE department_id = 15;
INSERT INTO departments (department_id, department_name) VALUES (15, 'Security');
COMMIT;
/*----------------------------Practice 2 - 4 - g*/
DELETE FROM employees
WHERE first_name = 'James' AND last_name = 'Bond';
DELETE FROM departments WHERE department_id = 15;
COMMIT;
EXECUTE EMP_PKG.INIT_DEPARTMENTS

/*---------------------------------------------------*/
SET SERVEROUTPUT ON
BEGIN
    emp_pkg.print_employee(emp_pkg.get_employee(100));
    emp_pkg.print_employee(emp_pkg.get_employee('Joplin'));
END;
/


   






















