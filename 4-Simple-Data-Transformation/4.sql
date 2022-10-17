/*4.1 Повторити рішення завдання 3.1
*/

SELECT  
    employee.first_name,
    employee.last_name,
    pharmacy.location
FROM 
    employee,
    pharmacy
WHERE
    employee.pharmacy_id = pharmacy.pharmacy_id;
	
/*
FIRST_NAME           LAST_NAME                      LOCATION
-------------------- ------------------------------ --------------------
Devid                Blane                          Odesa, main street 1
Steaven              Great                          Kyiv, main stree
*/

/*4.2 Повторити рішення завдання 3.2
*/

SELECT 
    e.first_name, 
	e.last_name, 
	p.location
FROM 
    employee e, 
	pharmacy p
WHERE e.pharmacy_id = p.pharmacy_id;

/*
FIRST_NAME           LAST_NAME                      LOCATION
-------------------- ------------------------------ --------------------
Devid                Blane                          Odesa, main street 1
Steaven              Great                          Kyiv, main street 13
*/
	
/*4.3 Повторити рішення завдання 3.4
*/

SELECT 
    e.first_name, 
	e.last_name, 
	p.location
FROM employee e, pharmacy p
WHERE
    e.pharmacy_id = p.pharmacy_id(+);

/*
FIRST_NAME           LAST_NAME                      LOCATION
-------------------- ------------------------------ --------------------
Devid                Blane                          Odesa, main street 1
Steaven              Great                          Kyiv, main street 13
Bob                  Addxz