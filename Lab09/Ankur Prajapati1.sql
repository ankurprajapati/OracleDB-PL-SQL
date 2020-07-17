CREATE OR REPLACE TRIGGER secure_emp
BEFORE INSERT ON employees
BEGIN
    IF (TO_CHAR(SYSDATE, 'DY') IN ('SAT','SUN')) OR 
        (TO_CHAR (SYSDATE, 'HH24:MI'))
        NOT BETWEEN '14:00' AND '16:00' THEN 
        RAISE_APPLICATION_ERROR(-20500, 'You may insert' || ' into EMPLOYEES table only during' || ' normal business hours.'); 
    END IF;
END;

INSERT INTO EMPLOYEES(employee_id, last_name, first_name, email, hire_date, job_id, salary, department_id)
VALUES (300, 'Smith', 'Rob', 'RSMITH', SYSDATE, 'IT_PROG', 4500, 60);



CREATE OR REPLACE TRIGGER secure_emp
BEFORE INSERT OR UPDATE OR DELETE ON employees
BEGIN
 IF (TO_CHAR(SYSDATE,'DY') IN ('SAT','SUN')) OR
    (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN '15:00' AND '16:00') THEN
   IF DELETING THEN
     RAISE_APPLICATION_ERROR(-20502,
       'You may delete from EMPLOYEES table only during normal business hours.');
   ELSIF INSERTING THEN
     RAISE_APPLICATION_ERROR(-20500,
       'You may insert into EMPLOYEES table only during normal business hours.');
   ELSIF UPDATING('SALARY') THEN
     RAISE_APPLICATION_ERROR(-20503,
       'You may update SALARY only during normal business hours.');
   ELSE
     RAISE_APPLICATION_ERROR(-20504,
       'You may update EMPLOYEES table only during normal business hours.');
   END IF;
 END IF;
END;
/

ALTER TRIGGER secure_emp DISABLE;

CREATE OR REPLACE TRIGGER restrict_salary
BEFORE INSERT OR UPDATE OF salary ON employees
FOR EACH ROW
BEGIN
  IF NOT (:NEW.job_id IN ('AD_PRES', 'AD_VP'))
     AND :NEW.salary > 15000 THEN
    RAISE_APPLICATION_ERROR (-20202,
      'Employee cannot earn more than $15,000.');
  END IF;
END;
/

UPDATE employees SET salary = 15500 WHERE last_name = 'Russell';








CREATE TABLE audit_emp (
  user_name     VARCHAR2(30),
  time_stamp    date,
  id            NUMBER(6),
  old_last_name VARCHAR2(25),
  new_last_name VARCHAR2(25),
  old_title     VARCHAR2(10),
  new_title     VARCHAR2(10),
  old_salary    NUMBER(8,2),
  new_salary    NUMBER(8,2)
)
/

CREATE OR REPLACE TRIGGER audit_emp_values
AFTER DELETE OR INSERT OR UPDATE ON employees
FOR EACH ROW
BEGIN
  INSERT INTO audit_emp(user_name, time_stamp, id,
    old_last_name, new_last_name, old_title,
    new_title, old_salary, new_salary)
  VALUES (USER, SYSDATE, :OLD.employee_id,
    :OLD.last_name, :NEW.last_name, :OLD.job_id,
    :NEW.job_id, :OLD.salary, :NEW.salary);
END;

INSERT INTO employees (employee_id, last_name, job_id, salary, email, hire_date)
VALUES (999, 'Temp emp', 'SA_REP', 6000, 'TEMPEMP', TRUNC(SYSDATE))
/
UPDATE employees
 SET salary = 7000, last_name = 'Smith'
 WHERE employee_id = 999
/
SELECT  * FROM  audit_emp;    



UPDATE employees SET department_id = 996 WHERE employee_id = 170; 

CREATE OR REPLACE TRIGGER employee_dept_fk_trg
AFTER UPDATE OF department_id
ON employees FOR EACH ROW
BEGIN
 INSERT INTO departments VALUES(:new.department_id,
     'Dept '||:new.department_id, NULL, NULL);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
    NULL; -- mask exception if department exists
END;
/

UPDATE employees SET department_id = 996 WHERE employee_id = 170;




DESC user_triggers

CREATE TABLE log_trig_table(
  user_id  VARCHAR2(30),
  log_date DATE,
   action  VARCHAR2(40))
/

CREATE OR REPLACE TRIGGER logon_trig
AFTER LOGON  ON  SCHEMA
BEGIN
 INSERT INTO log_trig_table(user_id,log_date,action)
 VALUES (USER, SYSDATE, 'Logging on');
END;
/

CREATE OR REPLACE TRIGGER logoff_trig
BEFORE LOGOFF  ON  SCHEMA
BEGIN
 INSERT INTO log_trig_table(user_id,log_date,action)
 VALUES (USER, SYSDATE, 'Logging off');
END;
/

