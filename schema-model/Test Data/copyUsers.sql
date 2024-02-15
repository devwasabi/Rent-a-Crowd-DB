
USE [RentACrowd];
BEGIN TRANSACTION;
DECLARE @counter INT = 1;

-- Loop through the first 50 users in the UserInfo table
WHILE @counter <= 50
BEGIN
    -- Get the userId from the UserInfo table
    DECLARE @email NVARCHAR(255)

    SELECT @email = email
    FROM (
        SELECT email, ROW_NUMBER() OVER (ORDER BY userId) AS row_num
        FROM UserInfo
    ) AS UserInfoWithRowNumber
    WHERE row_num = @counter;

    -- Call the createCrowdMember procedure with userId
    EXEC InsertCrowdMemberProcedure @email;

    SET @counter = @counter + 1;
END;

-- Rollback the transaction to undo the changes
ROLLBACK TRANSACTION;
