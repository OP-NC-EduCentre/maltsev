/*1. Багатотабличне внесення даних
Задача: використовуючи один INSERT-запит, додати нового співробітника та нову аптеку,
яка належить до мережі аптек з ідентифікатором №3
*/

INSERT ALL
	INTO pharmacy (pharmacy_id, 
					name,
					location)
		VALUES (pharmacy_id_seq.NEXTVAL,
			pharmacy_name,
			'Some Location'
			)
	INTO employee (employee_id, 
					first_name, 
					last_name, 
					phone_number, 
					pharmacy_id)
		VALUES (employee_id_seq.nextval,
			'Name',
			'Sirname',
			'+388888122322',
			pharmacy_id_seq.currval
			)
SELECT name AS pharmacy_name
FROM pharmacy
WHERE pharmacy_id = 3;

select * from employee;
/*
EMPLOYEE_ID FIRST_NAME           LAST_NAME                      PHONE_NUMBER         PHARMACY_ID
----------- -------------------- ------------------------------ -------------------- -----------
          1 Devid                Blane                          +38077321423                   1
          2 Steaven              Great                          +38086564755                   2
         24 Harry                Potter                         +3809912345678                 1
          3 Somename             Somelastname                   +380995599559                  6
         45 Name                 Sirname                        +388888122322                 32
*/

select * from pharmacy;

/*
PHARMACY_ID NAME                 LOCATION             MEDICINE_ID MED_DELIV
----------- -------------------- -------------------- ----------- ---------
          1 first_pharmacy       Odesa, main street 1           1
          2 second_pharmacy      Kyiv, main street 13           2
          3 third_pharmacy       Mykolaiv some street           1
          6 Somename             Odesa, main street 2           3 20-DEC-21
         32 third_pharmacy       Some Location

*/

/*2. Використання багатостовпцевих підзапитів при зміні даних
Замінити номер аптеки, співробітника з номером 2 на такий самий, як у співробітника
з ідентифікатором 1
*/

UPDATE employee
	SET pharmacy_id = 
				(
				SELECT pharmacy_id 
				FROM employee
				WHERE employee_id = 1
				)
	WHERE employee_id = 2;
				
/*3. Видалення рядків із використанням кореляційних підзапитів.
Видалити аптеки, в яких немає працівників.
*/

DELETE FROM pharmacy p
	WHERE NOT EXISTS  
		       (SELECT pharmacy_id
 			    FROM employee e
 			    WHERE e.pharmacy_id = p.pharmacy_id);
				
/*4. Поєднаний INSERT/UPDATE запит – оператор MERGE
Створити копію таблиці з працівниками, видалити співробіникив, в яких номер починається 
на "+38099", всіх хто залишився перевести у аптеку з ідентифікатором №1. Відновити у таблиці-копії
вихідні дані.
*/

CREATE TABLE employee_copy AS
	SELECT * FROM employee;
	
DELETE FROM employee_copy
	WHERE phone_number LIKE '+38099%';
	
UPDATE employee_copy
	SET pharmacy_id = 1;
	
MERGE INTO employee A
	USING employee_copy B
		ON (a.employee_id = b.employee_id)
	WHEN MATCHED THEN
		UPDATE SET a.pharmacy_id = b.pharmacy_id
	WHEN NOT MATCHED THEN
		INSERT (employee_id, first_name, last_name, phone_number, pharmacy_id)
		VALUES (b.employee_id, b.first_name, b.last_name, b.phone_number, b.pharmacy_id);
		