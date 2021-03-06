-- 1c ------
CREATE OR REPLACE VIEW order_details
AS
    SELECT      loginName,
                firstName,
                lastName,
                orderCartInfo.orderCartId,
                SUM(qtyOrdered * orderPrice)  AS TotalPrice
    FROM        customerInfo
    INNER JOIN  orderCartInfo
    ON          orderCartInfo.customerID = customerInfo.loginName
    INNER JOIN  lineItems
    ON          lineItems.orderCartId=orderCartInfo.orderCartId
    GROUP BY    orderCartInfo.orderCartId,
                loginName,
                firstName,
                lastName;

COLUMN FIRSTNAME FORMAT A10
COLUMN LASTNAME FORMAT A10
COLUMN ORDERCARTID FORMAT A12
SELECT * FROM order_details;
CLEAR COLUMNS
