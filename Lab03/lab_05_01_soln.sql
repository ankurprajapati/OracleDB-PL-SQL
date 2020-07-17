CREATE TABLE messages (results VARCHAR2(80));

BEGIN
    FOR i in 1..10 LOOP
        IF i = 6 or i = 8 THEN
        null;
        ELSE
            INSERT INTO messages(results)
            VALUES (i);
        END IF;
    END LOOP;
COMMIT;
END;
/

SELECT * FROM messages;









DROP TABLE emp;

CREATE TABLE emp AS SELECT * FROM employees;
ALTER TABLE    emp  ADD stars	VARCHAR2(50);
DECLARE
    v_empno emp.employee_id%TYPE := 176;
    v_asterisk emp.stars%TYPE := NULL;
    v_sal emp.salary%TYPE;
BEGIN
    SELECT NVL(ROUND(salary/1000), 0) INTO v_sal
    FROM emp WHERE employee_id = v_empno;
    FOR i IN 1..v_sal
    LOOP
    v_asterisk := v_asterisk ||'*';
    END LOOP;
    UPDATE emp SET stars = v_asterisk
    WHERE employee_id = v_empno;
    COMMIT;
END;
/
SELECT employee_id,salary, stars FROM emp WHERE employee_id =176;