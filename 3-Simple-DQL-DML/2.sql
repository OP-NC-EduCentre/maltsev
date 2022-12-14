--Конструювання простих SELECT-команд

/*
2.1 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
	перерахувати) у всіх рядках.
*/
SELECT medicine_id,
    name,
    price,
    production_date, 
    expiration_date
    FROM medicine;
/*
1	zinc	240,5	28/08/2021	28/08/2025
2	noshpa	177,9	13/10/2021	13/10/2028
*/

/*
2.2 Для однієї з таблиць створити команду отримання цілого числа колонки з
	використанням будь-якої арифметичної операції. При виведенні на екран визначити для
	зазначеної колонки нову назву псевдоніма.
*/
SELECT  
	price-(price*10/100) discount_price
    FROM medicine;
/*
	DISCOUNT_PRICE
1	216,45
2	160,11
*/

/*
2.3 Для однієї з таблиць, що містить колонку зовнішнього ключа створити команду
	отримання значення колонки без дублювання значень.
*/	
SELECT DISTINCT medicine_id FROM pharmacy;
/*
	MEDICINE_ID
1	1
2	2
*/

/*
2.4 Для однієї з таблиць створити команду отримання результату конкатенації значень будь-
	яких двох колонок. При виведенні на початок рядка виведення додати літерал «UNION=».
*/
SELECT 
    'UNION = ' || first_name || ' ' || last_name
	AS "Full_name"
    FROM costumer;
/*
	Full_name
1	UNION = Maksym Maltsev
2	UNION = John Smith
*/

/*
2.5 Модернізувати рішення завдання 2.2, отримавши в порядку зростання значення
	псевдоніму.
*/
SELECT 
	price-(price*10/100) discount_price
    FROM medicine
    ORDER BY discount_price ASC;
/*
	DISCOUNT_PRICE
1	160,11
2	216,45
*/
	
/*
2.6 Для однієї з таблиць створити команду отримання значення двох колонок, значення
	яких відсортовані в порядку зростання (для першої колонки) та в порядку зменшення (друга
	колонка).
*/
SELECT price,
    name
	FROM medicine
	ORDER BY price ASC, name DESC;
/*
	PRICE	NAME
1	177,9	noshpa
2	240,5	zinc
*/