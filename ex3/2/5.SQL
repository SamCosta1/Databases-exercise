SELECT  location
FROM    average_damage_per_location
WHERE   average_damage = (
                            SELECT  MAX(average_damage)
                            FROM    average_damage_per_location
                         );
