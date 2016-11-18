-- Have assumed missing out the other columns won't cause issues
-- since the schema doesn't define that they should be non null
-- (and obviously the missing ones don't make up part of the primary key)
INSERT INTO section (course_id,
                     sec_id,
                     semester,
                     year)
VALUES ('CS-001',
        1,
        'Fall',
        2009);
