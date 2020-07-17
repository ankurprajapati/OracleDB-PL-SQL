SET SERVEROUTPUT ON
DECLARE
    v_dept_name departments.department_name%TYPE := 'Education';
    v_max_deptno NUMBER;
    v_dept_id NUMBER;
    v_rows_affected VARCHAR2(30);
BEGIN
    SELECT MAX(department_id) INTO v_max_deptno FROM departments;
    v_dept_id := v_max_deptno + 10;
    DBMS_OUTPUT.PUT_LINE('The Max of Department No is: '|| v_max_deptno);
    --DBMS_OUTPUT.PUT_LINE(v_dept_name);
    --DBMS_OUTPUT.PUT_LINE(v_dept_id);
    INSERT INTO departments(department_name, department_id, location_id) VALUES (v_dept_name, v_dept_id, NULL); 
    v_rows_affected := ( SQL%ROWCOUNT || ' row inserted.');
    DBMS_OUTPUT.PUT_LINE(v_rows_affected);
END;
/   

SELECT department_name, department_id, location_id FROM departments WHERE department_id = 320;