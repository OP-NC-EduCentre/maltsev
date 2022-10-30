/*1.1. Створити таблицю опису об'єктних типів.
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

/*1.2 Нехай у лабораторній роботі No1 було створено UML-діаграму концептуальних класів. Для
трьох класів з UML-діаграми, пов'язаних між собою, бажано зв'язком «узагальнення», «агрегатна
асоціація» та «іменована асоціація», заповнити опис об'єктних типів.
*/

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (1, NULL, 'Medicine', 'Ліки', NULL);

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (2, 1, 'Pharmacy', 'Аптека', NULL);

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (3, 2, 'Employee', 'Працівник', NULL);


/*1.3 Отримати інформацію про об'єктні типи.
*/

SELECT object_type_id,
       parent_id,
       code,
       name
FROM objtype;

/*
OBJECT_TYPE_ID  PARENT_ID CODE                 NAME
-------------- ---------- -------------------- ----------
             1            Medicine             Ліки
             2          1 Pharmacy             Аптека
             3          2 Employee             Працівник
*/

/*1.4 Отримати інформацію про об'єктні типи та можливі зв'язки між ними типу «узагальнення»,
«агрегатна асоціація».
*/

SELECT p.object_type_id,
       p.code,
       c.object_type_id obj_t_id_link,
       c.code           code_link
FROM objtype c,
     objtype p
WHERE p.object_type_id = c.parent_id(+);

/*
OBJECT_TYPE_ID CODE                 OBJ_T_ID_LINK CODE_LINK
-------------- -------------------- ------------- --------------------
             1 Medicine                         2 Pharmacy
             2 Pharmacy                         3 Employee
             3 Employee
*/