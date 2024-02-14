CREATE TABLE [dbo].[Rates](
	rateId INT IDENTITY(1,1) PRIMARY KEY,
	rate INT NOT NULL,
	startDate DATE NOT NULL,
	endDate DATE
);