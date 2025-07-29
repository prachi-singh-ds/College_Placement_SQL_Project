                --Students--
	CREATE TABLE Studentss (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Branch VARCHAR(20),
    CGPA DECIMAL(3,2),
    GraduationYear INT
);

                --Companies--
    CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(50),
    Industry VARCHAR(30),
    OfferedRole VARCHAR(40),
    Package DECIMAL(6,2)
);

                --Applications--
    CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    StudentID INT,
    CompanyID INT,
    Status VARCHAR(20),  -- Selected, Rejected, Waiting
    FOREIGN KEY (StudentID) REFERENCES Studentss(StudentID),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

                --Interviews--
    CREATE TABLE Interviews (
    InterviewID INT PRIMARY KEY,
    StudentID INT,
    CompanyID INT,
    Round INT,
    InterviewDate DATE,
    InterviewStatus VARCHAR(20), -- Cleared, Rejected
    FOREIGN KEY (StudentID) REFERENCES Studentss(StudentID),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);


                  --Students--
           INSERT INTO Studentss VALUES
(1,  'Anjali Sharma',   'CSE',   8.5,   2024),
(2,  'Rahul  Mehta',    'ECE',   7.8,   2024),
(3,  'Sneha  Jain',     'IT',    9.1,   2024),
(4,  'Ravi   Kumar',    'ME',    6.9,   2024),
(5,  'Priya  Singh',    'CSE',   8.9,   2024);


                  --Companies--
            INSERT INTO Companies VALUES
(101,  'Infosys',   'IT',          'System Engineer',    6.5),
(102,  'Google',    'Tech',        'SDE',                30),
(103,  'TCS',       'IT',          'Analyst',            5),
(104,  'Amazon',    'E-Commerce',  'Data Engineer',      25),
(105,  'BYJU�S',    'EdTech',      'Sales Associate',    10);


                 --Applications--
             INSERT INTO Applications VALUES
(201,   1,   102,   'Selected'),
(202,   2,   101,   'Rejected'),
(203,   3,   104,   'Selected'),
(204,   4,   103,   'Waiting'),
(205,   5,   105,   'Rejected');


                 --Interviews--
              INSERT INTO Interviews VALUES
(301,   1,   102,   1,   '2024-02-10',   'Cleared'),
(302,   1,   102,   2,   '2024-02-15',   'Cleared'),
(303,   2,   101,   1,   '2024-01-20',   'Rejected'),
(304,   3,   104,   1,   '2024-03-05',   'Cleared'),
(305,   3,   104,   2,   '2024-03-10',   'Cleared');



                   --Basic Queries--


-- 1. List all students from CSE branch
SELECT * FROM Studentss WHERE Branch = 'CSE';


-- 2. List students with CGPA > 8
SELECT * FROM Studentss WHERE CGPA > 8;


-- 3. Show all companies offering > 10 LPA
SELECT * FROM Companies WHERE Package > 10;


-- 4. Count of students per branch
SELECT Branch, COUNT(*) AS StudentCount  FROM Studentss  GROUP BY Branch;


-- 5. Show selected students only
SELECT S.Name, A.Status  FROM Studentss S   JOIN Applications A ON S.StudentID = A.StudentID   WHERE A.Status = 'Selected';



                     --Advanced Queries--


				  -- 1. Branch-wise average CGPA

SELECT Branch, AVG(CGPA) AS Avg_CGPA  FROM Studentss  GROUP BY Branch;



-- 2. Company-wise number of applications

SELECT C.CompanyName, COUNT(A.ApplicationID) AS TotalApplications  FROM Companies C
JOIN Applications A ON C.CompanyID = A.CompanyID
GROUP BY C.CompanyName;



-- 3. Student-wise highest offered package (based on selected applications)

SELECT S.Name, MAX(C.Package) AS MaxPackage  FROM Studentss S
JOIN Applications A ON S.StudentID = A.StudentID
JOIN Companies C ON A.CompanyID = C.CompanyID
WHERE A.Status = 'Selected'  GROUP BY S.Name;



-- 4. Unplaced students (no 'Selected' application)

SELECT S.Name  FROM Studentss S  WHERE S.StudentID NOT IN (
    SELECT StudentID FROM Applications WHERE Status = 'Selected'
);


-- 5. Top 3 highest packages offered

SELECT TOP 3 CompanyName, Package  FROM Companies
ORDER BY Package DESC;



-- 6. Company with most interviews held

SELECT C.CompanyName, COUNT(I.InterviewID) AS TotalInterviews  FROM Companies C
JOIN Interviews I ON C.CompanyID = I.CompanyID
GROUP BY C.CompanyName
ORDER BY TotalInterviews DESC;



-- 7. Students who cleared all interview rounds of a company

SELECT DISTINCT S.Name  FROM Studentss S
JOIN Interviews I ON S.StudentID = I.StudentID
WHERE InterviewStatus = 'Cleared'
AND NOT EXISTS (
    SELECT 1
    FROM Interviews I2
    WHERE I2.StudentID = S.StudentID AND I2.InterviewStatus = 'Rejected'
);


-- 8. Branch-wise placement percentage

SELECT S.Branch,
       COUNT(CASE WHEN A.Status = 'Selected' THEN 1 END) * 100.0 / COUNT(*) AS Placement_Percentage
FROM Studentss S
JOIN Applications A ON S.StudentID = A.StudentID
GROUP BY S.Branch;


-- 9. Number of companies per industry

SELECT Industry, COUNT(*) AS TotalCompanies  FROM Companies
GROUP BY Industry;


-- 10. Interviews held in February 2024

SELECT * FROM Interviews
WHERE MONTH(InterviewDate) = 2 AND YEAR(InterviewDate) = 2024;



                      --Pro Level Queries--


					  -- 1. Average rounds cleared per student

SELECT StudentID, AVG(Round) AS AvgRoundsCleared  FROM Interviews
WHERE InterviewStatus = 'Cleared'
GROUP BY StudentID;


-- 2. Students rejected in final round

SELECT DISTINCT S.Name  FROM Studentss S
JOIN Interviews I ON S.StudentID = I.StudentID
WHERE I.InterviewStatus = 'Rejected'
AND I.Round = (
    SELECT MAX(Round)
    FROM Interviews I2
    WHERE I2.StudentID = S.StudentID AND I2.CompanyID = I.CompanyID
);



-- 3. Student who appeared for most interviews

SELECT TOP 1 S.Name, COUNT(I.InterviewID) AS TotalInterviews  FROM Studentss S
JOIN Interviews I ON S.StudentID = I.StudentID
GROUP BY S.Name
ORDER BY TotalInterviews DESC;



-- 4. Most offered role by companies

SELECT OfferedRole, COUNT(*) AS TimesOffered  FROM Companies
GROUP BY OfferedRole
ORDER BY TimesOffered DESC;



-- 5. Students who applied but didn�t appear in any interview

SELECT S.Name FROM Studentss S  WHERE S.StudentID IN (
    SELECT A.StudentID FROM Applications A
)
AND S.StudentID NOT IN (
    SELECT I.StudentID FROM Interviews I
);



-- 6. Company with lowest selection rate

SELECT TOP 1 C.CompanyName,
       SUM(CASE WHEN A.Status = 'Selected' THEN 1 ELSE 0 END)*100.0 / COUNT(*) AS SelectionRate
FROM Companies C
JOIN Applications A ON C.CompanyID = A.CompanyID
GROUP BY C.CompanyName
ORDER BY SelectionRate ASC;



-- 7. Interview success ratio (cleared vs total rounds per student)

SELECT StudentID,
       COUNT(CASE WHEN InterviewStatus = 'Cleared' THEN 1 END)*100.0 / COUNT(*) AS SuccessRatio
FROM Interviews
GROUP BY StudentID;



-- 8. Students having multiple offers

SELECT S.Name, COUNT(*) AS TotalOffers  FROM Studentss S
JOIN Applications A ON S.StudentID = A.StudentID
WHERE A.Status = 'Selected'
GROUP BY S.Name
HAVING COUNT(*) > 1;



-- 9. Industry-wise average package

SELECT Industry, AVG(Package) AS AvgPackage
FROM Companies
GROUP BY Industry;



-- 10. Rank companies by highest package

SELECT CompanyName, Package,
       RANK() OVER (ORDER BY Package DESC) AS PackageRank
FROM Companies;
