
-- Question 5:

/*
a. Write a trigger called ensure_case for table Agents that change the letters in first and
    last names of agents to uppercase before the data is actually inserted or updated in the table.
    For example, if the insert statement given by a user is:
    INSERT INTO Agents (fname, lname, aid) VALUES (‘Ritu’, ‘chaturvedi’, 13);
    this trigger must change the letters in fname to RITU and lname to CHATURVEDI before the row
    gets inserted into table Agents.
*/

CREATE OR REPLACE FUNCTION capitalize_names()
RETURNS trigger
 
AS $$
BEGIN
    NEW.fname := UPPER(NEW.fname);
    NEW.lname := UPPER(NEW.lname);
    RETURN NEW;
END
$$
LANGUAGE plpgsql;


CREATE TRIGGER ensure_case
BEFORE INSERT ON agents
FOR EACH ROW
EXECUTE PROCEDURE capitalize_names();

-- ============== Testing trigger ==============
/*
DELETE FROM agents WHERE aid= '69';
INSERT INTO agents VALUES('kevin', 'sullivan', '69', '2269794474', 'ksulli06@uoguelph.ca', '69', 'Guelph', '1', '100');
SELECT * FROM agents;
*/