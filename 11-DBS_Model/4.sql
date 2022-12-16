/*4.1. Виконайте введення 5 рядків у таблицю бази даних із динамічною генерацією 
команди. Значення первинного ключа генеруються автоматично, решта даних дублюється.
*/

DECLARE
    v_id medicine.medicine_id%TYPE;
	v_name medicine.name%TYPE;
	v_price medicine.price%TYPE;
	v_prod_date medicine.production_date%TYPE;
	v_exp_date medicine.expiration_date%TYPE;
	insert_query VARCHAR2(300);
BEGIN
    insert_query := 'INSERT INTO medicine(
	    medicine_id,
		name,
		price,
		production_date,
		expiration_date)
	VALUES (
		:1,
		:2,
		:3,
		:4,
		:5
		)';
	FOR i IN 1..5 LOOP
		v_id := med_id_seq.NEXTVAL;
		v_name := 'painkiller';
		v_price := 770;
		v_prod_date := TO_DATE('03.12.2022', 'DD/MM/YYYY');
		v_exp_date := TO_DATE('03.12.2026', 'DD/MM/YYYY');
		EXECUTE IMMEDIATE insert_query
			USING v_id, v_name, v_price, v_prod_date, v_exp_date;
	END LOOP;
EXCEPTION
	WHEN DUP_VAL_ON_INDEX
	THEN DBMS_OUTPUT.PUT_LINE('Cannot insert duplicate data in DB');
END;
/

-- PL/SQL procedure successfully completed.

/*4.2. Скласти динамічний запит створення таблиці, іменами колонок якої будуть значення 
будь-якої символьної колонки. Попередньо виконати перевірку існування таблиці з її 
видаленням.
*/

DROP TABLE drug_name;

DECLARE
    create_query VARCHAR2(300);
BEGIN
    create_query := 'CREATE TABLE drug_name (';
    FOR f_name IN (SELECT DISTINCT name FROM medicine) LOOP
        create_query := create_query 
		|| f_name.name
        || ' VARCHAR2(20),';
    END LOOP;
    create_query := RTRIM(create_query, ', ') || ')';
    DBMS_OUTPUT.PUT_LINE(create_query);
    EXECUTE IMMEDIATE create_query;
END;
/

/*
CREATE TABLE drug_name (zinc VARCHAR2(20),Omega3 VARCHAR2(20),noshpa VARCHAR2(20),painkiller VARCHAR2(20))

PL/SQL procedure successfully completed.
*/

/*4.3. Команда ALTER SEQUENCE може змінювати початкове значення генератора 
починаючи з СУБД версії 12. Для ранніх версій доводиться виконувати дві команди: видалення 
генератора та створення генератора з новим початковим значенням.
З урахуванням вашої предметної області створити анонімний PL/SQL-блок, який 
викликатиме один із варіантів SQL-запитів зміни початкового значення генератора залежно від 
значення версії СУБД.
*/

DECLARE
    start_val NUMBER(4) := 4;
    alter_seq_query VARCHAR2(300);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Oracle version = ' || DBMS_DB_VERSION.version);

    IF DBMS_DB_VERSION.version >= 12 THEN
        alter_seq_query := 'ALTER SEQUENCE order_id_seq RESTART START WITH ' || start_val;
        EXECUTE IMMEDIATE alter_seq_query;
    ELSE
        alter_seq_query := 'DROP SEQUENCE order_id_seq';
        EXECUTE IMMEDIATE alter_seq_query;
        alter_seq_query := 'CREATE SEQUENCE order_id_seq START WITH ' || start_val;
        EXECUTE IMMEDIATE alter_seq_query;
    END IF;
  
    DBMS_OUTPUT.PUT_LINE(alter_seq_query);
END;
/

/*
Oracle version = 18
ALTER SEQUENCE order_id_seq RESTART START WITH 4

PL/SQL procedure successfully completed.
*/