/*1. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення. Створіть запит, який
отримає усереднені значення другої колонки кожного рядка в кожній підгрупі.
Використати аналітичну функцію на основі AVG, PARTITION BY.
*/

SELECT 
    first_name AS name, 
	last_name, 
	pharmacy_id,
	AVG(salary) OVER (PARTITION BY pharmacy_id) AS avg_sal 
FROM employee;

/*
NAME                 LAST_NAME                      PHARMACY_ID    AVG_SAL
-------------------- ------------------------------ ----------- ----------
Devid                Blane                                    1        650
Harry                Potter                                   1        650
Adam                 Sendler                                  1        650
John                 Blake                                    2        475
Steaven              Great                                    2        475
Somename             Somelastname                             6       1000
*/
	
/*2. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення. Створіть запит, який
отримає накопичувальні підсумки другої колонки.
*/

SELECT 
    first_name AS name, 
	last_name, 
	pharmacy_id,
	SUM(salary) OVER (ORDER BY first_name) AS sum_sal 
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

/*3. Виконайте попереднє завдання, отримавши накопичувальні підсумки в кожній
підгрупі окремо.
*/

SELECT 
    first_name AS name, 
	last_name, 
	pharmacy_id,
	SUM(salary) OVER (
		PARTITION BY pharmacy_id 
		ORDER BY first_name) AS sum_sal 
FROM employee;

/*
NAME                 LAST_NAME                      PHARMACY_ID    SUM_SAL
-------------------- ------------------------------ ----------- ----------
Adam                 Sendler                                  1        600
Devid                Blane                                    1       1200
Harry                Potter                                   1       1950
John                 Blake                                    2        400
Steaven              Great                                    2        950
Somename             Somelastname                             6       1000
*/