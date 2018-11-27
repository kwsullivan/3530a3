/*
Question 4: Write a PL/pgsql procedure that lists all countries, total number of
students that each university has recruited from different countries and a list of
degrees offered by them. For each university, the display should be sorted in descending
order of number of students. A sample report is shown below. In addition to displaying
the report, for each University in this report, you must add a new row to a table named
recruit_stats. For example, <‘Guelph’, 1488, 3> is added for University of Guelph.
*/

DROP TABLE IF EXISTS recruit_stats;

CREATE TABLE IF NOT EXISTS recruit_stats (
    university          VARCHAR NOT NULL,
    numRecruited        INTEGER,
    NumDegreesOffered   INTEGER,
    PRIMARY KEY (university)
);

CREATE OR REPLACE FUNCTION printReports()
RETURNS void
AS
$$
DECLARE
    c1 CURSOR IS SELECT name, uid FROM university ORDER BY uid ASC;
    recruited REFCURSOR;
    degrees REFCURSOR;
    currRecord RECORD;

    correctedUniName        VARCHAR;
    totalStudents           INTEGER;
    totalDegrees            INTEGER;

    correctedCountryName    VARCHAR;
BEGIN
    FOR i IN c1 LOOP
    totalStudents   := 0;
    totalDegrees    := 0;
    SELECT INITCAP(i.name) INTO correctedUniName;
    RAISE NOTICE E'************************\n';
    --RAISE NOTICE 'UID: %', i. uid;

    CASE
        WHEN i.uid = '100' THEN -- University of Guelph
            RAISE NOTICE 'University of Guelph';
        WHEN i.uid = '200' THEN -- University of Windsor
            RAISE NOTICE 'University of Windsor';
        WHEN i.uid = '300' THEN -- Brock University
            RAISE NOTICE 'Brock University';
        WHEN i.uid = '400' THEN -- University of Toronto
            RAISE NOTICE 'University of Toronto';
        WHEN i.uid = '500' THEN -- Trent University
            RAISE NOTICE 'Trent University';
        WHEN i.uid = '600' THEN -- University of Sherbrooke
            RAISE NOTICE 'University of Sherbrooke';
        ELSE
            RAISE EXCEPTION 'Error: Unknown uid';
    END CASE;
    
        -- ********** Num Students Loop *********************************************
        RAISE NOTICE 'Recruited:';
        OPEN recruited FOR  SELECT name, numstudents FROM
                        country NATURAL JOIN recruits_from
                        WHERE uid = i.uid ORDER BY CAST(numstudents AS INTEGER) DESC;

        LOOP
            FETCH NEXT FROM recruited INTO currRecord;
            EXIT WHEN currRecord IS NULL;

            SELECT INITCAP(currRecord.name) INTO correctedCountryName; -- Convert name from 'NAME' to 'name'
            RAISE NOTICE '% students from %', currRecord.numstudents, correctedCountryName;
            totalStudents := totalStudents + CAST(currRecord.numstudents AS INTEGER);
        END LOOP;

        RAISE NOTICE E'Total number of students = %\n', totalStudents;
        
        CLOSE recruited;
        
        -- ********** Degrees Offered Loop *******************************************
        RAISE NOTICE 'Degree Offered:';
        OPEN degrees FOR    SELECT name FROM
                            degree natural join degree_offered
                            WHERE uid = i.uid;
        
        LOOP
            FETCH NEXT FROM degrees INTO currRecord;
            EXIT WHEN currRecord IS NULL;
            RAISE NOTICE '%', currRecord.name;
        END LOOP;
        SELECT COUNT(*) INTO totalDegrees FROM degree_offered WHERE uid = i.uid;
        CLOSE degrees;

        INSERT INTO recruit_stats VALUES (correctedUniName, totalStudents, totalDegrees);
        --RAISE NOTICE '% % %', correctedUniName, totalStudents, totalDegrees;
    END LOOP;
END
$$
LANGUAGE plpgsql;