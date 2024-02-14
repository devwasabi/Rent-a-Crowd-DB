CREATE FUNCTION dbo.ValidateEmailAddress (
    @EmailAddress VARCHAR(255)
)
RETURNS BIT
AS
BEGIN
    DECLARE @IsValid BIT = 0;

    IF @EmailAddress LIKE '%@%.%' -- Check if it contains '@' and '.'
        AND CHARINDEX('@', @EmailAddress) > 1 -- '@' cannot be the first character
        AND LEN(@EmailAddress) - LEN(REPLACE(@EmailAddress, '@', '')) = 1 -- Only one '@' allowed
        AND LEN(@EmailAddress) - LEN(REPLACE(@EmailAddress, '.', '')) >= 1 -- At least one '.' required
    BEGIN
        SET @IsValid = 1;
    END

    RETURN @IsValid;
END;