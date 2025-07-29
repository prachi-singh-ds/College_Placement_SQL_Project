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



-- 5. Students who applied but didn’t appear in any interview

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