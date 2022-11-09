/*
1. Виберіть таблицю вашої БД, до якої потрібно додати нову колонку, яка стане FK-
колонкою для PK-колонки цієї таблиці та буде використана для зберігання ієрархії.
Використовується команда ALTER TABLE таблиця ADD колонка тип_даних;
Заповніть дані для створеної колонки, виконавши серію команд UPDATE.
*/

-- Взяв таблицю склади (warehouse), в кожній області країни є головний, управляючий склад

ALTER TABLE warehouse
	ADD chief_warehouse NUMBER(9);

ALTER TABLE warehouse
	ADD CONSTRAINT chief_warehouse_fk
	FOREIGN KEY (chief_warehouse) REFERENCES warehouse (warehouse_id);

UPDATE warehouse
	SET chief_warehouse = 1
	WHERE warehouse_id = 3;
	
insert into warehouse 
VALUES (4, 'Sub warehouse', 'Kyiv, sub street 11', 1, 2);

/*
WAREHOUSE_ID NAME                 LOCATION             MEDICINE_ID CHIEF_WAREHOUSE
------------ -------------------- -------------------- ----------- ---------------
           1 Odesa main warehouse Odesa some street              1
           2 Kyiv main warehouse  Kyiv some street               2
           3 Somename             Odesa, main street 3           3               1
           4 Sub warehouse        Kyiv, sub street 11            1               2
*/

/*
2. Використовуючи створену колонку, отримайте дані з таблиці через ієрархічний зв'язок
типу «зверху-вниз».
*/

SELECT warehouse_id, name, location, medicine_id, chief_warehouse, level
FROM warehouse
START WITH chief_warehouse IS NULL
CONNECT BY PRIOR warehouse_id = chief_warehouse
ORDER BY level;

/*
WAREHOUSE_ID NAME                 LOCATION             MEDICINE_ID CHIEF_WAREHOUSE      LEVEL
------------ -------------------- -------------------- ----------- --------------- ----------
           2 Kyiv main warehouse  Kyiv some street               2                          1
		  10 Mykolaiv main whouse Mykolaiv street 16    	 	 1				 			1
           1 Odesa main warehouse Odesa some street              1                          1
           4 Sub warehouse        Kyiv, sub street 11            1               2          2
           3 Somename             Odesa, main street 3           3               1          2
*/

/*
3. Згенеруйте унікальну послідовність чисел, використовуючи рекурсивний запит, в
діапазоні від 1 до 100. На основі отриманого результату створіть запит, що виводить на екран
список ще не внесених значень однієї з PK-колонок однієї з таблиць БД за прикладом на рисунку
*/

FROM (WITH numbers(n) AS
               (
			   SELECT 1 AS n
               FROM dual
               UNION ALL
               SELECT n + 1
               FROM numbers
               WHERE n < 100
			   )
      SELECT n
      FROM numbers)
WHERE NOT EXISTS(SELECT medicine_id
                 FROM medicine
                 WHERE medicine_id = n);

SELECT SQ.RN
FROM 
	(
	SELECT ROWNUM AS RN
	FROM dual CONNECT BY LEVEL <=
								(SELECT MAX(warehouse_id) FROM warehouse)
	) SQ
	WHERE SQ.RN NOT IN (SELECT warehouse_id FROM warehouse)
	ORDER BY RN;
	
/*
        RN
----------
         5
         6
         7
         8
         9
        11
        12
        13
        14
*/