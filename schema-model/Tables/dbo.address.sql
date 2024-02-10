CREATE TABLE [dbo].[Address](
	addressId int IDENTITY(1,1) NOT NULL,
	streetNo INT NOT NULL,
	streetName VARCHAR(100) NOT NULL,
	suburb VARCHAR(100) NOT NULL,
	city VARCHAR(50) NOT NULL,
	postalCode VARCHAR(4) NOT NUll,
	isEventAddress BIT DEFAULT 0,
	userId INT, 
	
);
GO

ALTER TABLE [dbo].[Address]
    ADD CONSTRAINT PK_Address PRIMARY KEY(addressId);
GO
-- Add the Foreign Key Constraint
ALTER TABLE [dbo].[Address]
	ADD CONSTRAINT FK_Address_UserInfo FOREIGN KEY (userId) REFERENCES UserInfo(userId) ON DELETE CASCADE; 

-- Add the Check Constraint for the City
ALTER TABLE [dbo].[Address]
ADD CONSTRAINT CK_City CHECK (UPPER(city) = 'JHB'); -- Case-insensitive check for city JHB

GO



