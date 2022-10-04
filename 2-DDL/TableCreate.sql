drop table warehouse CASCADE CONSTRAINTS;
drop table costumer CASCADE CONSTRAINTS;
drop table medicine CASCADE CONSTRAINTS;
drop table order_ CASCADE CONSTRAINTS;
drop table pharmacy CASCADE CONSTRAINTS;
drop table employee CASCADE CONSTRAINTS;

CREATE TABLE employee(
    employee_id NUMBER(8),
    first_name VARCHAR(20),
    last_name VARCHAR(30),
    phone_number VARCHAR(20),
	pharmacy_id NUMBER(8)
);

CREATE TABLE pharmacy(
	pharmacy_id NUMBER(8),
	name VARCHAR(20),
	location VARCHAR(20),
	medicine_id NUMBER(8)
);

CREATE TABLE order_(
	order_id NUMBER(8),
	medicine_id NUMBER(8),
	order_date DATE,
	total NUMBER(6,2),
	seller NUMBER(8),
	buyer NUMBER(8)
);

CREATE TABLE medicine(
	medicine_id NUMBER(8),
	name VARCHAR(35),
	price NUMBER(6,2),
	production_date DATE,
	expiration_date DATE
);

CREATE TABLE costumer(
	costumer_id NUMBER(8),
    first_name VARCHAR(20),
    last_name VARCHAR(30),
    phone_number VARCHAR(20)
);

CREATE TABLE warehouse(
    warehouse_id NUMBER(8),
	name VARCHAR(20),
	location VARCHAR(20),
	medicine_id NUMBER(8)
);