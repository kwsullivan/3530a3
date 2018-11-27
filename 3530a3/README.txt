CIS*3530 - Assignment 3
Kevin Sullivan - 0947706

My createTables.sql file will create all of the tables and add the data from the CSV files found in the 'tables' folder.
Since the column headers are in the CSV files, I used a delete from table command to get rid of the tuples of the column
names for all of the tables.

The functions below can be copied and pasted to create my tables and run all of my commands.

-- IF YOU WANT TO REMAKE THE TABLES --

drop schema a3 cascade;
create schema a3;
set search_path to a3;

\i createTables.sql
\i A3Q1_sullivan_kevin.sql
\i A3Q2_sullivan_kevin.sql
\i A3Q3_sullivan_kevin.sql
\i A3Q4_sullivan_kevin.sql
\i A3Q5a_sullivan_kevin.sql
\i A3Q5b_sullivan_kevin.sql
\i A3Bonus_sullivan_kevin.sql
