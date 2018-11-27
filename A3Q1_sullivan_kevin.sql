/*
Question 1: Write a PL/pgsql function that returns the number of
agents hired by a university.
*/

CREATE OR REPLACE FUNCTION numberAgents(uniName VARCHAR)
RETURNS INTEGER
AS
$$
DECLARE
    upperName VARCHAR;
    matchUID INTEGER;
    numberagents INTEGER;
BEGIN
    SELECT UPPER(uniName) INTO upperName FROM university;
    SELECT uid INTO matchUID FROM university where name = upperName;
    SELECT COUNT(uid) FROM agents INTO numberagents WHERE uid = matchUID GROUP BY uid;

     RETURN numberagents;
END
$$
LANGUAGE plpgsql;