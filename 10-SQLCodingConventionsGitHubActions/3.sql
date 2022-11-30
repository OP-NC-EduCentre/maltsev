SELECT medicine_id,
    name,
    price,
    production_date, 
    expiration_date
    FROM medicine WHERE name LIKE 'z_n%';
	
/*
Code	Line / Position	Description
L036	1 / 1	
Select targets should be on a new line unless there is only one select target.
L001	4 / 21	
Unnecessary trailing whitespace.
L008	4 / 21	
Commas should be followed by a single whitespace unless followed by a comment.
L003	6 / 5	
Expected 0 indentations, found 1 [compared to line 01]
*/