CREATE PROCEDURE InsertEventProcedure (
    @Email VARCHAR(255),
    @CrowdQuantity INT,
    --@GenderSpec CHAR,
    @EventDateTime DATETIME
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Payable INT, @UserId INT, @AddressId INT, @Rate INT, @isActive BIT

    -- Validate Crowd Quantity
    IF @CrowdQuantity > 10
    BEGIN
        RAISERROR('Crowd quantity cannot exceed 10', 16, 1);
        RETURN;
    END
	IF @EventDateTime <= GETDATE()
	BEGIN
        RAISERROR('Date cannot be in the past', 16, 1);
        RETURN;
    END
    -- Retrieve UserId and AddressId based on the provided email
    SELECT @UserId = userId, @AddressId = addressId, @isActive =isActive 
    FROM UserInfo 
    WHERE Email = @Email;

    IF @UserId IS NULL
    BEGIN
        RAISERROR('User with provided email does not exist', 16, 1);
        RETURN;
    END

	IF @isActive = 0
    BEGIN
        RAISERROR('User must be active to create an event', 16, 1);
        RETURN;
    END

    -- Retrieve the latest rate from the Rates table
    SELECT TOP 1 @Rate = rate 
    FROM Rates 
    ORDER BY rateId DESC;

    -- Calculate payable amount
    SET @Payable = @Rate * @CrowdQuantity;

    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Insert Event into table
        INSERT INTO Events (addressId, userId, crowdQuantity,  eventDateTime, payable,eventName,description)
        VALUES (@AddressId, @UserId, @CrowdQuantity,  @EventDateTime, @Payable,@EventName,@description);

        -- Commit the transaction
        COMMIT TRANSACTION;

        -- Display the record
        SELECT * FROM Events WHERE eventId = SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Handle the error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;