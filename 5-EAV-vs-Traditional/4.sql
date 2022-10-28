/*4.1 Створити таблицю описів екземплярів об'єктів.
*/

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
	
/*4.2 На основі вмісту двох рядків двох таблиць, заповнених у лабораторній роботі No3,
заповнити описи екземплярів об'єктів.
*/

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

/*4.3 Отримати колекцію екземплярів об'єктів для одного з об'єктних типів, використовуючи
його код.
*/

SELECT object_id, name
FROM objects
WHERE object_type_id = 1;

/*
 OBJECT_ID NAME
---------- -----------
         1 zinc
         2 noshpa
*/
/*4.4 Отримати один екземпляр об'єкта заданого імені для одного з об'єктних типів,
використовуючи його код.
*/

SELECT Medicine.object_id, Medicine.name
FROM objects Medicine,
     objtype
WHERE Medicine.object_id = 2
  AND objtype.code = 'Medicine'
  AND objtype.object_type_id = Medicine.object_type_id;

/*
 OBJECT_ID NAME
---------- -----------
         2 noshpa
*/