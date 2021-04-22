SHOW DATABASES;
DROP DATABASE IF EXISTS Project;
CREATE DATABASE Project;

USE Project;
SHOW TABLES;

SELECT 'Overwriting User Table' AS ``;
DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
    id INT(10) NOT NULL AUTO_INCREMENT,
    fname VARCHAR(30),
    lname VARCHAR(30),
    
    PRIMARY KEY(id)
);

SELECT 'Overwriting Class Table' AS ``;
DROP TABLE IF EXISTS Class;
CREATE TABLE Class (
    id INT(10) NOT NULL AUTO_INCREMENT,
    name VARCHAR(30),
    
    PRIMARY KEY(id)
);

SELECT 'Overwriting StudentsClasses Table' AS ``;
DROP TABLE IF EXISTS StudentsClasses;
CREATE TABLE StudentsClasses (
    sid INT,
    cid INT,
    
    FOREIGN KEY(sid) REFERENCES Student(id),
    FOREIGN KEY(cid) REFERENCES Class(id)
);

SELECT 'Inserting Records' AS ``;
INSERT INTO Class(id, name) VALUES('1', 'Music');
INSERT INTO Class(id, name) VALUES('2', 'Art');
INSERT INTO Class(id, name) VALUES('3', 'Math');
INSERT INTO Class(id, name) VALUES('4', 'Science');
INSERT INTO Class(id, name) VALUES('5', 'English');

INSERT INTO Student(id, fname, lname) VALUES('1', 'John', 'Lennon');
INSERT INTO StudentsClasses(sid, cid) VALUES('1', '1');
INSERT INTO StudentsClasses(sid, cid) VALUES('1', '4');

INSERT INTO Student(id, fname, lname) VALUES('2', 'Paul', 'McCartney');
INSERT INTO StudentsClasses(sid, cid) VALUES('2', '1');
INSERT INTO StudentsClasses(sid, cid) VALUES('2', '4');

INSERT INTO Student(id, fname, lname) VALUES('3', 'George', 'Harrison');
INSERT INTO StudentsClasses(sid, cid) VALUES('3', '1');
INSERT INTO StudentsClasses(sid, cid) VALUES('3', '2');
INSERT INTO StudentsClasses(sid, cid) VALUES('3', '3');

INSERT INTO Student(id, fname, lname) VALUES('4', 'Ringo', 'Starr');
INSERT INTO StudentsClasses(sid, cid) VALUES('4', '1');
