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
