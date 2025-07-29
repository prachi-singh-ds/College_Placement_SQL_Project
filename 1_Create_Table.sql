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
