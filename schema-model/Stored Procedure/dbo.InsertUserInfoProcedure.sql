CREATE PROCEDURE InsertUserInfoProcedure (
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @Gender CHAR,
    @DateOfBirth DATE,
	@Email VARCHAR(255),
    @UserID INT OUTPUT
)
AS
BEGIN
    -- Calculate age from DateOfBirth
    DECLARE @Age INT;
    SET @Age = DATEDIFF(YEAR, @DateOfBirth, GETDATE());

    -- Determine AgeGroup based on age
    DECLARE @AgeGroup VARCHAR(10);
    IF @Age < 13
        SET @AgeGroup = 'toddler';
    ELSE IF @Age BETWEEN 13 AND 17
        SET @AgeGroup = 'youth';
    ELSE
        SET @AgeGroup = 'adult';

    -- Insert UserInfo into table
    INSERT INTO UserInfo (FirstName, LastName, Gender, AgeGroup, DateOfBirth,Email)
    VALUES (@FirstName, @LastName, @Gender, @AgeGroup, @DateOfBirth,@Email);

    -- Get the last inserted identity value
    SET @UserID = SCOPE_IDENTITY();
END;
