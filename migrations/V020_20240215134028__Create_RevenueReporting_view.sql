-- See how much you've made

CREATE VIEW [dbo].[RevenueReportingView]
AS
    SELECT 
        COUNT(b.eventId) AS NumberOfEvents,
        (dbo.getRate() * COUNT(b.eventId)) AS TotalMade,
        (dbo.getCommission() * dbo.getRate() * COUNT(b.eventId)) AS ServiceFee,
        (dbo.getRate() * COUNT(b.eventId)) - (dbo.getCommission() * dbo.getRate() * COUNT(b.eventId)) AS DueToYou,
        b.crowdMemberId AS crowdMemberId
    FROM 
        Bookings b
    GROUP BY 
        b.crowdMemberId;
