--INSERT INTO Rates (rate,startDate) VALUES (50,'2024-02-23');
--INSERT INTO Commissions (commission,startDate) VALUES (0.5,'2024-02-23')
/*
CREATE PROCEDURE InsertEventProcedure (
    @Email VARCHAR(255),
    @CrowdQuantity INT,
    @EventName VARCHAR(255),
	@description VARCHAR(500),
    @EventDateTime DATETIME
)

*/

EXEC InsertEventProcedure 'vutlhari@bbd.com', 5,'My 21st Party','Hello, Would like to invite you to my 21st birthday party. Dress code all black'  '2024-08-17 13:00:00';

--Insert Payments

/*
CREATE PROCEDURE InsertPaymentAndBookingsProcedure (
    @EventId INT,
    @TotalPaid INT
)
*/

EXEC InsertPaymentAndBookingsProcedure 7,250;

--Check bookings

SELECT * FROM Bookings WHERE eventId = 7 OR eventId = 6;

SELECT crowdMemberId,e.eventDateTime,e.eventId
                FROM Bookings b
                INNER JOIN Events e ON b.eventId = e.eventId
				WHERE CONVERT(DATE, e.eventDateTime) = CONVERT(DATE, '2024-08-15 13:00:00.000') -- Match the event date