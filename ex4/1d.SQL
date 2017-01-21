-- 1d ------
COLUMN FIRSTNAME FORMAT A10
COLUMN LASTNAME FORMAT A10
CREATE OR REPLACE VIEW customer_order_details
AS
    SELECT      loginName,
                firstName,
                lastName,
                SUM(totalPrice) AS totalPrice
    FROM        order_details
    GROUP BY    loginName,
                firstName,
                lastName;

SELECT * FROM customer_order_details;
CLEAR COLUMNS
