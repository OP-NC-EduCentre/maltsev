DELETE FROM pharmacy p
	WHERE NOT EXISTS  
		       (SELECT pharmacy_id
 			    FROM employee e
 			    WHERE e.pharmacy_id = p.pharmacy_id);
				
/*
Code	Line / Position	Description
L011	1 / 22	
Implicit/explicit aliasing of table.
L004	2 / 1	
Incorrect indentation type found in file.
L003	2 / 2	
Expected 0 indentations, found 1 [compared to line 01]
L001	2 / 18	
Unnecessary trailing whitespace.
L002	3 / 1	
Mixed Tabs and Spaces in single whitespace.
L004	3 / 1	
Incorrect indentation type found in file.
L003	3 / 10	
Expected 4 indentations, found less than 4 [compared to line 01]
L028	3 / 18	
Unqualified reference 'pharmacy_id' found in single table select.
L002	4 / 1	
Mixed Tabs and Spaces in single whitespace.
L004	4 / 1	
Incorrect indentation type found in file.
L003	4 / 9	
Expected 6 indentations, found less than 5 [compared to line 01]
L011	4 / 23	
Implicit/explicit aliasing of table.
L031	4 / 23	
Avoid aliases in from clauses and join conditions.
L002	5 / 1	
Mixed Tabs and Spaces in single whitespace.
L004	5 / 1	
Incorrect indentation type found in file.
L003	5 / 9	
Expected 6 indentations, found less than 5 [compared to line 01]
L028	5 / 15	
Qualified reference 'e.pharmacy_id' found in single table select which is inconsistent with previous references.
L026	5 / 31	
Reference 'p.pharmacy_id' refers to table/view not found in the FROM clause or found in ancestor statement.
*/