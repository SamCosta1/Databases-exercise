SELECT
DISTINCT    name AS "Student Name"
FROM        student
INNER JOIN  takes
ON          student.ID=takes.ID
INNER JOIN  course
ON          takes.course_id=course.course_id
WHERE       course.dept_name='Comp. Sci.';
