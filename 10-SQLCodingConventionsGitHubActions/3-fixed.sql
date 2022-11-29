SELECT
    medicine_id,
    name,
    price,
    production_date,
    expiration_date
FROM medicine
WHERE name LIKE 'z_n%'
