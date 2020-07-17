SET SERVEROUTPUT ON
DECLARE 
    TYPE t_rec IS RECORD --to notify that this is record
        (v_sal number(8), v_minsal number(8) default 1000,
        v_hire_date employees.hire_date%type, --record.column_name
        v_rec1 employees%rowtype);
    v_myrec t_rec;
BEGIN
    v_myrec.v_sal := v_myrec.v_minsal + 500;
    v_myrec.v_hire_date := sysdate;
    SELECT * INTO v_myrec.v_rec1 FROM employees WHERE employee_id = 100;
    DBMS_OUTPUT.PUT_LINE(v_myrec.v_rec1.last_name || ' ' || to_char(v_myrec.v_hire_date) || ' ' || to_char(v_myrec.v_sal));
END;



--lab_06_14_ns
SET SERVEROUTPUT ON
SET VERIFY OFF

CREATE TABLE retired_emps
   (EMPNO      NUMBER(4),
    ENAME      VARCHAR2(10),
    JOB        VARCHAR2(9),
    MGR        NUMBER(4),
    HIREDATE   DATE,
    LEAVEDATE  DATE,
    SAL        NUMBER(7,2),
    COMM       NUMBER(7,2),
    DEPTNO     NUMBER(2))
/

DELETE FROM retired_emps;


CREATE TABLE retired_emps
   (EMPNO      NUMBER(4),
    ENAME      VARCHAR2(10),
    JOB        VARCHAR2(9),
    MGR        NUMBER(4),
    HIREDATE   DATE,
    LEAVEDATE  DATE,
    SAL        NUMBER(7,2),
    COMM       NUMBER(7,2),
    DEPTNO     NUMBER(2))
/

DECLARE
  v_employee_number number:= 124;
  v_emp_rec   retired_emps%ROWTYPE;
BEGIN
 SELECT employee_id, last_name, job_id, manager_id, hire_date, hire_date,
  salary, commission_pct, department_id 
 INTO v_emp_rec FROM employees
 WHERE  employee_id = v_employee_number;
 INSERT INTO retired_emps  VALUES v_emp_rec;
END;
/
SELECT * FROM retired_emps;
/

SET VERIFY OFF
DECLARE
  v_employee_number number:= 124;
  v_emp_rec  retired_emps%ROWTYPE;
BEGIN
 SELECT * INTO v_emp_rec FROM retired_emps;
 v_emp_rec.leavedate:=CURRENT_DATE;
 UPDATE retired_emps SET ROW = v_emp_rec WHERE 
  empno=v_employee_number;
END;
/
SELECT * FROM retired_emps;
/

--

drop table empl;
create table empl( ename  VARCHAR2(25 BYTE),
hiredt date);

DECLARE
TYPE ename_table_type IS TABLE OF
  employees.last_name%TYPE INDEX BY PLS_INTEGER;
TYPE hiredate_table_type
IS 
  TABLE OF DATE INDEX BY PLS_INTEGER;
  ename_table ename_table_type;
  hiredate_table hiredate_table_type;
BEGIN
  ename_table(1)    := 'CAMERON';
  hiredate_table(8) := SYSDATE + 7;
  IF ename_table.EXISTS(1) THEN
    insert into empl VALUES (ename_table(1), hiredate_table(8));
  END IF;
END;
/
select * from empl;
/

--

SET SERVEROUTPUT ON
DECLARE
TYPE dept_table_type
IS
  TABLE OF departments%ROWTYPE INDEX BY VARCHAR2(20);
  dept_table dept_table_type;
  -- Each element of dept_table is a record
BEGIN
   SELECT * INTO dept_table(1) FROM departments WHERE department_id = 10;
   DBMS_OUTPUT.PUT_LINE(dept_table(1).department_id ||' '||
    dept_table(1).department_name ||' '|| dept_table(1).manager_id);
END;
/






