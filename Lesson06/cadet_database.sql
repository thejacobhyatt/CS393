DROP DATABASE IF EXISTS cadets;
CREATE DATABASE cadets;
USE cadets;

CREATE TABLE Cadet (
    cNum CHAR(10) PRIMARY KEY,
    firstName VARCHAR(255),
    lastName VARCHAR(255)
);

CREATE TABLE Enrollment (
    cNum CHAR(10),
    classNum CHAR(6),
    term CHAR(3),
    PRIMARY KEY (cNum, classNum, term)
);

INSERT INTO Cadet VALUES 
    ('123', 'John', 'Smith'),
    ('234', 'Mike', 'Jones'),
    ('345', 'James', 'Johnson'),
    ('456', 'Jane', 'Doe'),
    ('567', 'Janet', 'Jackson'),
    ('678', 'Janice', 'Hoffman');

INSERT INTO Enrollment VALUES
    ('123', 'CY305', '251'),
    ('123', 'CS393', '251'),
    ('123', 'CY394', '252'),
    ('234', 'CS393', '251'),
    ('456', 'CS393', '252')