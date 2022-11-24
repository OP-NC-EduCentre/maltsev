/*1. Одна з колонок таблиць повинна містити строкове значення з трьома різними буквами у
першій позиції. Створіть запит, який отримає три рядки таблиці з урахуванням трьох букв,
використовуючи оператор LIKE.
*/

SELECT pharmacy_id, location
	FROM pharmacy 
	WHERE 
		location LIKE 'Ode%'
			OR location LIKE 'Kyi%'
			OR location LIKE 'Myk%';
		
/*
PHARMACY_ID LOCATION
----------- --------------------
          1 Odesa, main street 1
          2 Kyiv, main street 13
          3 Mykolaiv some street
          6 Odesa, main street 2
*/
	
/*2. Повторіть завдання 1, використовуючи регулярні вирази з альтернативними варіантами.
*/

SELECT pharmacy_id, location
	FROM pharmacy 
	WHERE 
     regexp_like(location, '^Ode|^Kyi|^Myk');
	 
/*
PHARMACY_ID LOCATION
----------- --------------------
          1 Odesa, main street 1
          2 Kyiv, main street 13
          3 Mykolaiv some street
          6 Odesa, main street 2
*/

/*3. Одна з колонок таблиць повинна містити строкове значення з цифрами від 3 до 8 у
будь-якій позиції. Створіть запит, який отримає рядки таблиці з урахуванням присутності у
вказаній колонці будь-якої цифри від 3 до 8.
*/

SELECT first_name, 
	last_name, 
	pharmacy_id AS p_id
	FROM employee
	WHERE regexp_like(pharmacy_id, '.*[3-8].*');

/*
FIRST_NAME           LAST_NAME                            P_ID
-------------------- ------------------------------ ----------
Somename             Somelastname                            6
*/

/*4. Створіть запит, який отримає рядки таблиці з урахуванням відсутності в зазначеній
колонці будь-якої цифри від 3 до 8.
*/

SELECT first_name, 
	last_name, 
	pharmacy_id AS p_id
	FROM employee
	WHERE regexp_like(pharmacy_id, '[^3-8]');
	
/*
FIRST_NAME           LAST_NAME                            P_ID
-------------------- ------------------------------ ----------
Devid                Blane                                   1
Steaven              Great                                   2
Harry                Potter                                  1
*/

/*5. Створіть запит, який отримає рядки таблиці з урахуванням присутності в раніше вказаній
колонці поєднання будь-яких трьох цифр розміщених підряд від 3 до 8.
*/

SELECT first_name, 
	last_name, 
	phone_number AS phone
	FROM employee
	WHERE regexp_like(phone_number, '(345|456|567|678)');
	
/*
FIRST_NAME           LAST_NAME                      PHONE
-------------------- ------------------------------ --------------------
Harry                Potter                         +3809912345678
Somename             Somelastname                   +380995679553
*/
