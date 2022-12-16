/*3.1. Виконайте DELETE-запит із попередніх рішень, додавши аналіз даних із неявного 
курсору. Наприклад, кількість віддалених рядків
*/

BEGIN
    DELETE FROM purchase;
    DBMS_OUTPUT.PUT_LINE('Rows deleted = ' || SQL%ROWCOUNT);
END;
/

-- Rows deleted = 3

/*3.2. Повторіть виконання завдання 3 етапу 1 з використанням явного курсору.
*/

DECLARE
    CURSOR emp_avg_sal_by_pharm_list IS
		SELECT pharmacy_id,
	        AVG(salary) AS avg_sal
        FROM employee
	    GROUP BY pharmacy_id;
	emp_avg_sal_rec emp_avg_sal_by_pharm_list%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('pharmacy_id', 15, ' ') || 'avg_sal');
	FOR emp_avg_sal_rec IN emp_avg_sal_by_pharm_list LOOP
	    DBMS_OUTPUT.PUT_LINE(RPAD(emp_avg_sal_rec.pharmacy_id, 15, ' ')
		                          || emp_avg_sal_rec.avg_sal);
    END LOOP;
END;
/

/*
pharmacy_id    avg_sal
6              1000
1              650
2              475
*/

/*3.3. З урахуванням вашої предметної області створити анонімний PL/SQL-блок, який 
викликатиме один із варіантів подібних SQL-запитів залежно від значення версії СУБД.
При вирішенні використовувати:
− значення змінної DBMS_DB_VERSION.VERSION;
− явний курсор із параметричним циклом.
*/

-- Запит на виведення трьох працівників з найбільшою зарплатнею
 
BEGIN
    DBMS_OUTPUT.PUT_LINE('Oracle version = ' || dbms_db_version.version);
	
	IF dbms_db_version.version < 12 THEN
		DECLARE
			CURSOR emp_list IS
				WITH emp_sal_list AS (
								SELECT
									first_name,
									salary
								FROM employee
								ORDER BY salary DESC
								),
					emp_sal_rows_list AS (
								SELECT
									rownum AS r_num,
									first_name,
									salary
								FROM emp_sal_list
								)
				SELECT
					first_name,
					salary
				FROM emp_sal_rows_list
				WHERE r_num < 4;
		BEGIN
			DBMS_OUTPUT.PUT_LINE(RPAD('emp_name', 15, ' ') || 'salary');
			FOR i IN emp_list LOOP
				DBMS_OUTPUT.PUT_LINE(RPAD(i.first_name, 15, ' ')|| i.salary);
			END LOOP;
		END;
		
	ELSE
		DECLARE
			CURSOR emp_list IS
				SELECT first_name, salary
				FROM employee
				ORDER BY salary DESC FETCH FIRST 3 ROWS ONLY;
			BEGIN
				DBMS_OUTPUT.PUT_LINE(RPAD('emp_name', '15', ' ') || 'salary');
				FOR i IN emp_list LOOP
					DBMS_OUTPUT.PUT_LINE(RPAD(i.first_name, 15, ' ') || i.salary);
				END LOOP;
			END;
	END IF;
END;
/

/*
Oracle version = 18
emp_name       salary
Somename       1000
Harry          750
Devid          600
*/