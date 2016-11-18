SELECT  COUNT(report_number)
FROM    participated
INNER JOIN owns
ON      owns.license=participated.license
WHERE   owns.driver_id=
            (
                SELECT driver_id FROM person WHERE name='Jane Rowling'
            );
