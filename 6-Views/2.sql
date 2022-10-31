/*2.1 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання 
2.3 з лабораторної роботи No5, але враховує опцію «WITH READ ONLY»: отримати інформацію
про атрибутні типи. Отримати вміст таблиці.
*/

CREATE OR REPLACE VIEW object_attr_list
	(obj_code, 
	attr_id, 
	attr_code, 
	attr_name)
AS
SELECT O.CODE,
	A.ATTR_ID,
	A.CODE,
	A.NAME
FROM OBJTYPE O, 
	ATTRTYPE A
WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
ORDER BY A.OBJECT_TYPE_ID, A.ATTR_ID
WITH READ ONLY;

SELECT * FROM object_attr_list;

/*
OBJ_CODE                ATTR_ID ATTR_CODE            ATTR_NAME
-------------------- ---------- -------------------- -------------------
Medicine                      1 NAME                 Назва
Medicine                      2 PRICE                Ціна
Medicine                      3 PRODUCTION_DATE      Дата виробництва
Medicine                      4 EXPIRATION_DATE      Вжити до
Pharmacy                      5 NAME                 Назва
Pharmacy                      6 LOCATION             Локація
Pharmacy                      7 MEDICINE_ID          Ліки
Pharmacy                      8 MED_DELIVERY_DATE    Дата доставки
Employee                      9 FIRST_NAME           Імя
Employee                     10 LAST_NAME            Прізвище
Employee                     11 PHONE_NUMBER         Телефон
Employee                     12 PHARMACY_ID          Працює в аптеці
*/

/*2.2 Виконати видалення одного рядка з віртуальної таблиці, створеної у попередньому
завданні. Прокоментувати реакцію СУБД.
*/

DELETE FROM object_attr_list
	WHERE attr_id = 1;

/*
Error report -
SQL Error: ORA-42399: невозможно выполнить операцию DML для доступного только для чтения представления
42399.0000 - "cannot perform a DML operation on a read-only view"

Коментар: Операція видалення з таблиці не може бути виконана, оскільки таблиця створена з переметром "WITH READ ONLY"
*/

/*2.3 Створити віртуальну таблицю, що містить дві колонки:
назва класу, кількість екземплярів об'єктів класу. Отримати вміст таблиці.
*/

CREATE OR REPLACE VIEW objects_amount
	(class_name, number_of_objs)
AS
SELECT objtype.name,
	COUNT(objects.object_id)
FROM objtype,
	objects
WHERE objects.object_type_id = objtype.object_type_id
GROUP BY objtype.name;

SELECT * FROM objects_amount;

/*
CLASS_NAME   OBJECTS_AMOUNT
------------ ----------------
Ліки          2
Аптека        2
Працівник     2
*/

/*2.4 Перевірити можливість виконання операції зміни даних у віртуальній таблиці,
створеної у попередньому завданні. Прокоментувати реакцію СУБД.
*/

UPDATE objects_amount 
SET number_of_objs = 3
WHERE number_of_objs = 2;

/*
ERROR at line 1:
ORA-01732: data manipulation operation not legal on this view

Коментар: DML-запити неможливо виконати на цій віртуальній таблиці, оскільки вона містить агрегатну 
функцію COUNT та пропозицію GROUP BY.
*/