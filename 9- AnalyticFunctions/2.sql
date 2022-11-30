/*1. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення.
Створіть запит, який отримає накопичувальні підсумки другої колонки від початку
вікна до поточного рядка.
*/

SELECT 
    first_name AS name, 
	last_name, 
	pharmacy_id,
	SUM(salary) OVER (
		ORDER BY first_name
		ROWS BETWEEN UNBOUNDED PRECEDING 
		AND CURRENT ROW
		) AS sum_sal 
FROM employee;

/*
NAME                 LAST_NAME                      PHARMACY_ID    SUM_SAL
-------------------- ------------------------------ ----------- ----------
Adam                 Sendler                                  1        600
Devid                Blane                                    1       1200
Harry                Potter                                   1       1950
John                 Blake                                    2       2350
Somename             Somelastname                             6       3350
Steaven              Great                                    2       3900
*/

/*2. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення.
Створіть запит, який отримає накопичувальні підсумки другої колонки
попереднього та поточного рядка (ковзаюче вікно розміром 2 рядки).
*/

SELECT 
    first_name AS name, 
	last_name, 
	pharmacy_id,
	SUM(salary) OVER (
		ORDER BY first_name
		ROWS BETWEEN 1 PRECEDING 
		AND CURRENT ROW
		) AS sum_sal 
FROM employee;

/*
NAME                 LAST_NAME                      PHARMACY_ID    SUM_SAL
-------------------- ------------------------------ ----------- ----------
Adam                 Sendler                                  1        600
Devid                Blane                                    1       1200
Harry                Potter                                   1       1350
John                 Blake                                    2       1150
Somename             Somelastname                             6       1400
Steaven              Great                                    2       1550
*/

/*3. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення.
Створіть запит, який отримає:
 - накопичувальні підсумки другої колонки від початку вікна до поточного
рядка для кожного вікна цілком
 - накопичувальний результат порядково (для демонстрації відмінностей
роботи типу RANG від ROWS).
*/

SELECT 
    first_name AS name, 
	last_name, 
	pharmacy_id,
	SUM(salary) OVER (
		ORDER BY first_name
		ROWS BETWEEN UNBOUNDED PRECEDING 
		AND CURRENT ROW
		) AS sum_sal,
	SUM(salary) OVER (
		ORDER BY first_name
		RANGE BETWEEN UNBOUNDED PRECEDING 
		AND CURRENT ROW
		) AS sum_sal2
FROM employee;

/*
NAME                 LAST_NAME                      PHARMACY_ID    SUM_SAL   SUM_SAL2
-------------------- ------------------------------ ----------- ---------- ----------
Adam                 Sendler                                  1        600        600
Devid                Blane                                    1       1200       1200
Harry                Potter                                   1       1950       1950
John                 Blake                                    2       2350       2350
Somename             Somelastname                             6       3350       3350
Steaven              Great                                    2       3900       3900
*/