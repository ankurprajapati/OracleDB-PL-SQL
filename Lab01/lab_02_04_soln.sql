SET SERVEROUTPUT ON
DECLARE
    v_today DATE;
    today DATE := SYSDATE;
    v_tomorrow  today%TYPE;
BEGIN
    v_tomorrow := today + 1;
    DBMS_OUTPUT.PUT_LINE('Hello World');
    DBMS_OUTPUT.PUT_LINE('TODAY IS :' || today);
    DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
END;

