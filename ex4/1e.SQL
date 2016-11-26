-- 1e ------
CREATE OR REPLACE VIEW carts_per_customer
AS
    SELECT      loginName,
                COUNT(orderCartId) AS numOrders
    FROM        customerInfo
    INNER JOIN  orderCartInfo
    ON          customerInfo.loginName = orderCartInfo.customerId
    GROUP BY    loginName;

SELECT  loginName,
        CASE
            WHEN    numOrders <= 2
            THEN    'BR-1 satisfied'
            ELSE    'BR-1 violated'
        END
FROM    carts_per_customer;
