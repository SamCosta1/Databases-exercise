-- In the script that created the table we see
-- the code: check (credits > 0)
-- Which is a 'check constraint' in oracle which throws an error
-- if the condition isn't met, ie if the #credits given < 0
INSERT INTO course
VALUES ('CS-002',
        'Monthly Seminar',
        'Comp. Sci.',
        '0');
