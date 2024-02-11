CREATE PROCEDURE InsertEventProcedure
    @Email VARCHAR(255),
    @CrowdQuantity INT,
    @AgeGroup VARCHAR(10),
    @GenderSpec VARCHAR(6),
    @EventDate DATE,
    @EventTime TIME
AS
BEGIN
    DECLARE @UserID INT;
    DECLARE @AddressID INT;
    DECLARE @Payable INT;
	DECLARE @EventID INT;

    -- Get UserID from UserInfo table based on the user's email
    SELECT @UserID = userId
    FROM UserInfo
    WHERE Email = @Email;

    -- Get AddressID from Address table based on the user's UserID
    SELECT @AddressID = addressId
    FROM Address
    WHERE userId = @UserID;

    -- Determine the rate based on the age group
    IF @AgeGroup = 'toddler'
        SET @Payable = 20 * @CrowdQuantity;
    ELSE IF @AgeGroup = 'youth'
        SET @Payable = 30 * @CrowdQuantity;
    ELSE IF @AgeGroup = 'adult' OR @AgeGroup = 'all'
        SET @Payable = 40 * @CrowdQuantity;

    -- Check if the event date is in the future
    IF @EventDate < GETDATE()
    BEGIN
        -- Event date has passed, do not insert the event
        RAISERROR('Event date cannot be in the past.', 16, 1);
        RETURN;
    END;

    -- Insert record into Events table with the calculated payable amount
    INSERT INTO Events (crowdQuantity, userId, ageGroup, genderSpec, addressId, eventDate, eventTime, payable)
    VALUES (@CrowdQuantity, @UserID, @AgeGroup, @GenderSpec, @AddressID, @EventDate, @EventTime, @Payable);


	-- Get the ID of the newly inserted event
    SELECT @EventID = SCOPE_IDENTITY();

    -- Select all details of the inserted event
    SELECT * FROM Events WHERE eventId = @EventID;
END;
