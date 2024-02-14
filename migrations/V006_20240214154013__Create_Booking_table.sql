CREATE TABLE [dbo].[Bookings](
	bookingId INT IDENTITY(1,1) NOT NULL,
	eventId INT NOT NULL,
	crowdMemberId INT NOT NULL,
	--attended BIT DEFAULT 0,
	createdAt DATETIME2 DEFAULT GETDATE(), 
);
GO
-- Add Primary Key Constraint for bookingId
ALTER TABLE [dbo].[Bookings]
	ADD CONSTRAINT PK_Bookings PRIMARY KEY (bookingId);
Go

-- Add Foreign Key Constraint for eventId
ALTER TABLE [dbo].[Bookings]
	ADD CONSTRAINT FK_Bookings_Events FOREIGN KEY (eventId) 
	REFERENCES Events(eventId) ON DELETE CASCADE;
GO

-- Add Foreign Key Constraint for crowdMemberId
ALTER TABLE [dbo].[Bookings]
	ADD CONSTRAINT FK_Bookings_CrowdMembers_Users FOREIGN KEY (crowdMemberId) 
	REFERENCES UserInfo(userId) ON DELETE CASCADE;
GO