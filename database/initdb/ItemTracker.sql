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

CREATE TABLE OWNERS_ITEMS (
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
    borrower_email VARCHAR(50) NOT NULL,
    owner_email VARCHAR(50) NOT NULL,
    item_id CHAR(9) NOT NULL,
    quantity VARCHAR(3),
    
    PRIMARY KEY (borrower_email, item_id, owner_email),
    FOREIGN KEY (borrower_email) REFERENCES USER(email)
        ON DELETE CASCADE
        ON UPDATE RESTRICT,
    FOREIGN KEY (item_id) REFERENCES ITEM(item_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT,
    FOREIGN KEY (owner_email) REFERENCES USER(email)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
)
CHARACTER SET 'utf8mb4'
COLLATE 'utf8mb4_unicode_520_ci';

# Insert Data
INSERT INTO OWNER(owner_id) VALUES
    ('555555555'),
    ('123456789'),
    ('385027836'),
    ('429301834'),
    ('888888888'),
    ('333333333');

INSERT INTO USER(email, owner_id, fname, mname, lname) VALUES
    ('JJ@gmail.com', '555555555', 'John', 'Max', 'Johnson'),
    ('apj@gmail.com', '123456789', 'Adam', 'Phillip', 'Jefferson'),
    ('someguy@somerandomguy.com', '385027836', 'Some', 'Random', 'Guy'),
    ('betty@gmail.com', '429301834', 'Betty', 'W.', 'Crocker');

INSERT INTO TASK(name, owner_id, description) VALUES
    ('Clean Hair', '888888888', 'When I take a shower I want to use shampoo to clean my hair'),
    ('Clean Hands', '333333333', 'After I use the bathroom I want to clean my hands with hand soap');

INSERT INTO ITEM(item_id, name, description, type_flag) VALUES
    ('101010101', 'Shampoo', 'Used to clean hair', 'A'),
    ('224455660', 'Hand Soap', 'Used to clean hands', 'T'),
    ('112233445', 'Hammer', 'Used to hit nails', 'T'),
    ('332211442', 'Dishwasher', 'Used to clean dishes', 'A'),
    ('772847193', 'Dishes', 'Used to clean hands', 'T');

INSERT INTO OWNERS_ITEMS(owner_id, item_id, quantity) VALUES
    ('555555555', '332211442', '1'),
    ('555555555', '772847193', '1'),
    ('123456789', '101010101', '4'),
    ('385027836', '112233445', '2'),
    
    ('888888888', '101010101', '1'),
    ('333333333', '224455660', '2');
    
INSERT INTO USER_BORROW_TOOLS(borrower_email, owner_email, item_id, quantity) VALUES
    ('betty@gmail.com', 'someguy@somerandomguy.com', '112233445', '1'),
    ('apj@gmail.com', 'JJ@gmail.com', '224455660', '2'),
    ('betty@gmail.com', 'JJ@gmail.com', '332211442', '1');

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

# View
CREATE VIEW Borrowers AS
    SELECT DISTINCT fname, lname
    FROM USER
    INNER JOIN USER_BORROW_TOOLS ON USER.email = USER_BORROW_TOOLS.borrower_email;
