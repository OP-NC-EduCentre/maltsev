SELECT
    employee.first_name,
    employee.last_name,
    pharmacy.location
FROM employee
INNER JOIN pharmacy
    ON (employee.pharmacy_id = pharmacy.pharmacy_id);
