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
