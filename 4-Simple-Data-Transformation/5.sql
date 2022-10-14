/*5.1 Для однієї з таблиць створити команду отримання кількості рядків таблиці, згрупованих по
одній з колонок, яка також повинна бути отримана, об'єднавши її з командою отримання загальної
кількості рядків із зазначенням слова «Разом:».
*/

SELECT
	first_name AS "Name",
	COUNT(costumer_id) AS "quantity"
FROM costumer
GROUP BY first_name
UNION ALL
SELECT
    'Total count of costumers',
    COUNT(costumer_id)
FROM costumer;

/*
Name                       quantity
------------------------ ----------
Steven                            1
Maksym                            1
John                              2
Total count of costumers          4
*/