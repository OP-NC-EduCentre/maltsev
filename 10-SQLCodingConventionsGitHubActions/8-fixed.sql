UPDATE employee
SET phone_number = regexp_replace (
        phone_number,
        '(.+)',
        'Mobile: \1');
