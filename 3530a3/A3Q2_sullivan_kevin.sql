/*
Question 2: Write a PL/pgsql function that takes an agent id as input and
returns the max commission earned by the agent. If the agent id is not found
in the schema, then the function displays a message that it is an invalid id,
along with the complete list of agents in the schema sorted on agent id.
A sample scenario is shown below. (Reminder: RAISE NOTICE is used to display messages
and RAISE EXCEPTION is used to display a pl/pgsql error message.
*/

CREATE OR REPLACE FUNCTION find_max_commission(input INTEGER)
RETURNS VARCHAR
AS
$$
DECLARE
    max_commission VARCHAR;
    num_rows INTEGER;
    agentID VARCHAR;
    c1 CURSOR IS SELECT aid, fname, lname FROM agents;
BEGIN
    agentID := CAST (input AS VARCHAR);
    SELECT COUNT(*) FROM agents INTO num_rows agents WHERE aid = agentID;

    IF num_rows > 0 THEN
        SELECT commission FROM agents INTO max_commission WHERE aid = agentID;
    ELSE
        RAISE NOTICE 'Invalid agent id. Valid agent ids are:';
        FOR i in c1 LOOP
            IF i.aid != 'aid' THEN
                RAISE NOTICE '%: % %', i.aid, i.fname, i.lname;
            END IF;
        END LOOP;
        RAISE EXCEPTION 'Invalid agent id';
    END IF;
    RETURN max_commission;
END
$$
LANGUAGE plpgsql;