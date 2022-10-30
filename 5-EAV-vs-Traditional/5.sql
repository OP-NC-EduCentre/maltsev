/*5.1 Створити таблицю описів значень атрибутів екземплярів об'єктів.
*/

CREATE TABLE ATTRIBUTES (
	ATTR_ID NUMBER(10),
	OBJECT_ID NUMBER(20),
	VALUE VARCHAR2(4000),
	DATE_VALUE DATE,
	LIST_VALUE_ID NUMBER(10)
);  

ALTER TABLE ATTRIBUTES ADD CONSTRAINT ATTRIBUTES_PK
	PRIMARY KEY (ATTR_ID, OBJECT_ID);
ALTER TABLE ATTRIBUTES ADD CONSTRAINT ATTRIBUTES_LIST_VALUE_ID_FK
	FOREIGN KEY (LIST_VALUE_ID) REFERENCES LISTS (LIST_VALUE_ID);
ALTER TABLE ATTRIBUTES ADD CONSTRAINT ATTRIBUTES_ATTR_ID_FK
	FOREIGN KEY (ATTR_ID) REFERENCES ATTRTYPE (ATTR_ID);
ALTER TABLE ATTRIBUTES ADD CONSTRAINT ATTRIBUTES_OBJECT_ID_FK
	FOREIGN KEY (OBJECT_ID) REFERENCES OBJECTS (OBJECT_ID);
	
/*5.2 На основі вмісту двох рядків двох таблиць, заповнених у лабораторній роботі No3, та опису
атрибутів екземплярів об'єктів, заповнити описи значень атрибутів екземплярів об'єктів.
*/

INSERT INTO attributes(attr_id, object_id, value)
    VALUES (1, 1, 'zinc');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (2, 1, 240.5);
INSERT INTO attributes(attr_id, object_id, date_value)
    VALUES (3, 1, '28.08.2021');
INSERT INTO attributes(attr_id, object_id, date_value)
    VALUES (4, 1, '28.08.2025');

INSERT INTO attributes(attr_id, object_id, value)
    VALUES (1, 2, 'noshpa');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (2, 2, 177.9);
INSERT INTO attributes(attr_id, object_id, date_value)
    VALUES (3, 2, '13.10.2021');
INSERT INTO attributes(attr_id, object_id, date_value)
    VALUES (4, 2, '13.10.2028');

INSERT INTO attributes(attr_id, object_id, value)
    VALUES (5, 3, 'first_pharmacy');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (6, 3, 'Odesa, main street 1');
	
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (5, 4, 'second_pharmacy');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (6, 4, 'Kyiv, main street 13');
	
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (7, 5, 'Devid');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (8, 5, 'Blane');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (9, 5, '+38077321423');

INSERT INTO attributes(attr_id, object_id, value)
    VALUES (7, 6, 'Steaven');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (8, 6, 'Great');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (9, 6, '+38086564755');
	
/*5.3 Модифікувати рішення завдання 4.3, отримавши колекцію екземплярів об'єктів за заданим
значенням одного з атрибутів об'єктів.
*/

SELECT Medicine.object_id,
       Medicine.name,
       price.value price
FROM objects Medicine,
     objtype Medicine_type,
     attributes price
WHERE Medicine_type.code = 'Medicine'
  AND Medicine_type.object_type_id = Medicine.object_type_id
  AND Medicine.object_id = price.object_id
  AND price.attr_id = 2;
  
/*
 OBJECT_ID NAME		   PRICE
---------- ----------- ---------
		 1	zinc	    240,5
		 2	noshpa		177,9
*/