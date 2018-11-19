-- Question 6 (BONUS):

/*
Create a table called POSSIBLE_IDS with 1 field called ID (VARCHAR (60)).

Create a stored procedure/function called generate_id that takes the first name,
last name and date of birth of an employee (stored as VARCHAR), and generates a list of
possible login ids for the person by using combinations of first name, lastname, age and
the sun sign of the person and stores this list in the table POSSIBLE_IDS.
*/

CREATE TABLE IF NOT EXISTS POSSIBLE_IDS (
    ID  VARCHAR(60),
    PRIMARY KEY (ID)
);

DELETE FROM TABLE POSSIBLE_IDS;

CREATE OR REPLACE FUNCTION generate_id (firstName VARCHAR, lastName VARCHAR, dateOfBirth VARCHAR)
RETURNS void
AS
$$
DECLARE
    generated_id    VARCHAR(60);
    starPath        VARCHAR;
    age             VARCHAR;
    monthBorn       INTEGER;
    dayBorn         INTEGER;
    
BEGIN
    firstName := INITCAP(firstName);
    lastName := INITCAP(lastName);
    SELECT(date_part('year', age(current_date, CAST(dateOfBirth AS TIMESTAMP)))) INTO age;
    SELECT EXTRACT (MONTH FROM CAST(dateOfBirth AS TIMESTAMP)) INTO monthBorn;
    SELECT EXTRACT (DAY FROM CAST(dateOfBirth AS TIMESTAMP)) INTO dayBorn;

    CASE
        WHEN monthBorn = 1  THEN -- January
            IF dayBorn <= 20 THEN
                starPath := 'Capricorn';
            ELSE
                starPath := 'Aquarius';
            END IF;
        WHEN monthBorn = 2  THEN -- February
            IF dayBorn <= 19 THEN
                starPath := 'Aquarius';
            ELSE
                starPath := 'Pisces';
            END IF;
        WHEN monthBorn = 3  THEN -- March
            IF dayBorn <= 20 THEN
                starPath := 'Pisces';
            ELSE
                starPath := 'Aries';
            END IF;
        WHEN monthBorn = 4  THEN -- April
            IF dayBorn <= 20 THEN
                starPath := 'Aries';
            ELSE
                starPath := 'Taurus';
            END IF;
        WHEN monthBorn = 5  THEN -- May
            IF dayBorn <= 21 THEN
                starPath := 'Taurus';
            ELSE
                starPath := 'Gemini';
            END IF;
        WHEN monthBorn = 6  THEN -- June
            IF dayBorn <= 21 THEN
                starPath := 'Gemini';
            ELSE
                starPath := 'Cancer';
            END IF;
        WHEN monthBorn = 7  THEN -- July
            IF dayBorn <= 22 THEN
                starPath := 'Cancer';
            ELSE
                starPath := 'Leo';
            END IF;
        WHEN monthBorn = 8  THEN -- August
            IF dayBorn <= 21 THEN
                starPath := 'Leo';
            ELSE
                starPath := 'Virgo';
            END IF;
        WHEN monthBorn = 9  THEN -- September
            IF dayBorn <= 23 THEN
                starPath := 'Virgo';
            ELSE
                starPath := 'Libra';
            END IF;
        WHEN monthBorn = 10 THEN -- October
            IF dayBorn <= 23 THEN
                starPath := 'Libra';
            ELSE
                starPath := 'Scorpio';
            END IF;
        WHEN monthBorn = 11 THEN -- November
            IF dayBorn <= 22 THEN
                starPath := 'Scorpio';
            ELSE
                starPath := 'Sagittarius';
            END IF;
        WHEN monthBorn = 12 THEN -- December
            IF dayBorn <= 22 THEN
                starPath := 'Sagittarius';
            ELSE
                starPath := 'Capricorn';
            END IF;
    END CASE;
        -- firstName_lastName *****************************************************
    generated_id := firstName || '_' || lastName;
    INSERT INTO POSSIBLE_IDS VALUES (generated_id);
    --RAISE NOTICE '%', generated_id;
-- firstName_lastName_age *****************************************************
    generated_id := firstName || '_' || lastName || '_' || age;
    INSERT INTO POSSIBLE_IDS VALUES (generated_id);
    --RAISE NOTICE '%', generated_id;
-- firstName_age *****************************************************
    generated_id := firstName || '_' || age;
    INSERT INTO POSSIBLE_IDS VALUES (generated_id);
    --RAISE NOTICE '%', generated_id;
-- lastName_age *****************************************************
    generated_id := lastName || '_' || age;
    INSERT INTO POSSIBLE_IDS VALUES (generated_id);
    --RAISE NOTICE '%', generated_id;
-- firstName_lastName_starPath *****************************************************
    generated_id := firstName || '_' || lastName || '_' || starPath;
    INSERT INTO POSSIBLE_IDS VALUES (generated_id);
    --RAISE NOTICE '%', generated_id;
-- lastName_starPath *****************************************************
    generated_id := lastName || '_' || starPath;
    INSERT INTO POSSIBLE_IDS VALUES (generated_id);
    --RAISE NOTICE '%', generated_id;
-- firstName_starPath *****************************************************
    generated_id := firstName || '_' || starPath;
    INSERT INTO POSSIBLE_IDS VALUES (generated_id);
    --RAISE NOTICE '%', generated_id;
-- firstName_lastName_starPath_age *****************************************************
    generated_id := firstName || '_' || lastName || '_'|| starPath || '_' || age;
    INSERT INTO POSSIBLE_IDS VALUES (generated_id);
    --RAISE NOTICE '%', generated_id;
END
$$
LANGUAGE plpgsql;










