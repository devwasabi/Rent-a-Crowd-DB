--Get a report of how much you've made from addending events
SELECT * FROM RevenueReportingView WHERE crowdMemberId = ?;

--See the events you've been booked to
SELECT * FROM BookingsReportingView WHERE crowdMemberId =?;

--See Who is attending your event
SELECT * FROM AttendanceReportingView WHERE eventId =?;