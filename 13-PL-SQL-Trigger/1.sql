/*1. Створити інформуючий тригер для виведення повідомлення на екран після
додавання, зміни або видалення рядка з будь-якої таблиці Вашої бази даних із зазначенням
у повідомленні операції, на яку зреагував тригер. Навести тест-кейс перевірки роботи
тригера.
*/

CREATE OR REPLACE TRIGGER react_after_changes
	AFTER INSERT OR UPDATE OR DELETE ON employee 
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('Inserting into employee');
	ELSIF UPDATING THEN
	    DBMS_OUTPUT.PUT_LINE('Updating employee table');
	ELSIF DELETING THEN
	    DBMS_OUTPUT.PUT_LINE('Deleting from employee table');
	END IF;
END;
/

UPDATE employee SET first_name = 'James' WHERE employee_id = 1;

/*
Updating employee table

1 row updated.
*/

INSERT INTO employee (
	employee_id,
	first_name,
	last_name,
	phone_number,
	pharmacy_id,
	salary)
VALUES (
	emp_id_seq.NEXTVAL,
	'James',
	'Jameson',
	'+38(093)123-86-76',
	null,
	200
	);

/*
Inserting into employee

1 row created.
*/

DELETE employee
WHERE phone_number = '+38(093)123-86-76';

/*
Deleting from employee table

1 row deleted.
*/

/*2. Повторити попереднє завдання лише під час роботи користувача, ім'я якого
збігається з вашим логіном. Навести тест-кейс перевірки роботи тригера.
*/

CREATE OR REPLACE TRIGGER react_before_changes
	BEFORE INSERT OR UPDATE OR DELETE ON employee 
	FOR EACH ROW
	WHEN (USER = 'MALTSEV')
BEGIN
    RAISE_APPLICATION_ERROR(-20500,
							'User ' || USER || 
							' cannot manipulate data');
END;
/

UPDATE employee SET first_name = 'James' WHERE employee_id = 1;

/*
ERROR at line 1:
ORA-20500: User MALTSEV cannot manipulate data
ORA-06512: at "MALTSEV.REACT_BEFORE_CHANGES", line 2
ORA-04088: error during execution of trigger 'MALTSEV.REACT_BEFORE_CHANGES'
*/