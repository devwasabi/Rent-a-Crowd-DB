--DROP FUNCTION IF EXISTS ValidatePhoneNumber;


CREATE FUNCTION dbo.ValidatePhoneNumber (
    @PhoneNumber VARCHAR(10)
)
RETURNS BIT
AS
BEGIN
    DECLARE @IsValid BIT = 0;
  -- Check length is 10 digits
	IF @PhoneNumber LIKE '[0-0][6-8][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' AND LEN(@PhoneNumber) = 10
    BEGIN
	SET @IsValid = 1
	END

  RETURN @isValid;
END;
