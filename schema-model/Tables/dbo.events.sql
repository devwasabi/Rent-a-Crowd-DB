CREATE TABLE [dbo].[Events](
    eventId int IDENTITY(1,1),
    crowdQuantity INT NOT NULL,
    userId INT NOT NULL,
    ageGroup VARCHAR(10) NOT NULL,
    genderSpec VARCHAR(6) NOT NULL,
    addressId INT NOT NULL, --by default this should be the user's address unless the user wants to host in a different location
    eventDate DATE NOT NULL,
    eventTime TIME NOT NULL,

);

ALTER TABLE [dbo].[Events]
ADD CONSTRAINT CK_Events_AgeGroup CHECK (ageGroup IN ('toddler', 'youth', 'adult','all'));

GO

ALTER TABLE [dbo].[Events]
ADD CONSTRAINT CK_Events_GenderSpec CHECK (genderSpec IN ('f', 'm','b'));

GO

-- Add Foreign Key Constraint for userId
ALTER TABLE [dbo].[Events]
	ADD CONSTRAINT FK_Events_UserInfo FOREIGN KEY (userId) 
	REFERENCES UserInfo(userId) ON DELETE NO ACTION; --we wanna keep the event should the user decides to delete their account 
GO

-- Add Foreign Key Constraint for addressId
ALTER TABLE [dbo].[Events]
	ADD CONSTRAINT FK_Events_Address FOREIGN KEY (addressId) 
	REFERENCES Address(addressId) ON DELETE NO ACTION;
GO

-- Add Primary Key Constraint for eventId
ALTER TABLE [dbo].[Events]
	ADD CONSTRAINT PK_Events PRIMARY KEY (eventId);
GO

ALTER TABLE [dbo].[Events]
ADD payable INT DEFAULT 0;
GO
