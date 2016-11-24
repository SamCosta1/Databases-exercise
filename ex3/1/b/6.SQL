INSERT INTO takes (ID,
                   course_id,
                   sec_id,
                   semester,
                   year)
SELECT ID,
       'CS-001',
       1,
       'Fall',
       2009
FROM   student
--WHERE  dept_name='Comp. Sci.';
