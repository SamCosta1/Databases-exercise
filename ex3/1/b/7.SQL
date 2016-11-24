DELETE takes
WHERE  ID=(SELECT ID FROM student WHERE name='Zhang')
AND    sec_id=1
AND    course_id='CS-001'
AND    semester='Fall'
AND    year=2009;
