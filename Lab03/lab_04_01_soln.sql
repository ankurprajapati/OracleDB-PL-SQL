SET SERVEROUT ON
DECLARE
    v_max_deptno NUMBER;
BEGIN
    SELECT MAX(department_id)
    INTO v_max_deptno
    FROM departments;
    DBMS_OUTPUT.PUT_LINE('The Max of Department No is: '|| v_max_deptno);
END;
/