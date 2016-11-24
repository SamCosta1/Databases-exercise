COLUMN "Student ID" FORMAT A10;

SELECT  student.id  AS "Student ID",
        name        AS "Student Name"
FROM
    (
     SELECT ID As studentID FROM takes
     MINUS
     SELECT ID FROM takes WHERE year < 2009
    )
INNER JOIN student ON student.id=studentID;
