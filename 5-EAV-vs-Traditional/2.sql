/*2.1. Створити таблицю описів атрибутних типів.
*/

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
	
/*2.2 Для раніше використаних класів UML-діаграми заповнити описи атрибутних типів.
*/

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
	
/*2.3 Отримати інформацію про атрибутні типи.
*/

SELECT O.CODE,A.ATTR_ID,A.CODE,A.NAME
	FROM OBJTYPE O, ATTRTYPE A
	WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
	ORDER BY A.OBJECT_TYPE_ID,A.ATTR_ID;

/*
CODE                    ATTR_ID CODE                 NAME
-------------------- ---------- -------------------- -------------------
Medicine                      1 NAME                 Назва
Medicine                      2 PRICE                Ціна
Medicine                      3 PRODUCTION_DATE      Дата виробництва
Medicine                      4 EXPIRATION_DATE      Вжити до
Pharmacy                      5 NAME                 Назва
Pharmacy                      6 LOCATION             Локація
Pharmacy                      7 MEDICINE_ID          Ліки
Pharmacy                      8 MED_DELIVERY_DATE    Дата доставки
Employee                      9 FIRST_NAME           Імя
Employee                     10 LAST_NAME            Прізвище
Employee                     11 PHONE_NUMBER         Телефон
Employee                     12 PHARMACY_ID          Працює в аптеці
*/

/*2.4 Отримати інформацію про атрибутні типи та можливі зв'язки між ними типу «іменована
асоціація».
*/

SELECT O.CODE,A.ATTR_ID,A.CODE,A.NAME, O_REF.CODE O_REF
	FROM OBJTYPE O, ATTRTYPE A LEFT JOIN OBJTYPE O_REF 
	ON (A.OBJECT_TYPE_ID_REF = O_REF.OBJECT_TYPE_ID)
	WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
	ORDER BY A.OBJECT_TYPE_ID,A.ATTR_ID;
	
/*
CODE                    ATTR_ID CODE                 NAME				 O_REF
-------------------- ---------- -------------------- ------------------- ----------------
Medicine                      1 NAME                 Назва				 null
Medicine                      2 PRICE                Ціна				 null
Medicine                      3 PRODUCTION_DATE      Дата виробництва	 null
Medicine                      4 EXPIRATION_DATE      Вжити до			 null
Pharmacy                      5 NAME                 Назва				 null
Pharmacy                      6 LOCATION             Локація			 null
Pharmacy                      7 MEDICINE_ID          Ліки				 Medicine
Pharmacy                      8 MED_DELIVERY_DATE    Дата доставки		 null
Employee                      9 FIRST_NAME           Імя				 null
Employee                     10 LAST_NAME            Прізвище			 null
Employee                     11 PHONE_NUMBER         Телефон			 null
Employee                     12 PHARMACY_ID          Працює в аптеці	 Pharmacy
*/