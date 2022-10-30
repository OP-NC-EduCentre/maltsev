/*6.1 Створити таблицю описів зв'язків "іменована асоціація" між екземплярами об'єктів.
*/

CREATE TABLE OBJREFERENCE (
	ATTR_ID   NUMBER(20),
	REFERENCE NUMBER(20),
	OBJECT_ID NUMBER(20)
); 

ALTER TABLE OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_PK
	PRIMARY KEY (ATTR_ID,REFERENCE,OBJECT_ID);
ALTER TABLE OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_REFERENCE_FK
	FOREIGN KEY(REFERENCE) REFERENCES OBJECTS(OBJECT_ID);
ALTER TABLE OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_OBJECT_ID_FK
	FOREIGN KEY (OBJECT_ID) REFERENCES OBJECTS(OBJECT_ID);
ALTER TABLE OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_ATTR_ID_FK
	FOREIGN KEY (ATTR_ID) REFERENCES ATTRTYPE (ATTR_ID);

/*6.2 Заповнити таблицю зв'язків з урахуванням можливих зв'язків «іменована асоціація» між
раніше створеними екземплярами об'єктів класів.
*/

INSERT INTO objreference (attr_id, object_id, reference)
    VALUES (12, 5, 3);