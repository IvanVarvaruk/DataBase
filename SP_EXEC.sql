EXEC dbo.sp_RegisterVehicle
    @ClientID = 1,
    @VehicleType = 'Легковий автомобіль',
    @Brand = 'Toyota',
    @Model = 'Camry',
    @YearOfManufacture = 2020;


EXEC dbo.sp_OrderService
    @ClientID = 1,
    @ServiceTypeID = 2,
    @Status = 'В процесі';


EXEC dbo.sp_ReplaceLicense
    @ClientID = 1,
    @LicenseID = 1,
    @Reason = 'Втрата документа',
    @Status = 'В процесі';


EXEC dbo.sp_SendNotification
    @ClientID = 1,
    @Message = 'Ваш запит на заміну посвідчення прийнято.';


EXEC dbo.sp_AddFine
    @ClientID = 1,
    @VehicleID = 120,
    @FineAmount = 500.00;


EXEC dbo.sp_HireEmployee
    @FirstName = 'Іван',
    @LastName = 'Петренко',
    @Position = 'Адміністратор',
    @HireDate = '2024-12-03',
    @Salary = 25000.00,
    @DepartmentID = 1,
    @StartDate = '2024-12-10';
