/*3.1 Для будь-яких двох таблиць створити команду отримання декартового добутку.
*/

SELECT 
	employee.first_name, 
	costumer.last_name
	FROM employee 
	CROSS JOIN costumer;
	
/*
FIRST_NAME           LAST_NAME
-------------------- ------------------------------
Devid                Maltsev
Steaven              Maltsev
Devid                Smith
Steaven              Smith
Devid                Johnson
Steaven              Johnson

6 rows selected.
*/

/*3.2 Для двох таблиць, пов'язаних через PK-колонку та FK-колонку, створити команду
отримання двох колонок першої та другої таблиць з використанням екві-з’єднання таблиць.
Використовувати префікси.
*/

SELECT 
    employee.first_name, 
	employee.last_name, 
	pharmacy.location
	FROM employee 
	INNER JOIN pharmacy 
	ON (employee.pharmacy_id = pharmacy.pharmacy_id);
	
/*
FIRST_NAME           LAST_NAME                      LOCATION
-------------------- ------------------------------ --------------------
Devid                Blane                          Odesa, main street 1
Steaven              Great                          Kyiv, main street 13
*/

/*3.3 Повторити рішення попереднього завдання, застосувавши автоматичне визначення умов
екві-з’єднання.
*/

SELECT 
    employee.first_name, 
    employee.last_name, 
    pharmacy.location
    FROM employee 
    NATURAL JOIN pharmacy;

/*
FIRST_NAME           LAST_NAME                      LOCATION
-------------------- ------------------------------ --------------------
Devid                Blane                          Odesa, main street 1
Steaven              Great                          Kyiv, main street 1
*/

/*3.4 Повторити рішення завдання 3.2, замінивши еквіз'єднання на зовнішнє з'єднання
(лівостороннє або правостороннє), яке дозволить побачити рядки таблиці з PK-колонкою, не пов'язані
з FK-колонкою.
*/

SELECT 
    e.first_name,
    e.last_name,
    p.location
    FROM employee e 
    LEFT OUTER JOIN pharmacy p
    ON e.pharmacy_id = p.pharmacy_id;
	
/*
FIRST_NAME           LAST_NAME                      LOCATION
-------------------- ------------------------------ --------------------
Devid                Blane                          Odesa, main street 1
Steaven              Great                          Kyiv, main street 13
Bob                  Addxz
*/