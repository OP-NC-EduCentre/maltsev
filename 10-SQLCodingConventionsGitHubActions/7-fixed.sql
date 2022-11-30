DELETE FROM pharmacy
WHERE NOT EXISTS
    (SELECT employee.pharmacy_id
        FROM employee
        WHERE employee.pharmacy_id = pharmacy.pharmacy_id);
