DELETE  takes
WHERE   course_id IN
        (
            SELECT course_id
            FROM   course
            WHERE  LOWER(title) LIKE '%database%'
        );
