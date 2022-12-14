/*1. Розробити механізм журналізації DML-операцій, що виконуються над таблицею
вашої бази даних, враховуючи такі дії:
– створити таблицю з ім'ям LOG_ім'я_таблиці. Структура таблиці повинна
включати: ім'я користувача, тип операції, дата виконання операції, атрибути, що містять
старі та нові значення.
– створити тригер журналювання.
Перевірити роботу тригера журналювання для операцій INSERT, UPDATE,
DELETE.
*/

CREATE TABLE log_employee (
	user_name VARCHAR(30),
	op_type VARCHAR(6),
	change_date DATE,
	new_emp_id NUMBER,
	new_first_name CHAR(40),
	new_last_name CHAR(40),
	new_salary NUMBER,
	new_phone_number CHAR(40),
	new_pharmacy_id NUMBER,
	old_emp_id NUMBER,
	old_first_name CHAR(40),
	old_last_name CHAR(40),
	old_salary NUMBER,
	old_phone_number CHAR(40),
	old_pharmacy_id NUMBER
)

CREATE OR REPLACE TRIGGER log_employee
	AFTER INSERT OR UPDATE OR DELETE ON employee
	FOR EACH ROW
DECLARE
	op_type_ log_employee.op_type%TYPE;
BEGIN
	IF INSERTING THEN op_type_ := 'INSERT';
		ELSIF UPDATING THEN op_type_ := 'UPDATE';
		ELSIF DELETING THEN op_type_ := 'DELETE';
	END IF;
	INSERT INTO log_employee
	VALUES (
		USER,
		op_type_,
		SYSDATE,
		:NEW.employee_id,
		:NEW.first_name,
		:NEW.last_name,
		:NEW.salary,
		:NEW.phone_number,
		:NEW.pharmacy_id,
		:OLD.employee_id,
		:OLD.first_name,
		:OLD.last_name,
		:OLD.salary,
		:OLD.phone_number,
		:OLD.pharmacy_id
		);
		DBMS_OUTPUT.PUT_LINE('Changes was logged');
END;
/

-- delete test
DELETE FROM employee
WHERE employee_id = 1;


-- insert test
INSERT INTO employee
VALUES (1, 'Devid', 'Blane', '+38(077)321-42-32', 1, 600);

/*
Changes was logged
Inserting into employee

1 row created.
*/

-- update test
UPDATE employee
SET salary = 660
WHERE employee_id = 1;

/*
Changes was logged
Updating employee table

1 row updated.
*/

SELECT * FROM log_employee;
/*
USER_NAME   OP_TYP CHANGE_DA NEW_EMP_ID NEW_FIRST_NAME   NEW_LAST_NAME  NEW_SALARY NEW_PHONE_NUMBER     NEW_PHARMACY_ID OLD_EMP_ID OLD_FIRST_NAME  OLD_LAST_NAME   OLD_SALARY OLD_PHONE_NUMBER        OLD_PHARMACY_ID
----------- ------ --------- ---------- ---------------- -------------- ---------- -------------------- --------------- ---------- --------------- --------------- ---------- ----------------------- ---------------
MALTSEV     DELETE 18-DEC-22                                                                                                     1 Devid           Blane                  600 +38(077)321-42-32                     1
MALTSEV     INSERT 18-DEC-22          1 Devid            Blane                 600 +38(077)321-42-32                  1
MALTSEV     UPDATE 18-DEC-22          1 Devid            Blane                 660 +38(077)321-42-32                  1          1 Devid           Blane                  600 +38(077)321-42-32                     1
*/


/*2. Припустимо, що використовується СУБД до 12-ї версії, яка не підтримує механізм
DEFAULT SEQUENCE, який дозволяє автоматично внести нове значення первинного
ключа, якщо воно не задано при операції внесення. Для будь-якої колонки вашої бази даних
створити тригер з підтримкою механізму DEFAULT SEQUENCE. Навести тест-кейс
перевірки роботи тригера.
*/

CREATE OR REPLACE TRIGGER emp_id_sequence
	BEFORE INSERT ON employee
	FOR EACH ROW
BEGIN
	IF :NEW.employee_id IS NULL THEN
		:NEW.employee_id := emp_id_seq.NEXTVAL;
	END IF;
	DBMS_OUTPUT.PUT_LINE('id was auto generated by trigger');
END;
/

INSERT INTO employee (
	first_name,
	last_name,
	phone_number,
	pharmacy_id,
	salary)
VALUES (
	'James',
	'Jameson',
	'+38(093)123-86-16',
	1,
	200
	);

/*
id was auto generated by trigger

1 row created.
*/

SELECT * FROM employee WHERE phone_number = '+38(093)123-86-16';

/*
EMPLOYEE_ID FIRST_NAME           LAST_NAME                      PHONE_NUMBER                                       PHARMACY_ID     SALARY
----------- -------------------- ------------------------------ -------------------------------------------------- ----------- ----------
         49 James                Jameson                        +38(093)123-86-16                                            1        200

*/