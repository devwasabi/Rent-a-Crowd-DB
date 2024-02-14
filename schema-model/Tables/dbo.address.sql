CREATE TABLE [dbo].[Address](
	addressId int IDENTITY(1,1) NOT NULL,
	streetNumber INT NOT NULL,
	streetName VARCHAR(100) NOT NULL,
	suburb VARCHAR(100) NOT NULL,
	city VARCHAR(50) NOT NULL,
	zipCode VARCHAR(4) NOT NUll,
);
GO

ALTER TABLE [dbo].[Address]
    ADD CONSTRAINT PK_Address PRIMARY KEY(addressId);
GO

-- Add the Check Constraint for the City
ALTER TABLE [dbo].[Address]
ADD CONSTRAINT CK_City CHECK (UPPER(city) = 'JHB'); -- Case-insensitive check for city JHB

GO



