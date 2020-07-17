SET SERVEROUTPUT ON
DECLARE
    v_dept_name departments.department_name%TYPE := 'Education';
    v_max_deptno NUMBER;
    v_dept_id NUMBER;
    v_rows_affected VARCHAR2(30);
BEGIN
    --SELECT MAX(department_id) INTO v_max_deptno FROM departments;
    --UPDATE departments SET location_id=3000 WHERE department_id= 320;
    DELETE FROM departments WHERE department_id=320;
    v_rows_affected := ( SQL%ROWCOUNT || ' row affected.');
    DBMS_OUTPUT.PUT_LINE(v_rows_affected);
END;
/   

SELECT * FROM departments WHERE department_id = 320;