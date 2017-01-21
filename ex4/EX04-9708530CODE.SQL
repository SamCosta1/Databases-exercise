
SET ECHO ON
SPOOL /home/mbax4sd3/databases/ex4/EX04-9708530.SQL
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
 
-- 1b ------

CREATE OR REPLACE VIEW items_to_reorder
AS
    SELECT  code,
            inventoryItem.itemNum,
            belongsTo AS categoryID,
            qtyInstock AS quantityInStock
    FROM    inventoryItem
    INNER JOIN  itemType
    ON      inventoryItem.itemNum = itemType.itemNum
    WHERE   qtyInstock < 25;

COLUMN CODE FORMAT A5
SELECT * FROM items_to_reorder;
CLEAR COLUMNS
 
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
        END AS BR_1
FROM    carts_per_customer;
 
-- 1f ------

SELECT  itemNum,
        itemColor,
        itemSize
FROM
    (
        SELECT  itemNum,
        itemColor,
        itemSize,
        CASE
        WHEN    COUNT_COL_SIZE <= 1
        THEN    'BR-2 satisfied'
        ELSE    'BR-2 violated'
        END AS BR_2
        FROM
        (
            SELECT  itemNum,
            itemColor,
            itemSize,
            COUNT(itemColor) AS COUNT_COL_SIZE
            FROM    inventoryItem
            GROUP BY itemNum, itemColor, itemSize
        )
    )
WHERE BR_2='BR-2 violated';
 
-- 1g ------

SHOW ERRORS TRIGGER check_item_value
SET PAGES 999;
SET LONG 999999;
COLUMN "Picture" FORMAT A7;

CREATE OR REPLACE TRIGGER check_item_value
    AFTER INSERT OR UPDATE ON itemType
    DECLARE
        min_price       float DEFAULT 0;
        max_price       float DEFAULT 0;
    BEGIN
        SELECT  MIN(price) INTO min_price
        FROM    itemType;

        SELECT  MAX(price) INTO max_price
        FROM    itemType;

        IF max_price > min_price * 4
        THEN
            RAISE_APPLICATION_ERROR(num => -20000,
                                    msg => 'Price too high');
        END IF;
    END check_item_value;
/

-- Initial state of table
SELECT * FROM itemType;

-- Valid insert
INSERT into itemType VALUES ('D4', 'The 5th thing', '++-+-', 10.88, 'P');

-- Invalid inserts
INSERT into itemType VALUES ('C3', 'The thing', '++-+-', 500.99, 'P');
INSERT into itemType VALUES ('D1', 'The other thing', '++-+-', 43.97, 'P');
INSERT into itemType VALUES ('D2', 'The 3rd thing', '++-+-', 60.99, 'P');
INSERT into itemType VALUES ('D3', 'The 4th thing', '++-+-', 90.88, 'P');

-- State after insertions
SELECT * FROM itemType;

-- Valid update
UPDATE itemType SET price=10.15 WHERE itemNum='A1';

-- Invalid updates
UPDATE itemType SET price=61.56  WHERE itemNum='A1';
UPDATE itemType SET price=86.56  WHERE itemNum='A2';
UPDATE itemType SET price=150.23 WHERE itemNum='A3';

-- State after updating
SELECT * FROM itemType;
 


SPOOL OFF
    
