DROP DATABASE IF EXISTS cadets;
CREATE DATABASE cadets;
USE cadets;

CREATE TABLE Cadet (
    cNum CHAR(10) PRIMARY KEY,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    company ENUM ('A', 'B', 'C', 'D')
);

CREATE TABLE Enrollment (
    cNum CHAR(10),
    classNum CHAR(6),
    term CHAR(3),
    PRIMARY KEY (cNum, classNum, term)
);

CREATE TABLE CadetAccount (
    accountId INT PRIMARY KEY AUTO_INCREMENT,
    owner CHAR(10),
    balance DECIMAL(8, 2)
);

INSERT INTO Cadet VALUES 
    ('123', 'John', 'Smith', 'A'),
    ('234', 'Mike', 'Jones', 'B'),
    ('345', 'James', 'Johnson', 'A'),
    ('456', 'Jane', 'Doe', 'B'),
    ('567', 'Janet', 'Jackson', 'C'),
    ('678', 'Janice', 'Hoffman', 'C');

INSERT INTO Enrollment VALUES
    ('123', 'CY305', '251'),
    ('123', 'CS393', '251'),
    ('123', 'CY394', '252'),
    ('234', 'CS393', '251'),
    ('456', 'CS393', '252');

INSERT INTO CadetAccount (owner, balance) VALUES
    ('123', 100),
    ('123', 200),
    ('456', 500),
    ('678', 900);