CREATE PROCEDURE InsertEventProcedure (
    @Email VARCHAR(255),
    @CrowdQuantity INT,
    @GenderSpec CHAR,
    @EventDateTime DATETIME
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Payable INT, @UserId INT, @AddressId INT, @Rate INT;

    -- Validate Crowd Quantity
    IF @CrowdQuantity > 10
    BEGIN
        RAISERROR('Crowd quantity cannot exceed 10', 16, 1);
        RETURN;
    END

    -- Retrieve UserId and AddressId based on the provided email
    SELECT @UserId = userId, @AddressId = addressId 
    FROM UserInfo 
    WHERE Email = @Email;

    IF @UserId IS NULL
    BEGIN
        RAISERROR('User with provided email does not exist', 16, 1);
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
        INSERT INTO Events (addressId, userId, crowdQuantity, genderSpec, eventDateTime, payable)
        VALUES (@AddressId, @UserId, @CrowdQuantity, @GenderSpec, @EventDateTime, @Payable);

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
