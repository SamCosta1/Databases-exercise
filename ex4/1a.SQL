-- 1a ------
CREATE OR REPLACE VIEW customers_with_shopping_carts
AS
    SELECT
    DISTINCT    firstName,
                lastName
    FROM        customerInfo
    INNER JOIN  orderCartInfo
    ON          orderCartInfo.customerID=customerInfo.loginName;

SELECT * FROM customers_with_shopping_carts;
