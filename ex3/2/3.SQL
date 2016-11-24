SELECT  *
FROM
(
    SELECT      name,
                SUM(damage_amount) AS "TOTAL_DAMAGE"
    FROM        person
    INNER JOIN  participated
    ON          person.driver_id=participated.driver_id
    GROUP BY    name
)
WHERE       TOTAL_DAMAGE > 3000
ORDER BY    TOTAL_DAMAGE ASC;
