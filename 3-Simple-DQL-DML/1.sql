/*
	1.1 Для кожної таблиці БД створити команди внесення даних, тобто внести по два рядки.
*/

INSERT INTO costumer (costumer_id, 
   first_name, 
   last_name, 
   phone_number)
    VALUES (1, 
	'Maksym', 
	'Maltsev', 
	'+38091111111');
INSERT INTO costumer (costumer_id, 
    first_name, 
	last_name, 
	phone_number)
    VALUES (2, 
	'John', 
	'Smith', 
	'+380999999999');
	
INSERT INTO medicine (medicine_id, 
    name, 
	price, 
	production_date, 
	expiration_date)
    VALUES (1, 
	'zinc', 
	240.5, 
	'28.08.2021', 
	'28.08.2025');
INSERT INTO medicine (medicine_id, 
    name, 
	price, 
	production_date, 
	expiration_date)
    VALUES (2, 
	'noshpa', 
	177.9, 
	'13.10.2021', 
	'13.10.2028');

INSERT INTO pharmacy (pharmacy_id,
    name,
	location,
	medicine_id)
	VALUES (1,
	'first_pharmacy',
	'Odesa, main street 1',
	1);
INSERT INTO pharmacy (pharmacy_id,
    name,
	location,
	medicine_id)
	VALUES (2,
	'second_pharmacy',
	'Kyiv, main street 13',
	2);
	
INSERT INTO warehouse (warehouse_id,
    name,
	location,
	medicine_id)
	VALUES (1,
	'main warehouse',
	'Odesa some street',
	1);
INSERT INTO warehouse (warehouse_id,
    name,
	location,
	medicine_id)
	VALUES (2,
	'Kyiv main warehouse',
	'Kyiv some street',
	2);
	
INSERT INTO employee (employee_id, 
    first_name, 
	last_name, 
	phone_number, 
	pharmacy_id)
    VALUES (1, 
	'Devid', 
	'Blane', 
	'+38077321423', 
	1);
INSERT INTO employee (employee_id, 
    first_name, 
	last_name, 
	phone_number, 
	pharmacy_id)
    VALUES (2, 
	'Steaven', 
	'Great', 
	'+38086564755', 
	2);
	
INSERT INTO order_ (order_id, 
    medicine_id,
	order_date,
	total,
	seller,
	buyer)
	VALUES (1,
	1,
	'20.12.2021',
	240.5,
	1,
	1);
INSERT INTO order_ (order_id, 
    medicine_id,
	order_date,
	total,
	seller,
	buyer)
	VALUES (2,
	2,
	'13.02.2022',
	177.9,
	2,
	2);

/*
1.2 Для однієї з таблиць створити команду додавання колонки типу date з урахуванням
    предметної області.
*/
ALTER TABLE pharmacy ADD med_delivery_date date;

/*
1.3 Для зазначеної таблиці створити команду на внесення одного рядка, але з невизначеним
	значенням колонки типу date.
*/
INSERT INTO pharmacy (pharmacy_id,
    name,
	location,
	medicine_id
	)
	VALUES (3,
	'third_pharmacy',
	'Mykolaiv 1 street',
	1);
	
/*
1.4 Створити команду налаштування формату date = dd/mm/yyyy.
*/
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy'

/*
1.5 Для задіяної в завданні 1.2 таблиці створити ще одну команду на внесення одного рядка
	з урахуванням значення колонки типу date.
*/
INSERT INTO pharmacy (pharmacy_id,
    name,
	location,
	medicine_id,
    med_delivery_date
	)
	VALUES (4,
	'first_pharmacy',
	'Odesa, some street',
	2,
    '05.01.2021');

/*
1.6 Для однієї з таблиць, що містить обмеження цілісності потенційного ключа, виконати
	команду додавання нового рядка зі значенням колонки, що порушує це обмеження. Перевірити
	реакцію СКБД на таку зміну.
*/
INSERT INTO employee (employee_id,
    first_name,
    last_name,
    phone_number,
    pharmacy_id)
    VALUES (3,
    'Will',
    'Smith',
    '+38077321423',
    3);
/*
Error report -
ORA-00001: нарушено ограничение уникальности (MALTSEV.EMP_PHONE_UNIQUE)
*/
	
/*
1.7 Для однієї з таблиць, що містить обмеження цілісності зовнішнього ключа, виконати
	команду додавання нового рядка зі значенням колонки зовнішнього ключа, який відсутній у
	колонці первинного ключа відповідної таблиці. Перевірити реакцію СКБД на подібне додавання,
	яке порушує обмеження цілісності зовнішнього ключа.
*/
INSERT INTO employee (employee_id,
    first_name,
    last_name,
    phone_number,
    pharmacy_id)
    VALUES (3,
    'Will',
    'Smith',
    '+380931212122',
    6);
/*
Error report -
ORA-02291: нарушено ограничение целостности (MALTSEV.EMP_PHARMACY_FK) - исходный ключ не найден
*/