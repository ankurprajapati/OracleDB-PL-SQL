CREATE or REPLACE PROCEDURE get_employee
(e_id IN employees.employee_id%TYPE,
e_sal OUT employees.salary%TYPE,
e_job_id OUT employees.job_id%TYPE) IS
BEGIN
    SELECT salary, job_id
    INTO e_sal,e_job_id
    FROM employees
    WHERE employee_id = e_id;
END get_employee;
/

VARIABLE v_salary NUMBER
VARIABLE v_job VARCHAR2(15)
EXECUTE get_employee(120, :v_salary, :v_job)
PRINT v_salary v_job

EXECUTE get_employee(300, :v_salary, :v_job)







-----Functions
CREATE OR REPLACE FUNCTION get_job(p_jobid IN jobs.job_id%TYPE)
    RETURN jobs.job_title%TYPE IS
    v_title jobs.job_title%TYPE;
BEGIN
    SELECT job_title
    INTO v_title
    FROM jobs
    WHERE job_id = p_jobid;
    RETURN v_title;
END get_job;
/

VARIABLE b_title VARCHAR2(35)
EXECUTE :b_title := get_job('SA_REP');
PRINT b_title


CREATE OR REPLACE FUNCTION get_annual_comp(
p_sal IN employees.salary%TYPE,
p_comm IN employees.commission_pct%TYPE)
    RETURN NUMBER IS
    BEGIN
        RETURN (NVL(p_sal,0) * 12 + (NVL(p_comm,0) * NVL(p_sal,0) * 12));
END get_annual_comp;
/

SELECT employee_id, last_name, get_annual_comp(salary, commission_pct) "Annual Compensation"
FROM employees
WHERE department_id = 30
/


CREATE OR REPLACE FUNCTION valid_deptid(
p_deptid IN departments.department_id%TYPE)
RETURN BOOLEAN IS
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
/

SELECT * FROM EMPLOYEES

CREATE OR REPLACE PROCEDURE add_employee(
v_first_name    IN  employees.first_name%TYPE,
v_last_name     IN  employees.last_name%TYPE,
v_email         IN  employees.email%TYPE,
v_job           IN  employees.job_id%TYPE :='SA_REP',
v_mgr           IN  employees.manager_id%TYPE := 145,
v_sal           IN  employees.salary%TYPE := 1000,
v_comm          IN  employees.commission_pct%TYPE := 0,
v_deptid        IN  employees.department_id%TYPE := 30) IS
BEGIN
    IF valid_deptid(v_deptid) THEN
        INSERT INTO employees(employee_id, first_name, last_name, email, hire_date, job_id, manager_id, salary, commission_pct, department_id)
        VALUES (employees_seq.NEXTVAL, v_first_name, v_last_name, v_email, TRUNC(SYSDATE), v_job, v_mgr, v_sal, v_comm, v_deptid);
    ELSE    
        RAISE_APPLICATION_ERROR(-20204, 'Invalid Department ID. Try again.');
    END IF;    
END add_employee;
/

EXECUTE add_employee('JANE', 'Harris', 'JAHARRIS', v_deptid => 15)

EXECUTE add_employee('Joe', 'Harris', 'Jaharris', v_deptid => 80)

SELECT * FROM employees WHERE last_name = 'Harris';



