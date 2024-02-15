CREATE TABLE [dbo].[Events](
    eventId int IDENTITY(1,1),
	addressId INT NOT NULL, --by default this should be the user's address unless the user wants to host in a different location
	userId INT NOT NULL,
	eventName VARCHAR(255) NOT NULL,
	description VARCHAR(500) NOT NULL,
	crowdQuantity INT NOT NULL,
    --ageGroup VARCHAR(10) NOT NULL,
    genderSpec CHAR,
    eventDateTime DATETIME NOT NULL,
	payable INT DEFAULT 0,
	createdAt DATETIME2 DEFAULT GetDate()
);

ALTER TABLE [dbo].[Events]
ADD CONSTRAINT CK_Events_GenderSpec CHECK (genderSpec IN ('f', 'm','b'));
GO

-- Add Foreign Key Constraint for userId
ALTER TABLE [dbo].[Events]
	ADD CONSTRAINT FK_Events_UserInfo FOREIGN KEY (userId) 
	REFERENCES UserInfo(userId) ON DELETE NO ACTION;
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
