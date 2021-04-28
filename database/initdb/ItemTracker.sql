SHOW DATABASES;
DROP DATABASE IF EXISTS ItemTracker;
CREATE DATABASE ItemTracker;

USE ItemTracker;
SHOW TABLES;

CREATE TABLE OWNER (
	owner_id CHAR(9) NOT NULL,
	
	PRIMARY KEY(owner_id)
)
CHARACTER SET 'utf8mb4'
COLLATE 'utf8mb4_unicode_520_ci';

CREATE TABLE ITEM (
	item_id CHAR(9) NOT NULL,
	name VARCHAR(35),
	description VARCHAR(100),
	isLiquid VARCHAR(3),
	isElectric VARCHAR(3),
	type_flag CHAR(1),
	
	PRIMARY KEY(item_id)
)
CHARACTER SET 'utf8mb4'
COLLATE 'utf8mb4_unicode_520_ci';

CREATE TABLE USER (
	email VARCHAR(50) NOT NULL,
	owner_id CHAR(9),
	fname VARCHAR(25),
	mname VARCHAR(25),
	lname VARCHAR(25),
	
	PRIMARY KEY (email),
	FOREIGN KEY (owner_id) REFERENCES OWNER(owner_id)
		ON DELETE CASCADE
		ON UPDATE RESTRICT
)
CHARACTER SET 'utf8mb4'
COLLATE 'utf8mb4_unicode_520_ci';

CREATE TABLE TASK (
	name VARCHAR(50) NOT NULL,
	owner_id CHAR(9),
	description VARCHAR(100),
	
	PRIMARY KEY (name),
	FOREIGN KEY (owner_id) REFERENCES OWNER(owner_id)
		ON DELETE CASCADE
		ON UPDATE RESTRICT
)
CHARACTER SET 'utf8mb4'
COLLATE 'utf8mb4_unicode_520_ci'; 

CREATE TABLE OWNERS_ITEMS
(
	owner_id CHAR(9) NOT NULL,
	item_id CHAR(9) NOT NULL,
	quantity VARCHAR(3),
	
	PRIMARY KEY (owner_id, item_id),
	FOREIGN KEY (owner_id) REFERENCES OWNER(owner_id)
		ON DELETE CASCADE
		ON UPDATE RESTRICT,
	FOREIGN KEY (item_id) REFERENCES ITEM(item_id)
		ON DELETE CASCADE
		ON UPDATE RESTRICT
)
CHARACTER SET 'utf8mb4'
COLLATE 'utf8mb4_unicode_520_ci'; 

CREATE TABLE USER_BORROW_TOOLS (
	uemail VARCHAR(50) NOT NULL,
	item_id CHAR(9) NOT NULL,
	
	PRIMARY KEY (uemail,item_id)
)
CHARACTER SET 'utf8mb4'
COLLATE 'utf8mb4_unicode_520_ci';

# Insert Data
INSERT INTO OWNER(owner_id) VALUES
	('333333333'),
	('123456789'),
	('555555555'),
	('888888888');

INSERT INTO USER(email, owner_id, fname, mname, lname) VALUES
	('JJ@gmail.com', '555555555', 'John', 'Max', 'Johnson'),
	('abc@gmail.com', '123456789', 'Adam', 'Phillip', 'Jefferson');

INSERT INTO TASK(name, owner_id, description) VALUES
	('Clean Hair', '888888888', 'When I take a shower I want to use shampoo to clean my hair'),
	('Clean Hands', '333333333', 'After I use the bathroom I want to clean my hands with hand soap');

INSERT INTO ITEM(item_id, name, description, type_flag) VALUES
	('101010101', 'Shampoo', 'Used to clean hair', 'A'),
	('224455660', 'Hand Soap', 'Used to clean hands', 'A');
	
# Function
DELIMITER $$
CREATE FUNCTION totalItems(owner_id INT)
RETURNS INT
BEGIN
    DECLARE numItems INT;
    SELECT count(*) INTO numItems
    FROM OWNERS_ITEMS O
    WHERE O.owner_id = owner_id;
    RETURN numItems;
END; $$
DELIMITER ;
