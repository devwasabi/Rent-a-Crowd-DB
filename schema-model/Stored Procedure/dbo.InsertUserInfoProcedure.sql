CREATE PROCEDURE InsertUserInfoProcedure (
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @Gender CHAR,
    @DateOfBirth DATE,
    @Email VARCHAR(255),
    @Phone VARCHAR(10)
)
AS
BEGIN
    SET NOCOUNT ON;

	-- Validate the email address
    IF dbo.ValidateEmailAddress(@Email) = 0
    BEGIN
        RAISERROR('Invalid email address', 16, 1);
        RETURN;
    END

    -- Validate the phone number
    IF dbo.ValidatePhoneNumber(@Phone) = 0
    BEGIN
        RAISERROR('Invalid phone number', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Insert UserInfo into table
        INSERT INTO UserInfo (FirstName, LastName, Gender, DateOfBirth, Email, phone)
        VALUES (@FirstName, @LastName, @Gender, @DateOfBirth, @Email, @Phone);

        -- Commit the transaction
        COMMIT TRANSACTION;

        -- Display the record
        SELECT * FROM UserInfo WHERE userId = SCOPE_IDENTITY();
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
