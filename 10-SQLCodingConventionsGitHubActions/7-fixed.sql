DELETE FROM pharmacy AS p
WHERE NOT EXISTS
    (SELECT employee.pharmacy_id
        FROM employee
        WHERE employee.pharmacy_id = p.pharmacy_id);