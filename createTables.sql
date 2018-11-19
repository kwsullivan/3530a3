DROP TABLE recruits_from;
DROP TABLE degree_offered;
DROP TABLE agents;
DROP TABLE country;
DROP TABLE degree;
DROP TABLE university;

CREATE TABLE university (
    name    VARCHAR,
    uid     VARCHAR NOT NULL,
    city    VARCHAR,
    state   VARCHAR,
    url     VARCHAR,
    PRIMARY KEY (uid)
);

CREATE TABLE degree (
    name    VARCHAR,
    type    VARCHAR,
    did     VARCHAR NOT NULL,
    PRIMARY KEY (did)
);

CREATE TABLE country (
    name    VARCHAR,
    cid     VARCHAR NOT NULL,
    PRIMARY KEY (cid)
);

CREATE TABLE degree_offered (
    uid     VARCHAR NOT NULL,
    did     VARCHAR NOT NULL,
    PRIMARY KEY (uid, did),
    FOREIGN KEY (uid) REFERENCES university (uid),
    FOREIGN KEY (did) REFERENCES degree (did)
);

CREATE TABLE agents (
    fname   VARCHAR,
    lname   VARCHAR,
    aid     VARCHAR,
    phone   VARCHAR,
    email   VARCHAR,
    commission  VARCHAR,
    resides_in_city VARCHAR,
    cid     VARCHAR,
    uid     VARCHAR,
    PRIMARY KEY (aid),
    FOREIGN KEY (uid) REFERENCES university (uid),
    FOREIGN KEY (cid) REFERENCES country (cid)
);

CREATE TABLE recruits_from (
    uid             VARCHAR NOT NULL,
    cid             VARCHAR NOT NULL,
    numstudents     VARCHAR,
    PRIMARY KEY (uid, cid),
    FOREIGN KEY (uid) REFERENCES university (uid),
    FOREIGN KEY (cid) REFERENCES country (cid)
);

-- Copy CSV files into corresponding tables

\copy university FROM 'tables/university.csv' WITH (FORMAT csv);
\copy degree FROM 'tables/degree.csv' WITH (FORMAT csv);
\copy country FROM 'tables/country.csv' WITH (FORMAT csv);
\copy degree_offered FROM 'tables/degree_offered.csv' WITH (FORMAT csv);
\copy agents FROM 'tables/agents.csv' WITH (FORMAT csv);
\copy recruits_from FROM 'tables/recruits_from.csv' WITH (FORMAT csv);

DELETE FROM recruits_from WHERE uid = 'uid';
DELETE FROM degree_offered WHERE uid = 'uid';
DELETE FROM agents WHERE aid = 'aid';
DELETE FROM country WHERE cid = 'cid';
DELETE FROM degree WHERE did = 'did';
DELETE FROM university WHERE uid = 'uid';