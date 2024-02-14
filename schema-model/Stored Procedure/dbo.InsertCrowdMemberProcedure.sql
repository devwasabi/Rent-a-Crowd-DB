CREATE PROCEDURE InsertCrowdMemberProcedure
    @Email VARCHAR(255)
AS
BEGIN
    DECLARE @AgeGroup VARCHAR(10);
    DECLARE @Rate INT;
    DECLARE @UserID INT;

    -- Get AgeGroup and UserID from UserInfo table based on the user's email
    SELECT @AgeGroup = ageGroup, @UserID = userId
    FROM UserInfo
    WHERE Email = @Email;

    -- Determine rate based on AgeGroup
    IF @AgeGroup = 'toddler'
        SET @Rate = 20;
    ELSE IF @AgeGroup = 'youth'
        SET @Rate = 30;
    ELSE IF @AgeGroup = 'adult'
        SET @Rate = 40;
    ELSE
        -- Handle cases where AgeGroup doesn't match any known value
        SET @Rate = 0; 

    -- Insert record into CrowdMembers table
    INSERT INTO CrowdMembers (userId, rate)
    VALUES (@UserID, @Rate);
END;
