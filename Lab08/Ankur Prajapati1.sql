CREATE OR REPLACE PROCEDURE read_file(p_dir VARCHAR2, p_filename VARCHAR2) IS
  f_file UTL_FILE.FILE_TYPE;
  buffer VARCHAR2(200);
  lines  PLS_INTEGER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE(' Start ');
  IF NOT UTL_FILE.IS_OPEN(f_file) THEN
    DBMS_OUTPUT.PUT_LINE(' Open ');
    f_file := UTL_FILE.FOPEN (p_dir, p_filename, 'R');
    DBMS_OUTPUT.PUT_LINE(' Opened ');
    BEGIN
      LOOP
        UTL_FILE.GET_LINE(f_file, buffer);
        lines := lines + 1;
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(lines, '099')||' '||buffer);
      END LOOP;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         DBMS_OUTPUT.PUT_LINE(' ** End of File **');
    END;
    DBMS_OUTPUT.PUT_LINE(lines||' lines read from file');
    UTL_FILE.FCLOSE(f_file);
  END IF;
END read_file;
/
SHOW ERRORS

SET SERVEROUTPUT ON
EXECUTE read_file('REPORTS_DIR', 'instructor.txt')








--Create Table USING Dynamic SQL

CREATE OR REPLACE PROCEDURE create_table(
  p_table_name VARCHAR2, p_col_specs  VARCHAR2) IS
BEGIN
  EXECUTE IMMEDIATE 
   'CREATE TABLE ' || p_table_name || ' (' || p_col_specs || ')';
END;
/

BEGIN
  create_table('EMPLOYEE_NAMES',
   'id NUMBER(4) PRIMARY KEY, name VARCHAR2(40)');
END;
/








SET SERVEROUTPUT ON
--Delete rows from any table
CREATE FUNCTION del_rows(p_table_name VARCHAR2)
RETURN NUMBER IS
BEGIN
  EXECUTE IMMEDIATE 'DELETE FROM '|| p_table_name;
  RETURN SQL%ROWCOUNT;
END;
/
BEGIN
  DBMS_OUTPUT.PUT_LINE(del_rows('EMPLOYEE_NAMES')|| ' rows deleted.');
END;
/

CREATE PROCEDURE add_row(p_table_name VARCHAR2,
   p_id NUMBER, p_name VARCHAR2) IS
BEGIN
  EXECUTE IMMEDIATE 'INSERT INTO '|| p_table_name||
        ' VALUES (:1, :2)' USING p_id, p_name;
END;
/


CREATE FUNCTION get_emp(p_emp_id NUMBER)
RETURN employees%ROWTYPE IS
    v_stmt VARCHAR2(200);
    v_emprec employees%ROWTYPE;
    BEGIN
        v_stmt := 'SELECT * FROM EMPLOYEES ' || 'WHERE employee_id = :p_emp_id';
        EXECUTE IMMEDIATE v_stmt INTO v_emprec USING p_emp_id;
        RETURN v_emprec;
    END;
    /
    DECLARE
        v_emprec employees%ROWTYPE := get_emp(100);
        BEGIN
            DBMS_OUTPUT.PUT_LINE('EMP: '|| v_emprec.last_name);
        END;
        /




CREATE OR REPLACE FUNCTION delete_all_rows
  (p_table_name VARCHAR2) RETURN NUMBER IS
   v_cur_id INTEGER;
   v_rows_del    NUMBER;
BEGIN
  v_cur_id := DBMS_SQL.OPEN_CURSOR;
  DBMS_SQL.PARSE(v_cur_id,'DELETE FROM '|| p_table_name, DBMS_SQL.NATIVE);
  v_rows_del := DBMS_SQL.EXECUTE (v_cur_id);
  DBMS_SQL.CLOSE_CURSOR(v_cur_id);
  RETURN v_rows_del;
END;
/

-- Run code_06-20_as.sql before running this code example. 

SET SERVEROUTPUT ON
CREATE TABLE temp_emp AS SELECT * FROM employees;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Rows Deleted: ' || delete_all_rows('temp_emp')); 
END;
/
DROP TABLE temp_emp;









