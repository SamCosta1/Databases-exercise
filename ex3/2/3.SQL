SELECT  DISTINCT person.name,
        SUM(damage_amount) OVER (PARTITION BY person.driver_id) AS "Total Dmge"
FROM    person
INNER JOIN participated
ON      participated.driver_id=person.driver_id
ORDER
BY      "Total Dmg" ASC;
