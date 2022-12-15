/*2.1. Повторити виконання завдання 3 етапу 1, забезпечивши контроль відсутності даних у 
відповіді на запит із використанням винятку.
*/

DECLARE
    v_emp_sal employee.salary%TYPE;
	v_emp_pharm employee.pharmacy_id%TYPE;
BEGIN
    v_emp_pharm := 3;
    SELECT salary
    INTO v_emp_sal
    FROM employee
    WHERE pharmacy_id = v_emp_pharm;
    DBMS_OUTPUT.PUT_LINE('Salary on pharmacy #' || v_emp_pharm || ' = ' || v_emp_sal);
EXCEPTION
	WHEN NO_DATA_FOUND 
	THEN DBMS_OUTPUT.PUT_LINE('Pharmacy №' || v_emp_pharm || ' data not found');
END;
/

-- Pharmacy №3 data not found

/*2.2. Повторити виконання завдання 3 етапу 1, забезпечивши контроль отримання 
багаторядкової відповіді на запит.
*/

DECLARE
    v_emp_sal employee.salary%TYPE;
	v_emp_pharm employee.pharmacy_id%TYPE;
BEGIN
    v_emp_pharm := 2;
    SELECT salary
    INTO v_emp_sal
    FROM employee
    WHERE pharmacy_id = v_emp_pharm;
    DBMS_OUTPUT.PUT_LINE('Salary of employee on pharmacy #' || v_emp_pharm || ' = ' || v_emp_sal);
EXCEPTION
	WHEN TOO_MANY_ROWS 
	THEN DBMS_OUTPUT.PUT_LINE('More then one row was returned');
END;
/

-- More then one row was returned

/*2.3. Повторити виконання завдання 3 етапу 1, забезпечивши контроль за внесенням 
унікальних значень.
*/

DECLARE
    med_id medicine.medicine_id%TYPE;
BEGIN
    med_id := med_id_seq.NEXTVAL;
    INSERT INTO medicine(
	    medicine_id,
		name,
		price,
		production_date,
		expiration_date)
	VALUES (
		4,
		'painkiller',
		770,
		TO_DATE('03.12.2022', 'DD/MM/YYYY'),
		TO_DATE('03.12.2026', 'DD/MM/YYYY')
		);
EXCEPTION
	WHEN DUP_VAL_ON_INDEX
	THEN DBMS_OUTPUT.PUT_LINE('Cannot insert duplicate data in DB');
END;
/

-- Cannot insert duplicate data in DB