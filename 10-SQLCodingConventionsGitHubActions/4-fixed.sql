SELECT
    e.first_name,
    e.last_name,
    pharmacy.location
FROM employee e
INNER JOIN pharmacy
    ON (employee.pharmacy_id = pharmacy.pharmacy_id);
