CREATE TABLE [dbo].[Commissions](
	commissionId INT IDENTITY(1,1) PRIMARY KEY,
	commission float NOT NULL,
	startDate DATE NOT NULL,
	endDate DATE
);