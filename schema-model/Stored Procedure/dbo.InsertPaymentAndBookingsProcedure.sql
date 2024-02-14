CREATE PROCEDURE InsertPaymentAndBookingsProcedure (
    @EventId INT,
    @TotalPaid INT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @PayableAmount INT, @CrowdQuantity INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Get Payable Amount and Crowd Quantity for the event
        SELECT @PayableAmount = payable, @CrowdQuantity = crowdQuantity
        FROM Events
        WHERE eventId = @EventId;

        -- Check if the total paid amount matches the payable amount
        IF @TotalPaid <> @PayableAmount
        BEGIN
            RAISERROR('Total paid amount does not match payable amount for the event.', 16, 1);
            RETURN;
        END

        -- Insert into Payments table
        INSERT INTO Payments (eventId, totalPaid)
        VALUES (@EventId, @TotalPaid);

        -- Assign Crowd Members
        DECLARE @AssignedCrowdMembers INT = 0;

        WHILE @AssignedCrowdMembers < @CrowdQuantity
        BEGIN
            DECLARE @NextCrowdMemberId INT;

            -- Get the next available crowd member who hasn't booked on the day of the event
            SELECT TOP 1 @NextCrowdMemberId = userId
            FROM CrowdMembers
            WHERE userId NOT IN (
                SELECT crowdMemberId
                FROM Bookings b
                INNER JOIN Events e ON b.eventId = e.eventId
                WHERE CONVERT(DATE, e.eventDateTime) = CONVERT(DATE, GETDATE()) -- Match the event date
            )
            ORDER BY NEWID();-- Randomize the selection of crowd members

            -- Check if we found a valid crowd member
            IF @NextCrowdMemberId IS NOT NULL
            BEGIN
                -- Insert the booking for the crowd member
                INSERT INTO Bookings (eventId, crowdMemberId)
                VALUES (@EventId, @NextCrowdMemberId);

                SET @AssignedCrowdMembers += 1;
            END
            ELSE
            BEGIN
                -- No more available crowd members to assign
                BREAK;
            END
        END

        -- Commit the transaction
        COMMIT TRANSACTION;
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
