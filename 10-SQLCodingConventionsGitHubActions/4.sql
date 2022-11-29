SELECT 
    employee.first_name, 
	employee.last_name, 
	pharmacy.location
	FROM employee 
	INNER JOIN pharmacy 
	ON (employee.pharmacy_id = pharmacy.pharmacy_id);

/*
Code	Line / Position	Description
L001	1 / 7	
Unnecessary trailing whitespace.
L001	2 / 25	
Unnecessary trailing whitespace.
L008	2 / 25	
Commas should be followed by a single whitespace unless followed by a comment.
L004	3 / 1	
Incorrect indentation type found in file.
L001	3 / 21	
Unnecessary trailing whitespace.
L008	3 / 21	
Commas should be followed by a single whitespace unless followed by a comment.
L004	4 / 1	
Incorrect indentation type found in file.
L004	5 / 1	
Incorrect indentation type found in file.
L003	5 / 2	
Expected 0 indentations, found 1 [compared to line 01]
L001	5 / 15	
Unnecessary trailing whitespace.
L004	6 / 1	
Incorrect indentation type found in file.
L003	6 / 2	
Expected 0 indentations, found 1 [compared to line 01]
L001	6 / 21	
Unnecessary trailing whitespace.
L004	7 / 1	
Incorrect indentation type found in file.
*/