/*7.1 Виконати запит до БД, результат якого відповідає результату виконання запиту на підставі
рішення завдання No 4.2 лабораторної роботи No 3:
Для однієї з таблиць створити команду отримання значень всіх колонок (явно перерахувати) за
окремими рядками з урахуванням умови: символьне значення однієї з колонок має співпадати з якимось
константним значенням.
*/

SELECT Medicine.object_id id,
    Medicine.name name,
    price.value price,
    production_date.date_value production_date, 
    expiration_date.date_value expiration_date
FROM objects Medicine,
	objtype Medicine_type,
	attributes price,
	attributes production_date,
	attributes expiration_date
WHERE Medicine_type.code = 'Medicine'
	AND Medicine_type.object_type_id = Medicine.object_type_id
	AND Medicine.object_id = price.object_id
	AND price.attr_id = 2
	AND Medicine.object_id = production_date.object_id
	AND production_date.attr_id = 3
	AND Medicine.object_id = expiration_date.object_id
	AND expiration_date.attr_id = 4 
	AND Medicine.name = 'noshpa';
/*
ID	NAME	PRICE	PROD_DATE	EXP_DATE
2	noshpa	177,9	13.10.21	13.10.28
*/

/*7.2 Виконати запит до БД, результат якого відповідає результату виконання запиту на підставі
рішення завдання No 6.1 лабораторної роботи No 3:
Для однієї з таблиць створити команду отримання кількості рядків таблиці.
*/

SELECT COUNT (object_id) AS "Number of medicines" 
	FROM objects
	WHERE object_type_id = 1;
/*
Number of medicines
-------------------
                  2
*/

/*7.3 Виконати запит до БД, результат якого відповідає результату виконання запиту на підставі
рішення завдання No 3.2 лабораторної роботи No 4:
Для двох таблиць, пов'язаних через PK-колонку та FK-колонку, створити команду отримання двох
колонок першої та другої таблиць з використанням екві-з’єднання таблиць. Використовувати префікси.
*/
	
SELECT 
    Employee_first_name.value AS first_name, 
	Employee_last_name.value AS last_name, 
	Pharmacy_location.value AS location
FROM objects Employee,
	objects Pharmacy,
	attributes Employee_first_name,
	attributes Employee_last_name,
	attributes Pharmacy_location
WHERE Employee.parent_id = Pharmacy.object_id
	AND Employee.object_id = Employee_first_name.object_id
	AND Employee.object_id = Employee_last_name.object_id
	AND Employee_first_name.attr_id = 7
	AND Employee_last_name.attr_id = 8
	AND Pharmacy.object_id = Pharmacy_location.object_id
	AND Pharmacy_location.attr_id = 5;
	
/*
FIRST_NAME           LAST_NAME                      LOCATION
-------------------- ------------------------------ --------------------
Devid                Blane                          first_pharmacy
Steaven              Great                          second_pharmacy
*/