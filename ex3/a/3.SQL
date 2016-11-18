SELECT  dept_name,
        MAX(salary) OVER (PARTITION BY dept_name) AS "Max Salary"
FROM    instructor;
