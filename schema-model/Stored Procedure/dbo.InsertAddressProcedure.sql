CREATE PROCEDURE InsertAddressProcedure (
    @StreetNo INT,
    @StreetName VARCHAR(100),
    @Suburb VARCHAR(100),
    @City VARCHAR(50),
    @PostalCode VARCHAR(4),
    @UserID INT  -- This will be the foreign key referencing UserInfo table
)
AS
BEGIN
    INSERT INTO Address (StreetNo, StreetName, Suburb, City, PostalCode, UserID)
    VALUES (@StreetNo, @StreetName, @Suburb, @City, @PostalCode,  @UserID);

	-- Update isActive column in UserInfo table
    UPDATE UserInfo
    SET isActive = 1  
    WHERE userId = @UserID;
END;
