-- ============================================================
-- Gayanganga Library - Database Creation Script
-- Run this in SQL Server Management Studio (SSMS) if you prefer
-- to create the database manually instead of using EF Core
-- migrations (dotnet ef database update).
-- ============================================================

IF DB_ID('GayangangaLibraryDb') IS NULL
BEGIN
    CREATE DATABASE GayangangaLibraryDb;
END
GO

USE GayangangaLibraryDb;
GO

IF OBJECT_ID('dbo.Students', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Students (
        Id              INT IDENTITY(1,1) PRIMARY KEY,
        SeatNo          INT NOT NULL,
        Name            NVARCHAR(150) NOT NULL,
        Phone           NVARCHAR(15) NOT NULL,
        Address         NVARCHAR(500) NOT NULL,
        PhotoPath       NVARCHAR(MAX) NULL,
        AadharPhotoPath NVARCHAR(MAX) NULL,
        Fees            DECIMAL(10,2) NOT NULL,
        Shift           INT NOT NULL,           -- 1=Morning, 2=Afternoon, 3=Evening, 4=FullDay
        CreatedOn       DATETIME2 NOT NULL DEFAULT GETDATE(),
        CONSTRAINT UQ_Students_SeatNo UNIQUE (SeatNo)
    );
END
GO

IF OBJECT_ID('dbo.Attendances', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Attendances (
        Id              INT IDENTITY(1,1) PRIMARY KEY,
        StudentId       INT NOT NULL,
        AttendanceDate  DATE NOT NULL,
        IsPresent       BIT NOT NULL,
        MarkedOn        DATETIME2 NOT NULL DEFAULT GETDATE(),
        CONSTRAINT FK_Attendances_Students FOREIGN KEY (StudentId)
            REFERENCES dbo.Students (Id) ON DELETE CASCADE,
        CONSTRAINT UQ_Attendances_Student_Date UNIQUE (StudentId, AttendanceDate)
    );
END
GO

-- Sample seed data (optional - matches the screenshot example)
IF NOT EXISTS (SELECT 1 FROM dbo.Students)
BEGIN
    INSERT INTO dbo.Students (SeatNo, Name, Phone, Address, Fees, Shift, CreatedOn)
    VALUES
    (1, N'Rahul Sharma', N'9876543210', N'123, MG Road, Kanpur, UP', 15000.00, 1, GETDATE()),
    (2, N'Anjali Verma', N'9123456780', N'45, Civil Lines, Kanpur, UP', 15000.00, 3, GETDATE()),
    (3, N'Vikash Yadav', N'9988776655', N'78, Govind Nagar, Kanpur, UP', 16000.00, 1, GETDATE()),
    (4, N'Neha Gupta', N'8765432109', N'22, Swaroop Nagar, Kanpur, UP', 15000.00, 3, GETDATE()),
    (5, N'Aman Singh', N'7894561230', N'15, Kidwai Nagar, Kanpur, UP', 17000.00, 1, GETDATE());
END
GO
    

	



	select * from AppSettings