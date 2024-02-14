CREATE FUNCTION dbo.ValidatePhoneNumber (
    @PhoneNumber VARCHAR(10)
)
RETURNS BIT
AS
BEGIN
    DECLARE @IsValid BIT = 0;

    IF @PhoneNumber LIKE '0[6-8][0-9]{8}'
        SET @IsValid = 1;

    RETURN @IsValid;
END;
