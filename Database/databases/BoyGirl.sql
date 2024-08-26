-- The BoyGirl Example for lectures
-- http://www-staff.it.uts.edu.au/~raymond/db/boygirl.txt

-- Drop tables if they exist
DROP TABLE IF EXISTS Boy CASCADE;
DROP TABLE IF EXISTS Girl CASCADE;

-- Create the Girl table
CREATE TABLE Girl (
    girlNo INTEGER,
    girlName CHAR(10),
    girlMobile CHAR(10),
    CONSTRAINT girlNoPK PRIMARY KEY (girlNo)
);

-- Create the Boy table
CREATE TABLE Boy (
    boyNo INTEGER,
    boyName CHAR(10),
    girlNo INTEGER,
    boyMobile CHAR(10),
    CONSTRAINT boyNoPK PRIMARY KEY (boyNo),
    CONSTRAINT girlNoFK FOREIGN KEY (girlNo) REFERENCES Girl ON DELETE RESTRICT
);

-- Insert data into the Girl table
INSERT INTO Girl VALUES (1, 'Alice', '0414 1234');
INSERT INTO Girl VALUES (2, 'Bonnie', '0414 1235');

-- Insert data into the Boy table
INSERT INTO Boy VALUES (1, 'Adam', 1, '0414 1236');
INSERT INTO Boy VALUES (2, 'Bob', 2, '0414 1237');
INSERT INTO Boy VALUES (3, 'Charlie', 2, '0414 1238');
INSERT INTO Boy VALUES (4, 'Dennis', NULL, NULL);

-- Sample queries to verify the inserted data
-- SELECT * FROM Boy;
-- SELECT * FROM Girl;
