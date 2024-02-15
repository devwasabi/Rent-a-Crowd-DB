--See the users who are attending your event

CREATE VIEW [dbo].[AttendanceReportingView]
AS
    SELECT u.firstName AS FirstName,
           u.lastName AS LastName,
           u.email AS Email,
           u.phone AS PhoneNumber,
           e.eventName AS EventName,
		   b.eventId AS eventId
    FROM Bookings b
    INNER JOIN UserInfo u ON b.crowdMemberId = u.userId
	INNER JOIN Events e ON b.eventId = e.eventId;


