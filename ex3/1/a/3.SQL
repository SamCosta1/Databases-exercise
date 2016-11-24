SELECT   dept_name,
         MAX(salary)
FROM     instructor
GROUP BY dept_name;
