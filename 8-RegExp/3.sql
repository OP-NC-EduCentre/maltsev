/*1. Одна з колонок таблиць повинна містити строкове значення з двома словами,
розділеними пробілом. Виконайте команду UPDATE, помінявши місцями ці два слова.
*/

UPDATE pharmacy 
	SET location = regexp_replace(
        location,
		'(.*)\s(.*)\s(.*)\s(.*)',
		'\1 \3 \2 \4');

/*2. Одна з колонок таблиць має містити строкове значення з електронною поштовою
адресою у форматі EEE@EEE.EEE.UA, де E – будь-яка латинська буква. Створіть запит,
вилучення логіна користувача з електронної адреси (підстрока перед символом @).
*/

SELECT REGEXP_REPLACE(last_name, '\@.*$')
FROM costumer;

/*3. Одна з колонок таблиць повинна містити строкове значення з номером мобільного
телефону у форматі +XX(XXX)XXX-XX-XX, де X – цифра. Виконайте команду UPDATE,
додавши перед номером телефону фразу «Mobile:».
*/

UPDATE employee 
	SET phone_number = regexp_replace(
        phone_number,
		'(.+)',
		'Mobile: \1');
   
select employee_id, first_name, phone_number from employee;

/*
EMPLOYEE_ID FIRST_NAME           PHONE_NUMBER
----------- -------------------- --------------------------------------------------
          1 Devid                Mobile: +38077321423
          2 Steaven              Mobile: +38086564755
         24 Harry                Mobile: +3809912345678
          3 Somename             Mobile: +380995679553

*/

/*4. Додайте до колонки з електронною адресою обмеження цілісності, що забороняє
вносити дані, відмінні від формату електронної адреси, використовуючи команду ALTER TABLE
таблиця ADD CONSTRAINT обмеження CHECK (умова). Перевірте роботу обмеження на двох
прикладах UPDATE-запитів із правильними та неправильними значеннями колонки.
*/

ALTER TABLE costumer 
ADD CONSTRAINT proper_email CHECK (regexp_like(
		    email,
			'^([a-z][a-z0-9._-]*@[a-z][a-z0-9._-]*\.[a-z]{2,4})$'));

-- Спроба додати не валідну адресу пошти
insert into costumer VALUES (25, 'Name', 'Surname', '+3703456345', 'eqweqwee');
/*
ERROR at line 1:
ORA-02290: check constraint (MALTSEV.PROPER_EMAIL) violated
*/

select * from costumer where email is not null;
/*
COSTUMER_ID FIRST_NAME           LAST_NAME                      PHONE_NUMBER         EMAIL
----------- -------------------- ------------------------------ -------------------- --------------------------------------------------
         25 Name                 Surname                        +3703456345          qweasd@gmail.com
*/

/*5. Видаліть зайві дані з колонки з номером мобільного телефону, залишивши тільки номер
телефону в заданому форматі.
*/

UPDATE employee 
	SET phone_number = regexp_replace(
        phone_number,
		'(.+)\s(.+)',
		'\2');

SELECT employee_id, 
	first_name, 
	phone_number
	FROM employee;

/*
EMPLOYEE_ID FIRST_NAME           PHONE_NUMBER
----------- -------------------- --------------------------------------------------
          1 Devid                +38(077)321-42-32
          2 Steaven              +38(086)564-75-55
         24 Harry                +38(099)123-45-67
          3 Somename             +38(099)567-95-53
*/

/*6. Додайте в колонку з мобільним телефоном обмеження цілісності, що забороняє вносити
дані, відмінні від формату, записаного в завданні 3. Перевірте роботу обмеження на двох
прикладах UPDATE-запитів із правильними та неправильними значеннями колонки.
*/

ALTER TABLE employee 
ADD CONSTRAINT proper_phone CHECK (
			regexp_like(
		    phone_number,
			'^([+]\d{2}[(]\d{3}[)]\d{3}[-]\d{2}[-]\d{2})$'));
		

--Спроба додати не валідний номер телефону
INSERT INTO employee VALUES (26, 'name', 'nername', '+3412414124', null);
		
/*
ERROR at line 1:
ORA-02290: check constraint (MALTSEV.PROPER_PHONE) violated
*/

--Додаемо валідний номер телефону
INSERT INTO employee VALUES (26, 'name', 'nename', '+38(093)123-23-13', null);

/*
        ID NAME                 PHONE
---------- -------------------- --------------------------------------------------
         1 Devid                +38(077)321-42-32
         2 Steaven              +38(086)564-75-55
        24 Harry                +38(099)123-45-67
         3 Somename             +38(099)567-95-53
        26 name                 +38(093)123-23-13
*/