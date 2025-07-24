
-- Academic Record Database

DROP TABLE IF EXISTS ARenrollment CASCADE;
DROP TABLE IF EXISTS ARsubject CASCADE;
DROP TABLE IF EXISTS ARstudent CASCADE;
DROP TABLE IF EXISTS ARdegree CASCADE;

CREATE TABLE ARdegree (
    degreecode CHAR(4) PRIMARY KEY,
    degreename TEXT NOT NULL
);

CREATE TABLE ARstudent (
    studentno CHAR(8) PRIMARY KEY,
    studentname TEXT,
    studentbirth INTEGER,
    degreecode CHAR(4) REFERENCES ARdegree(degreecode)
);

CREATE TABLE ARsubject (
    subjectcode CHAR(6) PRIMARY KEY,
    subjectname TEXT,
    subjectunit INTEGER
);

CREATE TABLE ARenrollment (
    studentno CHAR(8) REFERENCES ARstudent(studentno),
    subjectcode CHAR(6) REFERENCES ARsubject(subjectcode),
    mark INTEGER,
    PRIMARY KEY(studentno, subjectcode)
);

-- Sample data
INSERT INTO ARdegree VALUES ('CS01', 'Computer Science');
INSERT INTO ARdegree VALUES ('EN01', 'Engineering');

INSERT INTO ARstudent VALUES ('S0000001', 'Alice Smith', 2001, 'CS01');
INSERT INTO ARstudent VALUES ('S0000002', 'Bob Johnson', 2000, 'EN01');

INSERT INTO ARsubject VALUES ('CS101', 'Intro to CS', 4);
INSERT INTO ARsubject VALUES ('EN201', 'Thermodynamics', 3);

INSERT INTO ARenrollment VALUES ('S0000001', 'CS101', 88);
INSERT INTO ARenrollment VALUES ('S0000002', 'EN201', 75);
