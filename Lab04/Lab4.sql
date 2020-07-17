SELECT * FROM countries;

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    v_countryid  VARCHAR2(20) := 'CA';
    v_countryid1  VARCHAR2(20) := 'DK';
    v_countryid2  VARCHAR2(20) := 'UK';
    v_countryid3  VARCHAR2(20) := 'US';
    v_country_record countries%ROWTYPE;
BEGIN
    SELECT * INTO v_country_record FROM countries WHERE COUNTRY_ID = v_countryid;
    DBMS_OUTPUT.PUT_LINE ('Country Id: ' || v_country_record.country_id || ' Country Name: ' || v_country_record.country_name || ' Region: ' || v_country_record.region_id);
    SELECT * INTO v_country_record FROM countries  WHERE COUNTRY_ID = v_countryid1;
    DBMS_OUTPUT.PUT_LINE ('Country Id: ' || v_country_record.country_id || ' Country Name: ' || v_country_record.country_name || ' Region: ' || v_country_record.region_id);
    SELECT * INTO v_country_record FROM countries  WHERE COUNTRY_ID = v_countryid2;
    DBMS_OUTPUT.PUT_LINE ('Country Id: ' || v_country_record.country_id || ' Country Name: ' || v_country_record.country_name || ' Region: ' || v_country_record.region_id);
    SELECT * INTO v_country_record FROM countries  WHERE COUNTRY_ID = v_countryid3;
    DBMS_OUTPUT.PUT_LINE ('Country Id: ' || v_country_record.country_id || ' Country Name: ' || v_country_record.country_name || ' Region: ' || v_country_record.region_id);
END;
------------------------------------------------

SET SERVEROUTPUT ON
DECLARE
    TYPE dept_table_type is table of departments.department_name%TYPE INDEX BY PLS_INTEGER;
    my_dept_table dept_table_type;
    f_loop_count NUMBER := 10;
    v_dept_no NUMBER := 0;
BEGIN
    FOR i in 1.. f_loop_count 
    LOOP
        v_dept_no := v_dept_no + 10;
        SELECT department_name INTO my_dept_table(i) FROM departments WHERE department_id = v_dept_no;
     END LOOP;
     
     FOR i in 1..f_loop_count
     LOOP
        dbms_output.put_line(my_dept_table(i));
     END LOOP;
END;
/
-------------------------------------------------------

SET SERVEROUTPUT ON
DECLARE
    TYPE dept_table_type is table of departments%ROWTYPE INDEX BY PLS_INTEGER;
    my_dept_table dept_table_type;
    f_loop_count NUMBER := 10;
    v_dept_no NUMBER := 0;
BEGIN
    FOR i in 1.. f_loop_count 
    LOOP
        v_dept_no := v_dept_no + 10;
        SELECT * INTO my_dept_table(i) FROM departments WHERE department_id = v_dept_no;
     END LOOP;
     dbms_output.put_line('Information regarding departments is below: ');
     FOR i in 1..f_loop_count
     LOOP
       dbms_output.put_line('Department Number: ' || my_dept_table(i).department_id|| ', Department Name: ' ||
                            my_dept_table(i).department_name || ', Manager Id: '|| my_dept_table(i).manager_id ||
                            ', and Location Id: ' || my_dept_table(i).location_id);
     END LOOP;
END;
/    
     








