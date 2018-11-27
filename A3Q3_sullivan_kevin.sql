/*
Question 3: Write a PL/pgsql function that generates an email for each agent
(in addition to the gmail one) given their aid using their first name, last name
and name of the university. Note that domain for universities of Brock and Trent
have letter ‘u’ after their name (e.g. brocku.ca), Windsor, Sherbrooke and Toronto
have letter ‘u’ before their name (e.g. utoronto.ca) and Guelph has letters ‘uo’
before its name (e.g. uoguelph.ca).
*/

CREATE OR REPLACE FUNCTION generateEmail(input INTEGER)
RETURNS VARCHAR
AS
$$
DECLARE
    agentID INTEGER:= input;
    num_rows INTEGER;
    
    newEmail VARCHAR;
    c1 CURSOR IS SELECT * FROM agents WHERE aid = agentID;
    c2 CURSOR IS SELECT aid, fname, lname FROM agents ORDER BY aid ASC;
    fname VARCHAR;
    lname VARCHAR;
    country VARCHAR;
    domain VARCHAR;
BEGIN

    SELECT COUNT(*) FROM agents INTO num_rows agents WHERE aid = agentID;
    
    IF num_rows > 0 THEN
    FOR i in c1 LOOP
        SELECT LOWER(i.fname) INTO fname;
        SELECT LOWER(i.lname) INTO lname;
        SELECT LOWER(i.resides_in_city) INTO country;

        IF i.uid = '100' THEN
            domain := 'uoguelph';
        END IF;
        IF i.uid = '200' THEN
            domain := 'uwindsor';
        END IF;
        IF i.uid = '300' THEN
            domain := 'brocku';
        END IF;
        IF i.uid = '400' THEN
            domain := 'utoronto';
        END IF;
        IF i.uid = '500' THEN
            domain := 'trentu';
        END IF;
        IF i.uid = '600' THEN
            domain := 'usherbrooke';
        END IF;

        newEmail := fname || '.' || lname || '.' || country || '@' || domain ||'.ca';
    END LOOP;

    ELSE
        RAISE NOTICE 'Invalid agent id. Valid agent ids are:';
        FOR i in c2 LOOP
            RAISE NOTICE '%: % %', i.aid, i.fname, i.lname;
        END LOOP;
        RAISE EXCEPTION 'Invalid agent id';
    END IF;

    RETURN newEmail;
END
$$
LANGUAGE plpgsql;

--SELECT generateEmail(1);
--SELECT generateEmail(2);
--SELECT generateEmail(3);
--SELECT generateEmail(4);
--SELECT generateEmail(5);
--SELECT generateEmail(6);
--SELECT generateEmail(7);
--SELECT generateEmail(8);
--SELECT generateEmail(9);
--SELECT generateEmail(10);