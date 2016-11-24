CREATE OR REPLACE VIEW average_damage_per_location
AS
    SELECT       location, AVG(damage_amount) "AVERAGE_DAMAGE"
    FROM         accident
    INNER JOIN   participated
    ON           accident.report_number=participated.report_number
    GROUP BY     location;
