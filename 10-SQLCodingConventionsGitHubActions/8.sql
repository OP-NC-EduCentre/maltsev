UPDATE employee 
	SET phone_number = regexp_replace(
        phone_number,
		'(.+)',
		'Mobile: \1');
		
/*
Code	Line / Position	Description
L001	1 / 16	
Unnecessary trailing whitespace.
L004	2 / 1	
Incorrect indentation type found in file.
L003	2 / 2	
Expected 0 indentations, found 1 [compared to line 01]
L004	4 / 1	
Incorrect indentation type found in file.
L004	5 / 1	
Incorrect indentation type found in file.
*/