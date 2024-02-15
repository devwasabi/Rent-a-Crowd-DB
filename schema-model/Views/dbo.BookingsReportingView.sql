--See the events you've been booked to

CREATE VIEW [dbo].[BookingsReportingView]
AS
    SELECT e.eventName AS eventName,
		   e.description AS description,
		   e.EventDateTime AS eventDateAndTime,
		   a.streetNumber AS streetNumber,
		   a.streetName AS streetName,
		   a.suburb AS suburb,
		   a.city AS city,
		   a.zipCode AS zipCode,
		   b.crowdMemberId AS crowdMemberId
    FROM Events e
    INNER JOIN Address a ON e.addressId = a.addressId
	INNER JOIN Bookings b ON e.eventId = b.eventId;


