/*3.1 Створити нового користувача, ім'я якого = «ваше_прізвище_латиницею»+'EAV',
наприклад, blazhko_eav, з правами, достатніми для створення та заповнення таблиць БД EAV.
*/

CREATE USER maltsev_eav IDENTIFIED BY 1234;
GRANT CONNECT TO maltsev_eav;
GRANT CREATE TABLE TO maltsev_eav;
GRANT CREATE SEQUENCE TO maltsev_eav;
GRANT RESOURCE TO maltsev_eav;
ALTER USER maltsev_eav QUOTA UNLIMITED ON users;

/*3.2 Створити таблиці БД EAV та заповнити таблиці об'єктних типів та атрибутних типів,
взявши рішення з лабораторної роботи No5.
*/

CREATE TABLE objtype (
	object_type_id NUMBER(20),
	parent_id      NUMBER(20),
	code           VARCHAR2(20),
	name           VARCHAR2(200),
	description    VARCHAR2(1000)
);

ALTER TABLE objtype ADD CONSTRAINT objtype_pk
	PRIMARY KEY (object_type_id);
ALTER TABLE objtype ADD CONSTRAINT objtype_come_unique
	UNIQUE (code);
ALTER TABLE objtype 
	MODIFY (code NOT NULL);
ALTER TABLE objtype ADD CONSTRAINT objtype_fk
	FOREIGN KEY (parent_id) REFERENCES objtype(object_type_id);
	
INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (1, NULL, 'Medicine', 'Ліки', NULL);

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (2, 1, 'Pharmacy', 'Аптека', NULL);

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (3, 2, 'Employee', 'Працівник', NULL);



CREATE TABLE ATTRTYPE (
    ATTR_ID      		NUMBER(20),
    OBJECT_TYPE_ID 		NUMBER(20),
	OBJECT_TYPE_ID_REF 	NUMBER(20),
    CODE         		VARCHAR2(20),
    NAME         		VARCHAR2(200)
);

ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_PK
	PRIMARY KEY (ATTR_ID);
ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_OBJECT_TYPE_ID_FK
	FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OBJTYPE (OBJECT_TYPE_ID);
ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_OBJECT_TYPE_ID_REF_FK
	FOREIGN KEY (OBJECT_TYPE_ID_REF) REFERENCES OBJTYPE (OBJECT_TYPE_ID);
	
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (1, 1, NULL, 'NAME', 'Назва');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (2, 1, NULL, 'PRICE', 'Ціна');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (3, 1, NULL, 'PRODUCTION_DATE', 'Дата виробництва');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (4, 1, NULL, 'EXPIRATION_DATE', 'Вжити до');
	
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (5, 2, NULL, 'NAME', 'Назва');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (6, 2, NULL, 'LOCATION', 'Локація');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (7, 2, 1, 'MEDICINE_ID', 'Ліки');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (8, 2, NULL, 'MED_DELIVERY_DATE', 'Дата доставки');
	
	
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (9, 3, NULL, 'FIRST_NAME', 'Імя');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (10, 3, NULL, 'LAST_NAME', 'Прізвище');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (11, 3, NULL, 'PHONE_NUMBER', 'Телефон');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (12, 3, 2, 'PHARMACY_ID', 'Працює в аптеці');
	
	
	
CREATE TABLE OBJECTS (
	OBJECT_ID      NUMBER(20),
	PARENT_ID      NUMBER(20),
	OBJECT_TYPE_ID NUMBER(20),
	NAME           VARCHAR2(2000),
	DESCRIPTION    VARCHAR2(4000)
);

ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_PK
	PRIMARY KEY (OBJECT_ID);
ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_PARENT_ID_FK
	FOREIGN KEY (PARENT_ID) REFERENCES OBJECTS (OBJECT_ID);
ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_OBJECT_TYPE_ID_FK
	FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OBJTYPE (OBJECT_TYPE_ID);
	
INSERT INTO objects (object_id, parent_id, object_type_id, name, description)
    VALUES (1, NULL, 1, 'zinc', NULL);
INSERT INTO objects (object_id, parent_id, object_type_id, name, description)
    VALUES (2, NULL, 1, 'noshpa', NULL);

INSERT INTO objects (object_id, parent_id, object_type_id, name, description)
    VALUES (3, 1, 2, 'Apteka 1', NULL);
INSERT INTO objects (object_id, parent_id, object_type_id, name, description)
    VALUES (4, 2, 2, 'Apteka 2', NULL);
	
INSERT INTO objects (object_id, parent_id, object_type_id, name, description)
    VALUES (5, 3, 3, 'Maksym Maltsev', NULL);
INSERT INTO objects (object_id, parent_id, object_type_id, name, description)
    VALUES (6, 4, 3, 'John Smith', NULL);
	
/*3.3 Створити генератор послідовності таблиці OBJECTS БД EAV, ініціалізувавши його
початковим значенням з урахуванням вже заповнених значень.
*/

SELECT MAX(OBJECT_ID) FROM OBJECTS;

/*
MAX(OBJECT_ID)
--------------
             6
*/

CREATE SEQUENCE objects_id_seq START WITH 7;

/*3.4 Налаштувати права доступу нового користувача до таблиць схеми даних із таблицями
реляційної БД вашої предметної області, створеної в лабораторній роботі No2.
*/

GRANT SELECT ON maltsev.costumer TO maltsev_eav;
GRANT SELECT ON maltsev.employee TO maltsev_eav;
GRANT SELECT ON maltsev.medicine TO maltsev_eav;
GRANT SELECT ON maltsev.order_ TO maltsev_eav;
GRANT SELECT ON maltsev.pharmacy TO maltsev_eav;
GRANT SELECT ON maltsev.warehouse TO maltsev_eav;

/*3.5 Створити множину запитів типу INSERT INTO ... SELECT, які автоматично заповнять
таблицю OBJECTS, взявши потрібні дані з реляційної бази даних вашої предметної області.
*/

INSERT INTO objects (
	object_id,
	parent_id,
	object_type_id,
	name)
SELECT 
	objects_id_seq.nextval, 
	NULL,
	ot.object_type_id,
	m.name || ' ' || m.price
FROM objtype ot,
	maltsev.medicine m
WHERE ot.code = 'Medicine';

INSERT INTO objects (
	object_id, 
	parent_id, 
	object_type_id, 
	name)
SELECT 
    objects_id_seq.nextval, 
	obj.object_id, 
	ot.object_type_id, 
	p.name || ' ' || p.location
FROM maltsev_eav.objtype ot,
	maltsev_eav.objects obj,
    maltsev.pharmacy p,
	maltsev.medicine m
WHERE ot.code = 'Pharmacy'
	AND p.medicine_id = m.medicine_id
	AND m.name || ' ' || m.price = obj.name;
	
INSERT INTO objects (
	object_id, 
	parent_id, 
	object_type_id, 
	name)
SELECT objects_id_seq.nextval, 
	obj.object_id, 
	ot.object_type_id, 
	e.first_name || ' ' || e.last_name || ' Pharmacy # ' || e.pharmacy_id
FROM objtype ot,
	objects obj,
    maltsev.employee e,
	maltsev.pharmacy p
WHERE ot.code = 'Employee'
	AND e.pharmacy_id = p.pharmacy_id
	AND p.name || ' ' || p.location = obj.name;
	
	
SELECT * FROM objects;

/*
 OBJECT_ID  PARENT_ID OBJECT_TYPE_ID NAME
---------- ---------- -------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------
         1                         1 zinc
         2                         1 noshpa
         3          1              2 Apteka 1
         4          2              2 Apteka 2
         5          3              3 Maksym Maltsev
         6          4              3 John Smith
         7                         1 zinc 240,5
         8                         1 noshpa 186,8
         9                         1 Omega 3 276
        10          8              2 first_pharmacy Odesa, some street
        11          7              2 first_pharmacy Odesa, main street 1
        12          8              2 second_pharmacy Kyiv, main street 13
        13          7              2 third_pharmacy Mykolaiv some street
        14          9              2 Somename Odesa, main street 2
        15         11              3 Devid Blane Pharmacy 1
        16         11              3 Harry Potter Pharmacy 1
        17         12              3 Steaven Great Pharmacy 2
        18         14              3 Somename Somelastname Pharmacy 6
*/