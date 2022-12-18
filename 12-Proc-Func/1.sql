/*1.1. Повторіть виконання завдання 4 етапу 1 із попередньої лабораторної роботи:
− циклічно внести 5000 рядків;
− визначити загальний час на внесення зазначених рядків;
− вивести на екран значення часу.
*/

DECLARE
    t1 TIMESTAMP;
	t2 TIMESTAMP;
	delta NUMBER;
BEGIN
    t1 := SYSTIMESTAMP;
    FOR i IN 1..5000
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

-- Time (millisec) = .617

/*1.2. Повторіть виконання попереднього завдання, порівнявши час виконання
циклічних внесень рядків, використовуючи два способи: FOR і FORALL.
*/

DROP TABLE emp1;
DROP TABLE emp2;
CREATE TABLE emp1(id INTEGER, name VARCHAR2(15));
CREATE TABLE emp2(id INTEGER, name VARCHAR2(15));

DECLARE
    TYPE IdTab IS TABLE OF employee.employee_id%TYPE INDEX BY PLS_INTEGER;
    TYPE NameTab IS TABLE OF employee.first_name%TYPE INDEX BY PLS_INTEGER;
	empids IdTab;
	empnames NameTab;
	iterations CONSTANT PLS_INTEGER := 5000;
    t1 TIMESTAMP;
	t2 TIMESTAMP;
	delta NUMBER;
BEGIN
    FOR j IN 1..iterations LOOP
	    empids(j) := j;
		empnames(j) := 'Anderson' || TO_CHAR(j);		
	END LOOP;
    t1 := SYSTIMESTAMP;
    FOR i IN 1..iterations LOOP
        INSERT INTO emp1 (id, name)
        VALUES (empids(i), empnames(i));
    END LOOP;
	t2 := SYSTIMESTAMP;
	delta := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'), '999999.999') -
					   TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'),'999999.999');
	DBMS_OUTPUT.PUT_LINE('FOR IN LOOP time (millisec) = ' || delta);
	
	t1 := SYSTIMESTAMP;
	FORALL i IN 1..iterations
		INSERT INTO emp2 (id, name)
        VALUES (empids(i), empnames(i));
	t2 := SYSTIMESTAMP;
	delta := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'), '999999.999') -
					   TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'),'999999.999');
	DBMS_OUTPUT.PUT_LINE('FORALL-operator time (millisec) = ' || delta);
END;
/

/*
FOR IN LOOP time (millisec) = .339
FORALL-operator time (millisec) = .011
*/

/*1.3. Для однієї з таблиць отримайте рядки з використанням курсору та пакетної
обробки SELECT-операції з оператором BULK COLLECT.
*/

DECLARE
    CURSOR emp_list IS
	    SELECT
		    employee_id AS id,
			first_name AS name,
			salary
		FROM employee;
	emp_list_rec emp_list%ROWTYPE;
	
    TYPE Emp IS TABLE OF emp_list%ROWTYPE;
    emp_list2 Emp;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Output with using CURSOR: ');
    DBMS_OUTPUT.PUT_LINE(RPAD('id', 5, ' ') || RPAD('name', 15, ' ') || 'salary');
	FOR emp_list_rec IN emp_list LOOP
	    DBMS_OUTPUT.PUT_LINE(RPAD(emp_list_rec.id, 5, ' ')
		                          || RPAD(emp_list_rec.name, 15, ' ')
								  || emp_list_rec.salary);
    END LOOP;
    
	DBMS_OUTPUT.PUT_LINE('Output with using BULK COLLECT: ');
	SELECT
		employee_id AS id,
		first_name AS name,
		salary
	BULK COLLECT INTO emp_list2
	FROM employee;
	DBMS_OUTPUT.PUT_LINE('Employee list:');
	FOR i IN emp_list2.FIRST..emp_list2.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(emp_list2(i).id || ' : ' || 
		emp_list2(i).name || ' : ' || emp_list2(i).salary);
    END LOOP;
END;
/

/*
Output with using CURSOR:
id   name           salary
1    Devid          600
2    Steaven        550
4    Harry          750
5    John           400
6    Adam           600
3    Somename       1000
Output with using BULK COLLECT:
Employee list:
1 : Devid : 600
2 : Steaven : 550
4 : Harry : 750
5 : John : 400
6 : Adam : 600
3 : Somename : 1000
*/