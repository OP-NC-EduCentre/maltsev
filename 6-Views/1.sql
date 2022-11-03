/*1.1 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
4.2 з лабораторної роботи No3: для однієї з таблиць створити команду отримання значень усіх
колонок (явно перерахувати) за окремими рядками з урахуванням умови, в якій рядкове
значення однієї з колонок має співпадати з якимось константним значенням. Отримати вміст
таблиці.
*/

CREATE OR REPLACE VIEW medicine_noshpa
	(id, 
	name, 
	price,
	production_date, 
	expiration_date)
	AS
	SELECT medicine_id,
    name,
    price,
    production_date, 
    expiration_date
    FROM medicine 
	WHERE name = 'noshpa';
	
SELECT * FROM medicine_noshpa;

/*
        ID NAME                                     PRICE PRODUCTIO EXPIRATIO
---------- ----------------------------------- ---------- --------- ---------
         2 noshpa                                   177.9 13-OCT-21 13-OCT-28
*/

/*1.2 Виконати команду зміни значення колонки створеної віртуальної таблиці на
значення, яке входить в умову вибірки рядків із рішення попереднього завдання, при цьому нове
значення має відрізнятись від поточного.
*/

UPDATE medicine_noshpa
	SET price = price+(price*0.05)
	WHERE name = 'noshpa';
	
SELECT * FROM medicine_noshpa;
/*
        ID NAME                                     PRICE PRODUCTIO EXPIRATIO
---------- ----------------------------------- ---------- --------- ---------
         2 noshpa                                   186.8 13-OCT-21 13-OCT-28
*/
	
/*1.3 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
3.2 з лабораторної роботи No4: для двох таблиць, пов'язаних через PK-колонку та FK-колонку,
створити команду отримання двох колонок першої та другої таблиць з використанням екві-
сполучення таблиць. Отримати вміст таблиці.
*/

CREATE OR REPLACE VIEW employee_pharmacy
	(first_name,
	last_name,
	location)
AS
SELECT 
    e.first_name, 
	e.last_name, 
	p.location
	FROM employee e
	INNER JOIN pharmacy p
	ON (e.pharmacy_id = p.pharmacy_id);
	
SELECT * FROM employee_pharmacy;

/*
FIRST_NAME           LAST_NAME                      LOCATION
-------------------- ------------------------------ --------------------
Devid                Blane                          Odesa, main street 1
Steaven              Great                          Kyiv, main street 13
Somename             Somelastname                   Odesa, main street 2
*/

/*1.4 Виконати команду додавання нового рядка до однієї з таблиць, що входить до запиту
з попереднього завдання.
*/

INSERT INTO employee 
	(employee_id, 
	first_name, 
	last_name, 
	phone_number, 
	pharmacy_id) 
VALUES (employee_id_s.nextval , 
	'Harry', 
	'Potter', 
	'+3809912345678', 
	1);

SELECT * FROM employee_pharmacy;

/*
FIRST_NAME           LAST_NAME                      LOCATION
-------------------- ------------------------------ --------------------
Devid                Blane                          Odesa, main street 1
Harry                Potter                         Odesa, main street 1
Steaven              Great                          Kyiv, main street 13
Somename             Somelastname                   Odesa, main street 2
*/