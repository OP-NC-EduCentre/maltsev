--Конструювання SELECT-команд з вибіркою (фільтруванням) даних

/*
4.1 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
	перерахувати) за окремими рядками з урахуванням умови: цілочисельне значення однієї з колонок
	має бути більшим за якесь константне значення.
*/
SELECT medicine_id,
    name,
    price,
    production_date, 
    expiration_date
    FROM medicine WHERE price > 200;
/*
ID	NAME	PRICE	PROD_DATE	EXP_DATE
1	zinc	240,5	28.08.21	28.08.25
*/

/*
4.2 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
	перерахувати) за окремими рядками з урахуванням умови: символьне значення однієї з колонок
	має співпадати з якимось константним значенням.
*/
SELECT medicine_id,
    name,
    price,
    production_date, 
    expiration_date
    FROM medicine WHERE name = 'noshpa';
/*
ID	NAME	PRICE	PROD_DATE	EXP_DATE
2	noshpa	177,9	13.10.21	13.10.28
*/
	
/*
4.3 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
	перерахувати) за окремими рядками з урахуванням умови: символьне значення однієї з колонок
	повинно містити в першому та третьому знакомісті якісь надані вами символи.
*/
SELECT medicine_id,
    name,
    price,
    production_date, 
    expiration_date
    FROM medicine WHERE name LIKE 'z_n%';
/*
ID	NAME	PRICE	PROD_DATE	EXP_DATE
1	zinc	240,5	28.08.21	28.08.25
*/

/*
4.4 У завданні 1.2 було додано колонку типу date. Створити команду отримання значень
	всіх колонок (явно перерахувати) за окремими рядками з урахуванням умови: значення доданої
	колонки містить невизначене значення.
*/
SELECT pharmacy_id,
	name,
	location,
	medicine_id,
	med_delivery_date
	FROM pharmacy
	WHERE med_delivery_date IS NULL;
/*
ID	NAME			LOCATION				MEDICINE_ID		MED_DELIVERY_DATE
1	first_pharmacy	Odesa, main street 1	1				(null)
2	second_pharmacy	Kyiv, main street 13	2				(null)
3	third_pharmacy	Mykolaiv some street	1				(null)
*/

/*
4.5 Створити команду отримання значень всіх колонок (явно перерахувати) за окремими
	рядками з урахуванням умови, що поєднує умови з рішень завдань 4.1 та 4.2
*/
SELECT medicine_id,
    name,
    price,
    production_date, 
    expiration_date
    FROM medicine 
	WHERE price > 200
	AND name = 'zinc';
/*
ID	NAME	PRICE	PROD_DATE	EXP_DATE
1	zinc	240,5	28.08.21	28.08.25
*/
	
/*
4.6 Створити команду отримання значень всіх колонок (явно перерахувати) за окремими
	рядками з урахуванням умови, що інвертує результат рішення 4.5
*/
SELECT medicine_id,
    name,
    price,
    production_date, 
    expiration_date
    FROM medicine 
	WHERE NOT price > 200
	AND NOT name = 'zinc';
/*
ID	NAME	PRICE	PROD_DATE	EXP_DATE
2	noshpa	177,9	13.10.21	13.10.28
*/