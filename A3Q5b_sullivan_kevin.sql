-- Question 5:

/* 
b. Write a trigger for table University so that anytime the url is changed, an alert message is
    displayed on the screen (for example, ’University of Guelph is changing its url’).
*/

CREATE OR REPLACE FUNCTION url_change_notice()
RETURNS trigger

AS $$
DECLARE
    uniName VARCHAR;
BEGIN
    CASE
        WHEN NEW.uid = '100' THEN -- University of Guelph
            uniName := 'University of Guelph';
        WHEN NEW.uid = '200' THEN -- University of Windsor
            uniName := 'University of Windsor';
        WHEN NEW.uid = '300' THEN -- Brock University
            uniName := 'Brock University';
        WHEN NEW.uid = '400' THEN -- University of Toronto
            uniName := 'University of Toronto';
        WHEN NEW.uid = '500' THEN -- Trent University
            uniName := 'Trent University';
        WHEN NEW.uid = '600' THEN -- University of Sherbrooke
            uniName := 'University of Sherbrooke';
        ELSE
            RAISE EXCEPTION 'Error: Unknown uid';
    END CASE;
    RAISE NOTICE '% is changing its url', uniName;
    RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER notify_for_url
BEFORE UPDATE OF url ON university
FOR EACH ROW
EXECUTE PROCEDURE url_change_notice();