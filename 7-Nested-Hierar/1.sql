/* 1. Виконання простих однорядкових підзапитів із екві-з'єднанням або тета-з'єднанням.
Завдання: вивести всі ліки, в яких ціна менша за вказаний препарат.
*/
SELECT name,
	price
FROM medicine
WHERE price <  
			(
			SELECT price
			FROM medicine
			WHERE name = 'Omega 3'
			);
			
/*
NAME                                     PRICE
----------------------------------- ----------
zinc                                     240.5
noshpa                                   186.8
*/

/* 2. Використання агрегатних функцій у підзапитах.
Завдання: отримати список ліків, з мінімальною ціною
*/

SELECT name,
	price,
	expiration_date
FROM medicine
WHERE price = 
				(SELECT MIN(price) 
					FROM medicine);
					
/*
NAME                                     PRICE EXPIRATIO
----------------------------------- ---------- ---------
noshpa                                   186.8 13-OCT-28
*/

/* 3. Пропозиція HAVING із підзапитами.
Завдання: отримати список ліків, у яких ціна більша за середню ціну ліків
*/

SELECT name, 
	AVG(price)
FROM medicine
GROUP BY name
HAVING AVG(price) >
					(
					SELECT AVG(price) 
					FROM medicine
					);
					
/*
NAME                                AVG(PRICE)
----------------------------------- ----------
zinc                                     240.5
Omega 3                                    276
*/

/* 4. Виконання багаторядкових підзапитів
Завдання: отримати список ліків, назва яких не цинк, та в яких термін придатності
більший за будь який термін придатності ліків, ціною більше 150
*/

SELECT name, 
	price,
	expiration_date
FROM medicine
WHERE expiration_date > ANY
				(
				SELECT expiration_date
				FROM medicine
				WHERE price > 150
				)
			AND name <> 'zinc';
			
/*
NAME                                     PRICE EXPIRATIO
----------------------------------- ---------- ---------
noshpa                                   186.8 13-OCT-28
*/

/* 5. Використання оператора WITH для структуризації запиту
Завдання: вивести всіх клієнтів, які робили замовлення більше 1-го разу
*/

WITH order_count AS
	(
		SELECT buyer, count(*) AS order_count
		FROM order_
		GROUP BY buyer
	)
SELECT c.costumer_id, c.first_name, a.order_count
FROM order_count a, costumer c
	WHERE a.buyer = c.costumer_id
			AND a.order_count > 1;

/*
COSTUMER_ID FIRST_NAME           ORDER_COUNT
----------- -------------------- -----------
          2 John                           2
*/

/* 6. Використання кореляційних підзапитів
Завдання: отримати список аптек, в яких працюють фармацевти
*/

SELECT p.name
	FROM pharmacy p
	WHERE EXISTS (
			SELECT e.pharmacy_id
			FROM employee e
			WHERE e.pharmacy_id = p.pharmacy_id
			);
			
/*
NAME
--------------------
first_pharmacy
second_pharmacy
Somename

*/