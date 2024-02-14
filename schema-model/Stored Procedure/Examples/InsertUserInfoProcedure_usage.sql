/*
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @Gender CHAR,
    @DateOfBirth DATE,
    @Email VARCHAR(255),
    @Phone VARCHAR(10)
*/



--EXEC InsertUserInfoProcedure 'Vutlhari', 'Mashimbyi', 'M', '1990-05-15','vutlhari@bbd.com','0723230358';

EXEC InsertUserInfoProcedure 'John', 'Doe', 'M', '1985-08-21', 'john.doe@example.com', '0721234567';
EXEC InsertUserInfoProcedure 'Jane', 'Smith', 'F', '1992-03-14', 'jane.smith@example.com', '0722345678';
EXEC InsertUserInfoProcedure 'Michael', 'Johnson', 'M', '1979-11-30', 'michael.johnson@example.com', '0723456789';
EXEC InsertUserInfoProcedure 'Emily', 'Brown', 'F', '1988-07-03', 'emily.brown@example.com', '0724567890';
EXEC InsertUserInfoProcedure 'David', 'Taylor', 'M', '1995-01-19', 'david.taylor@example.com', '0725678901';
EXEC InsertUserInfoProcedure 'Sarah', 'Clark', 'F', '1980-09-25', 'sarah.clark@example.com', '0726789012';
EXEC InsertUserInfoProcedure 'James', 'Lee', 'M', '1983-06-12', 'james.lee@example.com', '0727890123';
EXEC InsertUserInfoProcedure 'Jessica', 'Martinez', 'F', '1990-04-08', 'jessica.martinez@example.com', '0728901234';
EXEC InsertUserInfoProcedure 'Daniel', 'Anderson', 'M', '1987-02-17', 'daniel.anderson@example.com', '0729012345';
EXEC InsertUserInfoProcedure 'Sophia', 'Hernandez', 'F', '1998-10-05', 'sophia.hernandez@example.com', '0720123456';



--Insert to Address table

/*
CREATE PROCEDURE InsertAddressProcedure (
    @userID INT,
    @StreetNo INT,
    @StreetName VARCHAR(100),
    @Suburb VARCHAR(100),
    @City VARCHAR(50),
    @ZipCode VARCHAR(4)
)*/


--EXEC InsertAddressProcedure 10,156, 'End street', 'Rosebank', 'JHB', '1234';
/*
EXEC InsertAddressProcedure 11,156, 'End street', 'Rosebank', 'JHB', '1234';
EXEC InsertAddressProcedure 12,156, 'End street', 'Rosebank', 'JHB', '1234';
EXEC InsertAddressProcedure 13,156, 'End street', 'Rosebank', 'JHB', '1234';
EXEC InsertAddressProcedure 14,156, 'End street', 'Rosebank', 'JHB', '1234';
EXEC InsertAddressProcedure 15,156, 'End street', 'Rosebank', 'JHB', '1234';
EXEC InsertAddressProcedure 16,156, 'End street', 'Rosebank', 'JHB', '1234';
EXEC InsertAddressProcedure 17,156, 'End street', 'Rosebank', 'JHB', '1234';
EXEC InsertAddressProcedure 18,156, 'End street', 'Rosebank', 'JHB', '1234';
EXEC InsertAddressProcedure 19,156, 'End street', 'Rosebank', 'JHB', '1234';
EXEC InsertAddressProcedure 20,156, 'End street', 'Rosebank', 'JHB', '1234';
*/
SELECT * FROM UserInfo u 
INNER JOIN Address a 
ON a.addressId = u.addressId;



--add users to crowd members table
/*
INSERT INTO CrowdMembers(userId)
SELECT userId
FROM UserInfo;

DELETE FROM CrowdMembers WHERE userId = 10;
*/


SELECT * FROM CrowdMembers c 
INNER JOIN UserInfo u 
ON u.userId = c.userId;


--Insert to crod members procedure
/*
CREATE PROCEDURE InsertCrowdMemberProcedure
    @Email VARCHAR(255)
AS
*/
EXEC InsertCrowdMemberProcedure 'sophia.hernandez@example.com';