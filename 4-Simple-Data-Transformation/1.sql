/*1.1. Для всіх таблиць нової БД створити генератори послідовності, щоб забезпечити
автоматичне створення нових значень колонок, які входять у первинний ключ. Врахувати наявність
рядків у таблицях. Виконати тестове внесення одного рядка до кожної таблиці.
*/

SELECT MAX(costumer_id) 
	FROM costumer;

/*
MAX(COSTUMER_ID)
----------------
              2
*/

CREATE SEQUENCE costumer_id_s START WITH 3;
INSERT INTO costumer 
	(costumer_id, 
	first_name, 
	last_name, 
	phone_number)
	VALUES 
	(costumer_id_s.nextval, 
	'John', 
	'Johnson', 
	'+38013313111');

SELECT MAX(employee_id) 
	FROM employee;

/*
MAX(EMPLOYEE_ID)
----------------
              2
*/

CREATE SEQUENCE employee_id_s START WITH 3;
INSERT INTO employee 
	(employee_id, 
	first_name, 
	last_name, 
	phone_number, 
	pharmacy_id)
	VALUES 
	(employee_id_s.nextval, 
	'Example1', 
	'Example2', 
	'+38092131111', 
	1);

SELECT MAX(medicine_id) FROM medicine;

/*
MAX(MEDICINE_ID)
----------------
              2
*/

CREATE SEQUENCE medicine_id_s START WITH 3;
INSERT INTO medicine 
	(medicine_id, 
	name, 
	price, 
	production_date, 
	expiration_date)
	VALUES 
	(medicine_id_s.nextval, 
	'Omega 3', 
	276, 
	'12.12.2020', 
	'12.12.2024');

SELECT MAX(order_id) 
	FROM order_;

/*
MAX(ORDER_ID)
----------------
              2
*/

CREATE SEQUENCE order_id_s START WITH 3;
INSERT INTO order_ 
	(order_id, 
	medicine_id, 
	order_date, total, 
	seller, 
	buyer)
	VALUES 
	(order_id_s.nextval, 
	3, 
	'12.12.2020', 
	276, 
	1, 
	2);

SELECT MAX(pharmacy_id) FROM pharmacy;

/*
MAX(PHARMACY_ID)
----------------
              4
*/

CREATE SEQUENCE pharmacy_id_s START WITH 5;
INSERT INTO pharmacy 
	(pharmacy_id, 
	name, 
	location, 
	medicine_id, 
	med_delivery_date)
	VALUES 
	(pharmacy_id_s.nextval, 
	'Somename', 
	'Odesa, main street 2', 
	3, 
	'20.12.2021');

SELECT MAX(warehouse_id) FROM warehouse;

/*
MAX(WAREHOUSE_ID)
----------------
              2
*/

CREATE SEQUENCE warehouse_id_s START WITH 3;
INSERT INTO warehouse 
	(warehouse_id, 
	name, 
	location, 
	medicine_id)
	VALUES 
	(warehouse_id_s.nextval, 
	'Somename', 
	'Odesa, main street 3', 
	3);

/*1.2 Для всіх пар взаємопов'язаних таблиць створити транзакції, що включають дві INSERT-
команди внесення рядка в дві таблиці кожної пари з урахуванням зв'язку між PK-колонкою першої
таблиці і FK-колонкою 2-ї таблиці пари з використанням псевдоколонок NEXTVAL і CURRVAL.
*/

INSERT INTO employee 
	(employee_id, 
	first_name, 
	last_name, 
	phone_number, 
	pharmacy_id)
	VALUES 
	(employee_id_s.NEXTVAL, 
	'Somename', 
	'Somelastname', 
	'+380995599559', 
	pharmacy_id_s.CURRVAL);

INSERT INTO order_ 
	(order_id, 
	medicine_id, 
	order_date, 
	total, 
	seller, 
	buyer)
	VALUES 
	(order_id_s.nextval, 
	medicine_id_s.CURRVAL, 
	'12.12.2020', 
	276,  
	employee_id_s.CURRVAL, 
	costumer_id_s.CURRVAL);

INSERT INTO pharmacy 
	(pharmacy_id, 
	name, 
	location, 
	medicine_id, 
	med_delivery_date)
	VALUES 
	(pharmacy_id_s.nextval, 
	'Somename', 
	'Odesa, main street 3', 
	medicine_id_s.CURRVAL, 
	'25.12.2021');

INSERT INTO warehouse 
	(warehouse_id, 
	name, 
	location, 
	medicine_id)
	VALUES 
	(warehouse_id_s.nextval, 
	'Somename', 
	'Odesa, main street 4', 
	medicine_id_s.CURRVAL);

/*1.3 Отримати інформацію про створені генератори послідовностей, використовуючи системну
таблицю СУБД Oracle.
*/

SELECT * FROM USER_SEQUENCES;

/*
SEQUENCE_NAME
--------------------------------------------------------------------------------
 MIN_VALUE  MAX_VALUE INCREMENT_BY C O CACHE_SIZE LAST_NUMBER S E S K
---------- ---------- ------------ - - ---------- ----------- - - - -
COSTUMER_ID_S
         1 1.0000E+28            1 N N         20          43 N N N N

EMPLOYEE_ID_S
         1 1.0000E+28            1 N N         20          23 N N N N

MEDICINE_ID_S
         1 1.0000E+28            1 N N         20           3 N N N N


SEQUENCE_NAME
--------------------------------------------------------------------------------
 MIN_VALUE  MAX_VALUE INCREMENT_BY C O CACHE_SIZE LAST_NUMBER S E S K
---------- ---------- ------------ - - ---------- ----------- - - - -
ORDER_ID_S
         1 1.0000E+28            1 N N         20           3 N N N N

PHARMACY_ID_S
         1 1.0000E+28            1 N N         20           5 N N N N

WAREHOUSE_ID_S
         1 1.0000E+28            1 N N         20           3 N N N N

*/

/*1.4 Використовуючи СУБД Oracle >= 12 для однієї з таблиць створити генерацію унікальних
значень PK-колонки через DEFAULT-оператор. Виконати тестове внесення одного рядка до таблиці.
*/

ALTER TABLE costumer 
	MODIFY (costumer_id number DEFAULT costumer_id_s.nextval);
    
INSERT INTO costumer 
	(first_name, 
	last_name, 
	phone_number) 
	VALUES 
	('Qwe', 
	'asd', 
	'+380912312322');