CREATE PROCEDURE ProcessEventPaymentAndBookings
  @EventID INT,
  @TotalPaid INT
AS
BEGIN
  -- Retrieve required event details
  DECLARE @Payable INT, @CrowdQuantity INT, @eventGenderSpec VARCHAR(10), @EventAgeGroup VARCHAR(6)
  SELECT @Payable = e.payable, @CrowdQuantity = e.crowdQuantity, @eventGenderSpec = e.genderSpec, @EventAgeGroup = e.ageGroup
  FROM Events e
  WHERE e.eventId = @EventID;

  -- Validate payment amount
  IF @TotalPaid < @Payable
  BEGIN
    RAISERROR('Insufficient payment amount.', 16, 1);
    RETURN;
  END

  -- Begin transaction
  BEGIN TRANSACTION;

  -- Insert payment record
  INSERT INTO Payments (eventId, totalPaid, createdAt)
  VALUES (@EventID, @TotalPaid, GETDATE());

  -- Add bookings iteratively
  DECLARE @CrowdMemberId INT, @GenderSpec VARCHAR(10), @AgeGroup INT;
  DECLARE @AddedCount INT = 0;
  WHILE @AddedCount < @CrowdQuantity
  BEGIN
    -- Randomly select eligible member
    SELECT TOP 1 @CrowdMemberId, @GenderSpec, @AgeGroup
    FROM CrowdMembers cm
    WHERE NOT EXISTS (
        SELECT 1
        FROM Bookings b
        WHERE b.eventId = @EventID
        AND b.crowdMemberId = cm.userId
        --AND CAST(b.createdAt AS DATE) = CAST(GETDATE() AS DATE)  prevent double bookings in one day
    )
    ORDER BY NEWID();

    IF @@ROWCOUNT > 0 -- Check if eligible member found
    BEGIN
      -- Validate member eligibility (optional)
      IF (@GenderSpec ='b' OR @GenderSpec = @EventAgeGroup)
         AND (@AgeGroup ='all' OR @AgeGroup = @EventAgeGroup )
      BEGIN
        -- Insert booking
        INSERT INTO Bookings (eventId, crowdMemberId)
        VALUES (@EventID, @CrowdMemberId);
        SET @AddedCount = @AddedCount + 1;
      END
    END
  END;

  IF @AddedCount < @CrowdQuantity
  BEGIN
    RAISERROR('Insufficient eligible members found.', 16, 1);
    ROLLBACK TRANSACTION; -- Rollback if not enough bookings
    RETURN;
  END

  -- Commit transaction if successful
  COMMIT TRANSACTION;

  RETURN;
END;