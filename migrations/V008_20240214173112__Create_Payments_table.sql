CREATE TABLE [dbo].[Payments](
	paymentId INT IDENTITY(1,1) NOT NULL,
	eventId INT NOT NULL,
	totalPaid INT NOT NULL,
	createdAt DATETIME2 DEFAULT GETDATE(), 
);
GO
-- Add Foreign Key Constraint for eventId
ALTER TABLE [dbo].[Payments]
	ADD CONSTRAINT FK_Payments_Events FOREIGN KEY (eventId) 
	REFERENCES Events(eventId) ON DELETE CASCADE;
GO

-- Add Primary Key Constraint for paymentId
ALTER TABLE [dbo].[Payments]
ADD CONSTRAINT PK_Payments PRIMARY KEY (paymentId);
GO