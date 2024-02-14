CREATE TABLE [dbo].[CrowdMembers](
	crowdMemberId INT IDENTITY(1,1) NOT NULL,
	userId INT NOT NULL,
	--rate INT
);
GO

-- Add Primary Key Constraint for crowdMemberId
ALTER TABLE [dbo].[CrowdMembers]
	ADD CONSTRAINT PK_CrowdMembers PRIMARY KEY (crowdMemberId);
GO

-- Add Foreign Key Constraint for userId
ALTER TABLE [dbo].[CrowdMembers]
	ADD CONSTRAINT FK_CrowdMembers_UserInfo FOREIGN KEY (userId) 
	REFERENCES UserInfo(userId) ON DELETE CASCADE;
GO