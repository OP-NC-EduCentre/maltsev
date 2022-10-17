/*2.1 Для однієї з таблиць створити команду отримання символьних значень колонки з
переведенням першого символу у верхній регістр, інших у нижній. При виведенні на екран визначити
для вказаної колонки нову назву псевдоніму.
*/

SELECT INITCAP(name) 
	AS Lekarstvo
	FROM medicine;

/*
LEKARSTVO
-----------------------------------
Noshpa
Zinc
*/

/*2.2. Модифікувати рішення попереднього завдання, створивши команду оновлення значення
вказаної колонки у таблиці.
*/

UPDATE costumer
	SET last_name = INITCAP(last_name);

/*2.3 Для однієї з символьних колонок однієї з таблиць створити команду отримання
мінімальної, середньої та максимальної довжин рядків.
*/

SELECT MAX(LENGTH(name))
	AS Max, MIN(LENGTH(name))
	AS Min, AVG(LENGTH(name)) AS Avg
	FROM medicine;

/*
       MAX        MIN        AVG
---------- ---------- ----------
         6          4          5
*/

/*2.4 Для колонки типу date однієї з таблиць отримати кількість днів, тижнів та місяців, що
пройшли до сьогодні.
*/

SELECT 
    name,
	production_date,
    ROUND(SYSDATE-production_date) AS DAYS
	FROM medicine;


/*
NAME                                PRODUCTIO       DAYS
----------------------------------- --------- ----------
zinc                                28-AUG-21        412
noshpa                              13-OCT-21        366
*/

SELECT 
    name,
	production_date,
    ROUND((SYSDATE-production_date)/7) AS WEEKS
FROM medicine;

/*
NAME                                PRODUCTIO      WEEKS
----------------------------------- --------- ----------
zinc                                28-AUG-21         59
noshpa                              13-OCT-21         5
*/

SELECT 
    name,
	production_date,
    ROUND(MONTHS_BETWEEN (SYSDATE, production_date)) AS MONTHS
FROM medicine;

/*
NAME                                PRODUCTIO     MONTHS
----------------------------------- --------- ----------
zinc                                28-AUG-21         14
noshpa                              13-OCT-21         12
*/