-- Statement runs since the database schema has specified 'delete cascade' in
-- all cases where course_id is a foreign key, so the db knows to delete all
-- records where course_id is a foreign key (and takes this value!) so no error
-- is thrown - Source: Oracle docs
DELETE  course
WHERE   course_id='CS-001';
