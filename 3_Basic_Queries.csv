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
SELECT S.Name, A.Status
FROM Studentss S
JOIN Applications A ON S.StudentID = A.StudentID
WHERE A.Status = 'Selected';
