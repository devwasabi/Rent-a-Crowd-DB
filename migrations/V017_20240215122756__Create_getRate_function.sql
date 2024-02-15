CREATE FUNCTION dbo.getRate()
RETURNS INT
AS
BEGIN
    DECLARE @Rate INT;

    -- Attempt to retrieve the rate value
    SELECT TOP 1 @Rate = rate
    FROM Rates
    ORDER BY startDate DESC;

    -- Check if no rate record is found
    IF @Rate IS NULL
    BEGIN

        SET @Rate = 0.5; -- Default value
    END

    RETURN @Rate;
END;