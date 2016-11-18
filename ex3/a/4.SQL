SELECT MIN(salary)
FROM
    (
       SELECT  MAX(salary) OVER (PARTITION BY dept_name) AS salary
       FROM    instructor
    );
