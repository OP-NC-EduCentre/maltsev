/*3.1. Оформіть рішення завдань етапу 2 у вигляді програмного пакета. Наведіть
приклад виклику збереженої процедури та функції, враховуючи назву пакету.
*/

-- Створення пакету

CREATE OR REPLACE PACKAGE emp_pharm_info_pac IS
	PROCEDURE insert_proc(number_of_iter IN NUMBER);
	FUNCTION emp_sal_sum_in_pharm(pharm_id employee.pharmacy_id%TYPE)
	RETURN NUMBER;
END emp_pharm_info_pac;
/

--Створення тіла пакету 

CREATE OR REPLACE PACKAGE BODY emp_pharm_info_pac IS
	PROCEDURE insert_proc (number_of_iter IN NUMBER)
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
	
	FUNCTION emp_sal_sum_in_pharm (pharm_id employee.pharmacy_id%TYPE)
	RETURN NUMBER
	IS
		query VARCHAR2(500);
		sal_sum NUMBER;
	BEGIN
		query := 'SELECT SUM(salary) FROM employee WHERE pharmacy_id = :1';
		EXECUTE IMMEDIATE query INTO sal_sum USING IN pharm_id;
		RETURN sal_sum;
	END;
END emp_pharm_info_pac;
/

-- виклик процедури та функції з пакету

DECLARE
	number_of_iter NUMBER(5);
BEGIN
	number_of_iter := 4000;
	emp_pharm_info_pac.insert_proc(number_of_iter);
END;
/	

/*
Iterations = 4000
Time (millisec) = .437
*/

EXECUTE DBMS_OUTPUT.PUT_LINE('Salary in chosen pharmacy = ' || emp_pharm_info_pac.emp_sal_sum_in_pharm(1));

-- Salary in chosen pharmacy = 1950