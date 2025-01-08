DECLARE @NewClientID INT;
EXEC dbo.sp_SetClient
    @ClientID = @NewClientID OUTPUT,
    @FirstName = 'Микола',
    @LastName = 'Патик',
    @DateOfBirth = '2006-6-30',
    @Address = 'Київ, вул. Кривоноса, 31',
    @PhoneNumber = '+380998877665',
    @Email = 'mykola.patyk@gmail.com';

PRINT 'New Client ID: ' + CAST(@NewClientID AS NVARCHAR);

EXEC dbo.sp_SetClient
    @ClientID = @NewClientID,
    @FirstName = 'Григорій',
     @LastName = 'Пипка',
     @DateOfBirth = '1995-10-25',
     @Address = 'Івано-Франківськ, вул. Галицька, 15',
     @PhoneNumber = '+380998877789',
    @Email = 'hryhoriy.pypka@gmail.com';
SELECT * FROM Clients

EXEC dbo.sp_SetVehicle
    @VehicleID = NULL ,
    @ClientID = NULL,
    @VehicleType = NULL,
    @Brand = NULL,
    @Model = NULL,
    @YearOfManufacture = NULL,
    @LicensePlate = NULL
SELECT * FROM Vehicles

EXEC dbo.sp_SetAppointment
    @AppointmentID = NULL,
    @ClientID = NULL,
    @AppointmentDate = NULL,
    @TimeSlot = NULL,
    @ServiceTypeID = NULL
SELECT * FROM Appointments

EXEC dbo.sp_SetDepartment
    @DepartmentID = NULL,
    @Name = NULL,
    @Description = NULL
SELECT * FROM Departments

EXEC dbo.sp_SetDriverLicense
    @LicenseID = NULL,
    @ClientID = NULL,
    @LicenseNumber = NULL,
    @LicenseCategory = NULL,
    @IssueDate = NULL,
    @ExpiryDate = NULL
SELECT * FROM DriverLicenses

EXEC dbo.sp_SetEmployee
    @EmployeeID = NULL,
    @FirstName = NULL,
    @LastName = NULL,
    @Position = NULL,
    @HireDate = NULL,
    @Salary = NULL
SELECT * FROM Employees

EXEC dbo.sp_SetFeedback
    @FeedbackID = NULL,
    @ClientID = NULL,
    @FeedbackText = NULL,
    @Rating = NULL,
    @FeedbackDate = NULL
SELECT * FROM Feedbacks

EXEC dbo.sp_SetFine
    @FineID = NULL,
    @ClientID = NULL,
    @VehicleID = NULL,
    @FineAmount = NULL,
    @FineDate = NULL,
    @Status = NULL
SELECT * FROM Fines

EXEC dbo.sp_SetLicenceReplacementRequest
    @RequestID = NULL,
    @ClientID = NULL,
    @LicenseID = NULL,
    @RequestDate = NULL,
    @Reason = NULL,
    @Status = NULL
SELECT * FROM LicenseReplacementRequests

EXEC dbo.sp_SetNotification
    @NotificationID = NULL,
    @ClientID = NULL,
    @Message = NULL,
    @NotificationDate = NULL,
    @IsRead = NULL
SELECT * FROM Notifications

EXEC dbo.sp_SetServiceRequest
    @ServiceRequestID = NULL,
    @ClientID = NULL,
    @ServiceTypeID = NULL,
    @RequestDate = NULL,
    @Status = NULL
SELECT * FROM ServiceRequests

EXEC dbo.sp_SetServiceType
    @ServiceTypeID = NULL,
    @ServiceName = NULL,
    @Description = NULL,
    @Price = NULL
SELECT * FROM ServiceTypes

EXEC dbo.sp_SetTransaction
    @TransactionID = NULL,
    @ServiceRequestID = NULL,
    @PaymentAmount = NULL,
    @PaymentDate = NULL,
    @PaymentMethod = NULL
SELECT * FROM Transactions

EXEC dbo.sp_SetVehicleRegistrationRequest
    @RequestID = NULL,
    @ClientID = NULL,
    @VehicleID = NULL,
    @RequestDate = NULL,
    @Status = NULL
SELECT * FROM VehicleRegistrationRequests