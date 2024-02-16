-- Ensure you're in the master DB
USE [master];
GO

CREATE DATABASE [RentACrowd];

-- Create all the server level logins here

CREATE LOGIN [user] WITH PASSWORD = 'password';
GO

-- Switch to the new DB and make all the DB specific users, and grant them permissions to 
-- use procedures.

USE [RentACrowd];
GO

-- Use this block as a template for each user
CREATE USER [user] FOR LOGIN [user];
GO
ALTER ROLE db_datareader ADD MEMBER [user]
GO
ALTER ROLE db_datawriter ADD MEMBER [user]
GO
GRANT EXEC TO [user];
GO
--