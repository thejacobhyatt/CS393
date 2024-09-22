USE cadets;

ALTER TABLE Cadet
    MODIFY COLUMN Company ENUM('A', 'B', 'C', 'D', 'X');

INSERT INTO Cadet VALUES (999, 'unknown', 'unknown', 'X');

ALTER TABLE CadetAccount
    ADD FOREIGN KEY (owner) REFERENCES Cadet(cNum) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE;

ALTER TABLE Enrollment
    MODIFY COLUMN cNum CHAR(10) DEFAULT 999,
    ADD FOREIGN KEY (cNum) REFERENCES Cadet(cNum) 
        ON DELETE SET DEFAULT
        ON UPDATE RESTRICT;