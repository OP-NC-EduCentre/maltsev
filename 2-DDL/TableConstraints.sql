ALTER TABLE employee ADD CONSTRAINT emp_phone_unique 
	UNIQUE (phone_number);
ALTER TABLE employee MODIFY (phone_number NOT NULL);

ALTER TABLE costumer ADD CONSTRAINT costum_phone_unique
	UNIQUE (phone_number);
ALTER TABLE costumer MODIFY (phone_number NOT NULL);

ALTER TABLE medicine ADD CONSTRAINT med_name_unique
	UNIQUE (name);
ALTER TABLE medicine MODIFY (name NOT NULL);

ALTER TABLE pharmacy ADD CONSTRAINT pharm_loc_unique
	UNIQUE (location);
ALTER TABLE pharmacy MODIFY (location NOT NULL);

ALTER TABLE warehouse ADD CONSTRAINT warehouse_loc_unique
	UNIQUE (location);
ALTER TABLE warehouse MODIFY (location NOT NULL);



ALTER TABLE employee ADD CONSTRAINT emp_pk 
	PRIMARY KEY (employee_id);
	
ALTER TABLE costumer ADD CONSTRAINT cost_pk
	PRIMARY KEY (costumer_id);
	
ALTER TABLE medicine ADD CONSTRAINT med_pk
	PRIMARY KEY (medicine_id);
	
ALTER TABLE order_ ADD CONSTRAINT order_pk
	PRIMARY KEY (order_id);
	
ALTER TABLE pharmacy ADD CONSTRAINT pharm_pk
	PRIMARY KEY (pharmacy_id);
	
ALTER TABLE warehouse ADD CONSTRAINT wh_pk
	PRIMARY KEY (warehouse_id);	

	
	
ALTER TABLE employee ADD CONSTRAINT emp_pharmacy_fk
	FOREIGN KEY (pharmacy_id) REFERENCES pharmacy(pharmacy_id);
	
ALTER TABLE order_ ADD CONSTRAINT order_med_fk
	FOREIGN KEY (medicine_id) REFERENCES medicine(medicine_id);
ALTER TABLE order_ ADD CONSTRAINT order_seller_fk
	FOREIGN KEY (seller) REFERENCES employee(employee_id);
ALTER TABLE order_ ADD CONSTRAINT order_buyer_fk
	FOREIGN KEY (buyer) REFERENCES costumer(costumer_id);
	
ALTER TABLE pharmacy ADD CONSTRAINT pharmacy_med_fk
	FOREIGN KEY (medicine_id) REFERENCES medicine(medicine_id);

ALTER TABLE warehouse ADD CONSTRAINT warehouse_med_fk
	FOREIGN KEY (medicine_id) REFERENCES medicine(medicine_id);
	
	
ALTER TABLE order_ ADD CONSTRAINT total_bigger_then_zero
    CHECK (total > 0);

ALTER TABLE medicine ADD CONSTRAINT production_date_earlier_then_expire
    CHECK (production_date < expiration_date);