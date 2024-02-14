CREATE PROCEDURE UpdateEventAddressProcedure (
    @EventId INT,
    @StreetNo INT,
    @StreetName VARCHAR(100),
    @Suburb VARCHAR(100),
    @City VARCHAR(50),
    @ZipCode VARCHAR(4)
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert into Address table
        INSERT INTO dbo.Address (StreetNumber, StreetName, Suburb, City, ZipCode)
        VALUES (@StreetNo, @StreetName, @Suburb, @City, @ZipCode);

        -- Get the newly inserted addressId
        DECLARE @NewAddressId INT = SCOPE_IDENTITY();

        -- Update addressId for the given event
        UPDATE Events
        SET addressId = @NewAddressId
        WHERE eventId = @EventId;

        -- Commit the transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;