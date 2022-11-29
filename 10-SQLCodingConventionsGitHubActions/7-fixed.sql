DELETE FROM pharmacy AS p
WHERE NOT EXISTS
    (SELECT employee.pharmacy_id
        FROM employee e
        WHERE e.pharmacy_id = p.pharmacy_id);
