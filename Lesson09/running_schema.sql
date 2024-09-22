DROP DATABASE IF EXISTS running;
CREATE DATABASE running;
USE running;

-- Create User table
CREATE TABLE User (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BirthDate DATE,
    JoinDate DATE NOT NULL
);

-- Create Route table
CREATE TABLE Route (
    RouteID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    RouteName VARCHAR(100),
    StartLocation VARCHAR(100),
    EndLocation VARCHAR(100),
    Distance FLOAT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    CHECK (Distance > 0)
);

-- Create Run table
CREATE TABLE Run (
    RunID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    RunDate DATE NOT NULL,
    Route INT,
    Distance FLOAT,
    Duration TIME NOT NULL,
    CaloriesBurned FLOAT,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (Route) REFERENCES Route(RouteID),
    CHECK (Route IS NULL xor Distance IS NULL)
);

-- Create RunDetail table
CREATE TABLE RunDetail (
    RunDetailID INT AUTO_INCREMENT PRIMARY KEY,
    RunID INT NOT NULL,
    Timestamp DATETIME NOT NULL,
    Latitude DECIMAL(9, 6) NOT NULL,
    Longitude DECIMAL(9, 6) NOT NULL,
    HeartRate INT,
    FOREIGN KEY (RunID) REFERENCES Run(RunID)
);
