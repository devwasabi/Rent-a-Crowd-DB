DECLARE @NewUserID INT;
EXEC InsertUserInfoProcedure 'Vutlhari', 'Mashimbyi', 'M', '1990-05-15','vutlhari@bbd.com', @NewUserID OUTPUT;

SELECT @NewUserID AS NewUserID;  -- Display the output value

-- Now, use @NewUserID as the foreign key while inserting address
EXEC InsertAddressProcedure 156, 'End street', 'Rosebank', 'JHB', '1234', @NewUserID;
