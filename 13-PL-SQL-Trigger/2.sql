/*1. Створити тригер для реалізації каскадного видалення рядків зі значеннями PK-
колонки, пов'язаних з FK-колонкою. Навести тест-кейс перевірки роботи тригера.
*/

CREATE OR REPLACE TRIGGER emp_cascade_delete
	AFTER DELETE ON employee
	FOR EACH ROW
BEGIN
	DELETE FROM purchase
	WHERE seller = :OLD.employee_id;
END;
/

-- тест

DELETE FROM employee;

/*
Deleting from employee table

6 rows deleted.
*/

/*2. Створити тригер для реалізації предметно-орієнтованого контролю спроби
додавання значення FK-колонки, що не існує у PK-колонці. Навести тест-кейс перевірки
роботи тригера.
*/

CREATE OR REPLACE TRIGGER pk_existence_check
	BEFORE INSERT ON employee
	FOR EACH ROW
DECLARE
	p_id pharmacy.pharmacy_id%TYPE;
BEGIN
	SELECT pharmacy_id
	INTO p_id
	FROM pharmacy
	WHERE pharmacy_id = :NEW.pharmacy_id;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR(
			-20551,
			'Pharmacy with id ' ||
			:NEW.pharmacy_id ||
			' does not exist'
			);
END;
/

-- тест

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
	'+38(093)123-86-74',
	1421,
	200
	);
	
/*
ERROR at line 9:
ORA-20551: Pharmacy with id 1421 does not exist
ORA-06512: at "MALTSEV.PK_EXISTENCE_CHECK", line 10
ORA-04088: error during execution of trigger 'MALTSEV.PK_EXISTENCE_CHECK'
*/