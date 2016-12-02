-- 1f ------
--COLUMN ITEMCOLOR FORMAT A9;
--COLUMN ITEMNUM FORMAT A7
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


--CLEAR COLUMNS
