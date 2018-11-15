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

\copy university FROM 'university.csv' WITH (FORMAT csv);

\copy degree FROM 'degree.csv' WITH (FORMAT csv);

\copy country FROM 'country.csv' WITH (FORMAT csv);

\copy degree_offered FROM 'degree_offered.csv' WITH (FORMAT csv);

\copy agents FROM 'agents.csv' WITH (FORMAT csv);

\copy recruits_from FROM 'recruits_from.csv' WITH (FORMAT csv);