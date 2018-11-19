/*
Question 4: Write a PL/pgsql procedure that lists all countries, total number of
students that each university has recruited from different countries and a list of
degrees offered by them. For each university, the display should be sorted in descending
order of number of students. A sample report is shown below. In addition to displaying
the report, for each University in this report, you must add a new row to a table named
recruit_stats. For example, <‘Guelph’, 1488, 3> is added for University of Guelph.
*/

CREATE OR REPLACE FUNCTION (input INTEGER)
RETURNS VARCHAR
AS
$$
DECLARE

BEGIN

END
$$
LANGUAGE plpgsql;



CREATE TABLE IF NOT EXISTS recruit_stats (
    university          VARCHAR NOT NULL,
    numRecruited        INTEGER,
    NumDegreesOffered   INTEGER,
    PRIMARY KEY (university)
);