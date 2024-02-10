CREATE TABLE [dbo].[UserInfo](
    userId int IDENTITY(1,1) NOT NULL,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    gender CHAR NOT NULL,
    ageGroup VARCHAR(10) NOT NULL,
    dateOfBirth DATE NOT NULL,
    createdAt DATETIME2 DEFAULT GETDATE(), 
    isActive BIT DEFAULT 0 
);
GO

ALTER TABLE [dbo].[UserInfo]
    ADD CONSTRAINT PK_UserInfo PRIMARY KEY(userId);
GO

ALTER TABLE [dbo].[UserInfo]
ADD CONSTRAINT CK_AgeGroup CHECK (ageGroup IN ('toddler', 'youth', 'adult'));

GO

ALTER TABLE [dbo].[UserInfo]
ADD CONSTRAINT CK_Gender CHECK (gender IN ('f', 'm'));

GO

