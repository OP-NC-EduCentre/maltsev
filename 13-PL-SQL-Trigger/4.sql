/*1. Створити таблицю для реєстрації наступних DDL-подій: тип події, що спричинила
запуск тригера; ім'я користувача; ім'я об'єкта БД. Створити тригер реєстрації заданих подій
створення об'єктів. Подати тест-кейси перевірки роботи тригера.
*/

-- створення талиці журналу

CREATE TABLE log_ddl (
	username VARCHAR2(30),
    obj_name VARCHAR2(30),
    op_type VARCHAR2(30)
);

-- тригер на всі ddl операції для всіх таблиць в схемі

CREATE OR REPLACE TRIGGER log_ddl_handler
	AFTER CREATE OR ALTER OR DROP ON MALTSEV.SCHEMA
BEGIN
	INSERT INTO log_ddl (
		username,
		obj_name,
		op_type)
	VALUES (
		ORA_LOGIN_USER,
		ORA_DICT_OBJ_NAME,
		ORA_SYSEVENT
		);
	DBMS_OUTPUT.PUT_LINE('ddl commant was logged');
END;
/

-- тести

CREATE TABLE test1(
	id NUMBER,
	test VARCHAR2(30)
);

/*
ddl commant was logged

Table created.
*/

ALTER TABLE test1
ADD test2 VARCHAR2(30);

/*
ddl commant was logged

Table altered.
*/

DROP TABLE test1;

/*
ddl commant was logged

Table dropped.
*/

SELECT * FROM log_ddl;

/*
USERNAME                       OBJ_NAME                       OP_TYPE
------------------------------ ------------------------------ ------------------------------
MALTSEV                        TEST1                          CREATE
MALTSEV                        TEST1                          ALTER
MALTSEV                        TEST1                          DROP
*/