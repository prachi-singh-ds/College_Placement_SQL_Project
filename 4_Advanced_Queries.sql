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

