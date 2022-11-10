/*1. Створіть запит, який отримає рядки таблиці з урахуванням присутності в раніше
вказаній колонці поєднання будь-яких двох підряд розташованих цифр, або трьох підряд
розташованих букв.
*/

SELECT pharmacy_id AS id, 
	name,
	location
	FROM pharmacy
	WHERE regexp_like(location, '(([[:digit:]]){2})|(([[:alpha:]]){3})');

/*
        ID NAME                 LOCATION
---------- -------------------- --------------------
         1 first_pharmacy       Odesa, main street 1
         2 second_pharmacy      Kyiv, main street 13
         3 third_pharmacy       Mykolaiv some street
         6 Somename             Odesa, main street 2
*/
/*2. Одна з колонок таблиць повинна містити строкове значення з двома однаковими
буквами, що повторюються підряд. Створіть запит, який отримає рядки таблиці з таким значенням
колонки.
*/

SELECT first_name
	FROM employee
	WHERE regexp_like(first_name, '([[:alpha:]])\1');

/*
FIRST_NAME
--------------------
Harry
*/

/*
3. Одна з колонок таблиць повинна містити строкове значення з двома однаковими
словами, що повторюються підряд. Створіть запит, який отримає рядки таблиці з таким значенням
колонки.
*/

SELECT * FROM employee
WHERE 
     regexp_like(
	     first_name,
         '([[:alpha:]]+)([[:space:]]+)\1');

/*
EMPLOYEE_ID FIRST_NAME           LAST_NAME                      PHONE_NUMBER         PHARMACY_ID
----------- -------------------- ------------------------------ -------------------- -----------
         25 some some            lastname                       +3231233123

*/

/*4. Одна з колонок таблиць повинна містити строкове значення з номером мобільного
телефону у форматі +XX(XXX)XXX-XX-XX, де X – цифра. Створіть запит, який отримає рядки
таблиці з таким значенням колонки.
*/

SELECT first_name, phone_number 
FROM employee
WHERE regexp_like(phone_number, '^([+]\d{2}[(]\d{3}[)]\d{3}[-]\d{2}[-]\d{2})$');

/*
FIRST_NAME           PHONE_NUMBER
-------------------- --------------------------------------------------
Devid                +38(077)321-42-32
Steaven              +38(086)564-75-55
Harry                +38(099)123-45-67
Somename             +38(099)567-95-53
*/

/*5. Одна з колонок таблиць має містити строкове значення з електронною поштовою
адресою у форматі EEE@EEE.EEE.UA, де E – будь-яка латинська буква. Створіть запит, який
отримає рядки таблиці з таким значенням колонки.
*/

SELECT costumer_id AS id, 
	first_name AS name, 
	email
	FROM costumer
	WHERE regexp_like(email,  '^[a-zA-Z0-9._%-]+@[a-zA-Z0-9._%-]+\.[a-zA-Z]{2,4}$');
	
/*
        ID NAME                 EMAIL
---------- -------------------- --------------------------------------------------
         3 John                 ghjjjtttg@gmail.com.ua
        25 Name                 zxcasd@gmail.com.ua
        24 Steven               qweasd@gmail.com.ua
*/