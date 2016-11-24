SELECT  MIN(MAX_SALARY)
FROM
    (
       SELECT   dept_name,
                MAX(salary) AS "MAX_SALARY"
       FROM     instructor
       GROUP BY dept_name
    );
