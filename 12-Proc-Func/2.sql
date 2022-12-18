/*2.1. Повторити виконання завдання 1 етапу 1, створивши процедуру з вхідним
параметром у вигляді кількості рядків, що вносяться.
Навести приклад виконання створеної процедури.
*/

CREATE OR REPLACE PROCEDURE insert_proc (number_of_iter IN NUMBER)
IS
	t1 TIMESTAMP;
	t2 TIMESTAMP;
	delta NUMBER;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Iterations = ' || number_of_iter);
    t1 := SYSTIMESTAMP;
    FOR i IN 1..number_of_iter
        LOOP
            INSERT INTO purchase (
			    order_id,
				medicine_id,
				order_date,
				total,
				seller,
				buyer
				)
            VALUES (
			    order_id_seq.NEXTVAL,
				4,
				TO_DATE('16/04/2022', 'DD/MM/YYYY'),
				700,
				2,
				2
				);
        END LOOP;
		t2 := SYSTIMESTAMP;
		delta := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'), '999999.999') -
						   TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'),'999999.999');
		DBMS_OUTPUT.PUT_LINE('Time (millisec) = ' || delta);
END;
/

DECLARE
	number_of_iter NUMBER(5);
BEGIN
	number_of_iter := 4000;
	insert_proc(number_of_iter);
END;
/

/*
Iterations = 4000
Time (millisec) = 40.504
*/

/*2.2. Створити функцію, яка повертає суму значень однієї з цілих колонок однієї з
таблиць. Навести приклад виконання створеної функції.
*/

CREATE OR REPLACE FUNCTION emp_sal_sum_in_pharm (pharm_id employee.pharmacy_id%TYPE)
RETURN NUMBER
IS
	query VARCHAR2(500);
	sal_sum NUMBER;
BEGIN
	query := 'SELECT SUM(salary) FROM employee WHERE pharmacy_id = :1';
	EXECUTE IMMEDIATE query INTO sal_sum USING IN pharm_id;
	RETURN sal_sum;
END;
/

EXECUTE DBMS_OUTPUT.PUT_LINE('Salary in chosen pharmacy = ' || emp_sal_sum_in_pharm(1));

/*
Salary in chosen pharmacy = 1950
*/