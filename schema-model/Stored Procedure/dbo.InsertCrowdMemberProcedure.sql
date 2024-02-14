CREATE PROCEDURE InsertCrowdMemberProcedure
    @Email VARCHAR(255)
AS
BEGIN

    DECLARE @UserID INT;

    -- UserID from UserInfo table based on the user's email
    SELECT @UserID = userId
    FROM UserInfo
    WHERE Email = @Email;

    -- Insert record into CrowdMembers table
    INSERT INTO CrowdMembers (userId)
    VALUES (@UserID);
END;
