/*1. Класифікуйте значення однієї з колонок на 3 категорії залежно від загальної суми
значень у будь-якій числовій колонці. Використати аналітичну функцію NTILE.
*/

SELECT 
	NTILE(3) OVER (ORDER BY salary) salary_ntile,
	first_name AS name,
	salary,
	pharmacy_id AS p_id
FROM employee;

/*
SALARY_NTILE NAME                     SALARY       P_ID
------------ -------------------- ---------- ----------
           1 John                        400          2
           1 Steaven                     550          2
           2 Devid                       600          1
           2 Adam                        600          1
           3 Harry                       750          1
           3 Somename                   1000          6
*/

/*2. Складіть запит, який поверне списки лідерів (список за убуванням відповідного
значення) у підгрупах, отриманих у першому завданні етапу 1.
*/

WITH sal_categories AS (SELECT 
                   NTILE(3) OVER (ORDER BY salary) salary_ntile,
				   first_name AS name,
                   salary,
				   pharmacy_id AS p_id
            FROM employee),
     first_positions AS (SELECT 
				   RANK() OVER (PARTITION BY salary_ntile ORDER BY salary) pos,
				   name,
                   salary,
				   p_id,
				   salary_ntile
            FROM sal_categories)
SELECT 
	   pos,
	   name,
       salary,
       salary_ntile,
	   p_id
FROM first_positions
WHERE pos = 1;

/*
       POS NAME                     SALARY SALARY_NTILE       P_ID
---------- -------------------- ---------- ------------ ----------
         1 John                        400            1          2
         1 Devid                       600            2          1
         1 Adam                        600            2          1
         1 Harry                       750            3          1
*/

/*3. Модифікуйте рішення попереднього завдання, повернувши по 2 лідери у кожній
підгрупі.
*/

WITH sal_categories AS (SELECT 
                   NTILE(3) OVER (ORDER BY salary) salary_ntile,
				   first_name AS name,
                   salary,
				   pharmacy_id AS p_id
            FROM employee),
     two_leaders AS (SELECT 
				   ROW_NUMBER() OVER (PARTITION BY salary_ntile ORDER BY salary) pos,
				   name,
                   salary,
				   p_id,
				   salary_ntile
            FROM sal_categories)
SELECT 
	   pos,
	   name,
       salary,
       salary_ntile,
	   p_id
FROM two_leaders
WHERE pos <=2;

/*
       POS NAME                     SALARY SALARY_NTILE       P_ID
---------- -------------------- ---------- ------------ ----------
         1 John                        400            1          2
         2 Steaven                     550            1          2
         1 Devid                       600            2          1
         2 Adam                        600            2          1
         1 Harry                       750            3          1
         2 Somename                   1000            3          6
*/

/*4. Складіть запит, який повертає рейтинг будь-якого з перерахованих значень
відповідно до вашої предметноїобласті: товарів/послуг/співробітників/клієнтів тощо.
*/

SELECT 
	   medicine_id AS id,
	   name,
       price,
       RANK() OVER (ORDER BY price ASC) AS from_low_price
FROM medicine;

/*
        ID NAME                                     PRICE FROM_LOW_PRICE
---------- ----------------------------------- ---------- --------------
         2 noshpa                                   186.8              1
         1 zinc                                     240.5              2
         3 Omega 3                                    276              3
*/

/*5. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення. Створіть запит, який
отримає перше значення у кожній підгрупі. Використати аналітичну функцію
FIRST_VALUE.
*/

WITH top_salary AS (
				   SELECT first_name AS name,
                   salary,
				   pharmacy_id AS p_id,
                   FIRST_VALUE(salary) OVER
                       (
					   PARTITION BY pharmacy_id
                       ORDER BY salary DESC
					   ) top_sal_in_pharmacy
            FROM employee
			)
SELECT name,
       salary,
       p_id
FROM top_salary
WHERE salary = top_sal_in_pharmacy;

/*
NAME                     SALARY       P_ID
-------------------- ---------- ----------
Harry                       750          1
Steaven                     550          2
Somename                   1000          6
*/