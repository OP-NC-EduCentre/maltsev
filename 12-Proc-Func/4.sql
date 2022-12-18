/*4.1. З урахуванням вашої предметної області створити табличну функцію, що
повертає значення будь-яких двох колонок будь-якої таблиці з урахуванням значення однієї
з колонок, що передається як параметр. Показати приклад виклику функції.
*/

DROP TYPE emp_info_list;
DROP TYPE emp_info;

CREATE TYPE emp_info AS OBJECT (
	e_id NUMBER(4),
	name VARCHAR(15),
	salary NUMBER(5)
);
/

CREATE TYPE emp_info_list IS TABLE OF emp_info;
/

CREATE OR REPLACE FUNCTION get_emp_info_by_pharmacy (p_id IN NUMBER)
RETURN emp_info_list
AS
	emp_list emp_info_list := emp_info_list();
BEGIN
	SELECT emp_info(employee_id, first_name, salary)
		BULK COLLECT INTO emp_list
		FROM employee
		WHERE pharmacy_id = p_id;
	RETURN emp_list;
END;
/

SELECT e_id, name, salary
FROM TABLE(get_emp_info_by_pharmacy(1))
ORDER BY salary ASC;

/*
      E_ID NAME                SALARY
---------- --------------- ----------
         1 Devid                  600
         6 Adam                   600
         4 Harry                  750
*/

/*4.2. Повторіть рішення попереднього завдання, але з використанням конвеєрної
табличної функції.
*/

-- створення пакету

CREATE OR REPLACE PACKAGE emp_info_pack IS
	TYPE emp_info IS RECORD (
		e_id NUMBER(4),
		name VARCHAR(15),
		salary NUMBER(5)
	);
	TYPE emp_info_list IS TABLE OF emp_info;
	FUNCTION get_emp_info_by_pharmacy (p_id IN NUMBER)
		RETURN emp_info_list PIPELINED;
END emp_info_pack;
/

-- створення тіла пакету

CREATE OR REPLACE PACKAGE BODY emp_info_pack IS
	FUNCTION get_emp_info_by_pharmacy (p_id IN NUMBER)
		RETURN emp_info_list PIPELINED
	AS
	BEGIN
		FOR elem IN (SELECT employee_id, first_name, salary 
					FROM employee
					WHERE pharmacy_id = p_id) LOOP
			PIPE ROW(elem);
		END LOOP;
	END;
END emp_info_pack; 
/

-- виклик функції з пакету

SELECT e_id, name, salary
FROM TABLE(emp_info_pack.get_emp_info_by_pharmacy(1))
ORDER BY salary ASC;

/*
      E_ID NAME                SALARY
---------- --------------- ----------
         1 Devid                  600
         6 Adam                   600
         4 Harry                  750
*/