CREATE FUNCTION dbo.getCommission()
RETURNS FLOAT
AS
BEGIN
    DECLARE @Commission FLOAT;

    -- Attempt to retrieve the commission value
    SELECT TOP 1 @Commission = commission
    FROM Commissions
    ORDER BY startDate DESC;

    -- Check if no commission record is found
    IF @Commission IS NULL
    BEGIN

        SET @Commission = 0.5; -- Default value
    END

    RETURN @Commission;
END;