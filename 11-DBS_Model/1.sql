SET SERVEROUTPUT ON;
/*1.1. Виберіть таблицю бази даних, що містить стовпець типу date. Оголосіть змінні, що 
відповідають стовпцям цієї таблиці, використовуючи посилальні типи даних. Надайте змінним 
значення, використовуйте SQL-функції для формування значень послідовності, перетворення 
дати до вибраного стилю. Виведіть на екран рядок.
*/

DECLARE
    v_med medicine%ROWTYPE;
BEGIN
    v_med.medicine_id := med_id_seq.NEXTVAL;
	v_med.name := 'pills';
	v_med.price := 420;
	v_med.production_date := TO_DATE('03.12.2022', 'DD/MM/YYYY');
	v_med.expiration_date := TO_DATE('03.12.2026', 'DD/MM/YYYY');
	DBMS_OUTPUT.PUT_LINE('med_id = ' || v_med.medicine_id);
	DBMS_OUTPUT.PUT_LINE('prod_date = ' || v_med.production_date);
	DBMS_OUTPUT.PUT_LINE('exp_date = ' || v_med.expiration_date);
END;
/

/*
med_id = 27
prod_date = 03-DEC-22
exp_date = 03-DEC-26
*/
/*1.2. Додати інформацію до однієї з таблиць, обрану у попередньому завданні. 
Використовувати формування нового значення послідовності та перетворення формату дати. 
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
		med_id,
		'painkiller',
		770,
		TO_DATE('03.12.2022', 'DD/MM/YYYY'),
		TO_DATE('03.12.2026', 'DD/MM/YYYY')
		);
END;
/

-- PL/SQL procedure successfully completed.

/*1.3. Для однієї з таблиць створити команду отримання середнього значення однієї з 
цілих колонок, використовуючи умову вибірки за заданим значенням іншої колонки. Результат 
присвоїти змінній і вивести на екран.
*/

DECLARE
    v_emp_avg_sal employee.salary%TYPE;
BEGIN
    SELECT AVG(salary)
    INTO v_emp_avg_sal
    FROM employee
    WHERE pharmacy_id = 1;
    DBMS_OUTPUT.PUT_LINE('AVG salary on pharmacy #1 = ' || v_emp_avg_sal);
END;
/

-- AVG salary on pharmacy #1 = 650

/*1.4. Виконайте введення 5 рядків у таблицю бази даних, використовуючи цикл з 
параметрами. Значення первинного ключа генеруються автоматично, решта даних дублюється.
*/

BEGIN
    FOR i IN 1..5
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
END;
/

/*
  ORDER_ID MEDICINE_ID ORDER_DAT      TOTAL     SELLER      BUYER
---------- ----------- --------- ---------- ---------- ----------
         1           1 20-DEC-21      240.5          1          1
         2           2 13-FEB-22      177.9          2          2
         3           3 12-DEC-20        276          1          2
         4           4 16-APR-22        700          2          2
         5           4 16-APR-22        700          2          2
         6           4 16-APR-22        700          2          2
         7           4 16-APR-22        700          2          2
         8           4 16-APR-22        700          2          2
*/