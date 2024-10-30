DROP DATABASE IF EXISTS school;
CREATE DATABASE school;
GRANT ALL PRIVILEGES ON school.* TO 'django'@'localhost' WITH GRANT OPTION;

USE school;
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100)
);

CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(100)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    teacher_id INT,
    credits INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    UNIQUE (student_id, course_id)
);

INSERT INTO Students (student_id, first_name, last_name, date_of_birth, email) VALUES
(1, 'Alice', 'Johnson', '2003-04-12', 'alice.johnson@example.com'),
(2, 'Bob', 'Smith', '2002-06-24', 'bob.smith@example.com'),
(3, 'Charlie', 'Brown', '2001-09-15', 'charlie.brown@example.com'),
(4, 'Diana', 'White', '2004-11-07', 'diana.white@example.com'),
(5, 'Eve', 'Walker', '2003-05-15', 'eve.walker@example.com'),
(6, 'Frank', 'Harris', '2002-10-19', 'frank.harris@example.com'),
(7, 'Grace', 'Lee', '2003-03-30', 'grace.lee@example.com'),
(8, 'Henry', 'Martinez', '2004-07-11', 'henry.martinez@example.com'),
(9, 'Ivy', 'Garcia', '2001-12-01', 'ivy.garcia@example.com'),
(10, 'Jack', 'Anderson', '2003-08-21', 'jack.anderson@example.com'),
(11, 'Henry', 'Yrneh', '2002-05-31', 'henry.yrneh@example.com');


INSERT INTO Teachers (teacher_id, first_name, last_name, department) VALUES
(1, 'John', 'Williams', 'Mathematics'),
(2, 'Emily', 'Davis', 'Physics'),
(3, 'Michael', 'Taylor', 'Computer Science'),
(4, 'Sarah', 'Wilson', 'Chemistry'),
(5, 'James', 'Thomas', 'Biology'),
(6, 'Laura', 'Roberts', 'History'),
(7, 'Ethan', 'Shafer', 'Computer Science');


INSERT INTO Courses (course_id, course_name, teacher_id, credits) VALUES
(1, 'Calculus', 1, 4),
(2, 'Physics 101', 2, 3),
(3, 'Introduction to Programming', 3, 3),
(4, 'Data Structures', 3, 4),
(5, 'Organic Chemistry', 4, 4),
(6, 'Biology 101', 5, 3),
(7, 'World History', 6, 3),
(8, 'Advanced Calculus', 1, 4),
(9, 'Physics 201', 2, 4),
(10, 'Algorithms', 3, 3),
(11, 'Database Systems', 7, 3);


INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date) VALUES
(1, 1, 1, '2023-09-01'), -- Alice enrolled in Calculus
(2, 1, 3, '2023-09-01'), -- Alice enrolled in Introduction to Programming
(3, 2, 2, '2023-09-02'), -- Bob enrolled in Physics 101
(4, 2, 3, '2023-09-02'), -- Bob enrolled in Introduction to Programming
(5, 3, 1, '2023-09-03'), -- Charlie enrolled in Calculus
(6, 3, 4, '2023-09-03'), -- Charlie enrolled in Data Structures
(7, 4, 2, '2023-09-04'), -- Diana enrolled in Physics 101
(8, 4, 4, '2023-09-04'), -- Diana enrolled in Data Structures
(9, 5, 5, '2023-09-05'), -- Eve enrolled in Organic Chemistry
(10, 5, 7, '2023-09-05'), -- Eve enrolled in World History
(11, 6, 1, '2023-09-06'), -- Frank enrolled in Calculus
(12, 6, 9, '2023-09-06'), -- Frank enrolled in Physics 201
(13, 7, 3, '2023-09-07'), -- Grace enrolled in Introduction to Programming
(14, 7, 10, '2023-09-07'), -- Grace enrolled in Algorithms
(15, 8, 4, '2023-09-08'), -- Henry enrolled in Data Structures
(16, 8, 7, '2023-09-08'), -- Henry enrolled in World History
(17, 9, 6, '2023-09-09'), -- Ivy enrolled in Biology 101
(18, 9, 8, '2023-09-09'), -- Ivy enrolled in Advanced Calculus
(19, 10, 2, '2023-09-10'), -- Jack enrolled in Physics 101
(20, 10, 5, '2023-09-10'); -- Jack enrolled in Organic Chemistry
