CREATE OR ALTER PROCEDURE dbo.sp_SetClient
    @ClientID INT = NULL OUTPUT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @DateOfBirth DATE,
    @Address NVARCHAR(255) = NULL,
    @PhoneNumber NVARCHAR(15) = NULL,
    @Email NVARCHAR(255) = NULL
    AS
BEGIN
BEGIN TRY
IF @ClientID IS NULL
BEGIN

INSERT INTO dbo.Clients (FirstName, LastName, DateOfBirth, Address, PhoneNumber, Email)
VALUES (@FirstName, @LastName, @DateOfBirth, @Address, @PhoneNumber, @Email);

SET @ClientID = SCOPE_IDENTITY();
END
ELSE
BEGIN

UPDATE dbo.Clients
SET
    FirstName = ISNULL(@FirstName, FirstName),
    LastName = ISNULL(@LastName, LastName),
    DateOfBirth = ISNULL(@DateOfBirth, DateOfBirth),
    Address = ISNULL(@Address, Address),
    PhoneNumber = ISNULL(@PhoneNumber, PhoneNumber),
    Email = ISNULL(@Email, Email)
WHERE ClientID = @ClientID;

IF @@ROWCOUNT = 0
                THROW 51000, 'ClientID not found.', 1;
END
END TRY
BEGIN CATCH
PRINT ERROR_MESSAGE();
        THROW;
END CATCH
END;
-- Процедура для таблиці Vehicles
CREATE OR ALTER PROCEDURE dbo.sp_SetVehicle
    @VehicleID INT = NULL OUTPUT,
    @ClientID INT = NULL,
    @VehicleType NVARCHAR(50) = NULL,
    @Brand NVARCHAR(50) = NULL,
    @Model NVARCHAR(50) = NULL,
    @YearOfManufacture INT = NULL,
    @LicensePlate NVARCHAR(20) = NULL
AS
BEGIN
       BEGIN TRY
         IF @VehicleID IS NULL
             BEGIN
                INSERT INTO dbo.Vehicles (ClientID, VehicleType, Brand, Model, YearOfManufacture, LicensePlate)
                    VALUES (@ClientID, @VehicleType, @Brand, @Model, @YearOfManufacture, @LicensePlate);
                SET @VehicleID = SCOPE_IDENTITY();
            END
        ELSE
            BEGIN
                UPDATE dbo.Vehicles
                SET
                    ClientID = ISNULL(@ClientID, ClientID),
                    VehicleType = ISNULL(@VehicleType, VehicleType),
                    Brand = ISNULL(@Brand, Brand),
                    Model = ISNULL(@Model, Model),
                    YearOfManufacture = ISNULL(@YearOfManufacture, YearOfManufacture),
                    LicensePlate = ISNULL(@LicensePlate, LicensePlate)
                WHERE VehicleID = @VehicleID;

                IF @@ROWCOUNT = 0
                    THROW 51000, 'VehicleID not found.', 1;
            END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;

-- Процедура для таблиці DriverLicenses
CREATE OR ALTER PROCEDURE dbo.sp_SetDriverLicense
    @LicenseID INT = NULL OUTPUT,
    @ClientID INT = NULL,
    @LicenseNumber NVARCHAR(20) = NULL,
    @LicenseCategory NVARCHAR(10) = NULL,
    @IssueDate DATE = NULL,
    @ExpiryDate DATE = NULL
AS
BEGIN
    BEGIN TRY
        IF @LicenseID IS NULL
            BEGIN
                INSERT INTO dbo.DriverLicenses (ClientID, LicenseNumber, LicenseCategory, IssueDate, ExpiryDate)
                VALUES (@ClientID, @LicenseNumber, @LicenseCategory, @IssueDate, @ExpiryDate);

                SET @LicenseID = SCOPE_IDENTITY();
            END
        ELSE
            BEGIN
                UPDATE dbo.DriverLicenses
                SET
                    ClientID = ISNULL(@ClientID, ClientID),
                    LicenseNumber = ISNULL(@LicenseNumber, LicenseNumber),
                    LicenseCategory = ISNULL(@LicenseCategory, LicenseCategory),
                    IssueDate = ISNULL(@IssueDate, IssueDate),
                    ExpiryDate = ISNULL(@ExpiryDate, ExpiryDate)
                WHERE LicenseID = @LicenseID;

                IF @@ROWCOUNT = 0
                    THROW 51000, 'LicenseID not found.', 1;
            END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;

-- Процедура для таблиці ServiceRequests
CREATE OR ALTER PROCEDURE dbo.sp_SetServiceRequest
    @ServiceRequestID INT = NULL OUTPUT,
    @ClientID INT = NULL,
    @ServiceTypeID INT = NULL,
    @RequestDate DATE = NULL,
    @Status NVARCHAR(50) = NULL
AS
BEGIN
    BEGIN TRY
        IF @ServiceRequestID IS NULL
            BEGIN
                INSERT INTO dbo.ServiceRequests (ClientID, ServiceTypeID, RequestDate, Status)
                VALUES (@ClientID, @ServiceTypeID, @RequestDate, @Status);

                SET @ServiceRequestID = SCOPE_IDENTITY();
            END
        ELSE
            BEGIN
                UPDATE dbo.ServiceRequests
                SET
                    ClientID = ISNULL(@ClientID, ClientID),
                    ServiceTypeID = ISNULL(@ServiceTypeID, ServiceTypeID),
                    RequestDate = ISNULL(@RequestDate, RequestDate),
                    Status = ISNULL(@Status, Status)
                WHERE ServiceRequestID = @ServiceRequestID;

                IF @@ROWCOUNT = 0
                    THROW 51000, 'ServiceRequestID not found.', 1;
            END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;

-- Процедура для таблиці Transactions
CREATE OR ALTER PROCEDURE dbo.sp_SetTransaction
    @TransactionID INT = NULL OUTPUT,
    @ServiceRequestID INT = NULL,
    @PaymentAmount MONEY = NULL,
    @PaymentDate DATE = NULL,
    @PaymentMethod NVARCHAR(50) = NULL
AS
BEGIN
    BEGIN TRY
        IF @TransactionID IS NULL
            BEGIN
                INSERT INTO dbo.Transactions (ServiceRequestID, PaymentAmount, PaymentDate, PaymentMethod)
                VALUES (@ServiceRequestID, @PaymentAmount, @PaymentDate, @PaymentMethod);

                SET @TransactionID = SCOPE_IDENTITY();
            END
        ELSE
            BEGIN
                UPDATE dbo.Transactions
                SET
                    ServiceRequestID = ISNULL(@ServiceRequestID, ServiceRequestID),
                    PaymentAmount = ISNULL(@PaymentAmount, PaymentAmount),
                    PaymentDate = ISNULL(@PaymentDate, PaymentDate),
                    PaymentMethod = ISNULL(@PaymentMethod, PaymentMethod)
                WHERE TransactionID = @TransactionID;

                IF @@ROWCOUNT = 0
                        THROW 51000, 'TransactionID not found.', 1;
            END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;
-- Процедура для таблиці Appointments
CREATE OR ALTER PROCEDURE dbo.sp_SetAppointment
    @AppointmentID INT = NULL OUTPUT,
    @ClientID INT = NULL,
    @AppointmentDate DATE = NULL,
    @TimeSlot NVARCHAR(10) = NULL,
    @ServiceTypeID INT = NULL
AS
BEGIN
    BEGIN TRY
        IF @AppointmentID IS NULL
            BEGIN
                INSERT INTO dbo.Appointments (ClientID, AppointmentDate, TimeSlot, ServiceTypeID)
                VALUES (@ClientID, @AppointmentDate, @TimeSlot, @ServiceTypeID);

                SET @AppointmentID = SCOPE_IDENTITY();
            END
        ELSE
            BEGIN
                UPDATE dbo.Appointments
                SET
                    ClientID = ISNULL(@ClientID, ClientID),
                    AppointmentDate = ISNULL(@AppointmentDate, AppointmentDate),
                    TimeSlot = ISNULL(@TimeSlot, TimeSlot),
                    ServiceTypeID = ISNULL(@ServiceTypeID, ServiceTypeID)
                WHERE AppointmentID = @AppointmentID;

                IF @@ROWCOUNT = 0
                    THROW 51000, 'AppointmentID not found.', 1;
            END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;
-- Процедура для таблиці Departments
CREATE OR ALTER PROCEDURE dbo.sp_SetDepartment
    @DepartmentID INT = NULL OUTPUT,
    @Name NVARCHAR(100) = NULL,
    @Description NVARCHAR(255) = NULL
AS
BEGIN
    BEGIN TRY
        IF @DepartmentID IS NULL
            BEGIN
                INSERT INTO dbo.Departments (DepartmentName, Description)
                VALUES (@Name, @Description);

                SET @DepartmentID = SCOPE_IDENTITY();
            END
        ELSE
            BEGIN
                UPDATE dbo.Departments
                SET
                    DepartmentName = ISNULL(@Name, DepartmentName),
                    Description = ISNULL(@Description, Description)
                WHERE DepartmentID = @DepartmentID;

                IF @@ROWCOUNT = 0
                    THROW 51000, 'DepartmentID not found.', 1;
            END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;
-- Процедура для таблиці Employees
CREATE OR ALTER PROCEDURE dbo.sp_SetEmployee
    @EmployeeID INT = NULL OUTPUT,
    @FirstName NVARCHAR(50) = NULL ,
    @LastName NVARCHAR(50) = NULL,
    @Position NVARCHAR(50) = NULL,
    @HireDate DATE = NULL,
    @Salary DECIMAL(10, 2) = NULL
AS
BEGIN
    BEGIN TRY
        IF @EmployeeID IS NULL
            BEGIN
                INSERT INTO dbo.Employees (FirstName, LastName, Position, HireDate, Salary)
                VALUES (@FirstName, @LastName, @Position, @HireDate, @Salary);

                SET @EmployeeID = SCOPE_IDENTITY();
            END
        ELSE
            BEGIN
                UPDATE dbo.Employees
                SET
                    FirstName = ISNULL(@FirstName, FirstName),
                    LastName = ISNULL(@LastName, LastName),
                    Position = ISNULL(@Position, Position),
                    HireDate = ISNULL(@HireDate, HireDate),
                    Salary = ISNULL(@Salary, Salary)
                WHERE EmployeeID = @EmployeeID;

                IF @@ROWCOUNT = 0
                    THROW 51000, 'EmployeeID not found.', 1;
            END
        END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;

-- Процедура для таблиці Feedbacks
CREATE OR ALTER PROCEDURE dbo.sp_SetFeedback
    @FeedbackID INT = NULL OUTPUT,
    @ClientID INT = NULL,
    @FeedbackText NVARCHAR(500) = NULL,
    @Rating INT = NULL,
    @FeedbackDate DATE = NULL
AS
BEGIN
    BEGIN TRY
        IF @FeedbackID IS NULL
            BEGIN
                INSERT INTO dbo.Feedbacks (ClientID, FeedbackText, Rating, FeedbackDate)
                VALUES (@ClientID, @FeedbackText, @Rating, @FeedbackDate);

                SET @FeedbackID = SCOPE_IDENTITY();
            END
        ELSE
            BEGIN
                UPDATE dbo.Feedbacks
                SET
                    ClientID = ISNULL(@ClientID, ClientID),
                    FeedbackText = ISNULL(@FeedbackText, FeedbackText),
                    Rating = ISNULL(@Rating, Rating),
                    FeedbackDate = ISNULL(@FeedbackDate, FeedbackDate)
                WHERE FeedbackID = @FeedbackID;

                IF @@ROWCOUNT = 0
                    THROW 51000, 'FeedbackID not found.', 1;
            END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;

-- Процедура для таблиці Fines
CREATE OR ALTER PROCEDURE dbo.sp_SetFine
    @FineID INT = NULL OUTPUT,
    @ClientID INT = NULL,
    @VehicleID INT = NULL,
    @FineAmount DECIMAL(10, 2) = NULL,
    @FineDate DATE = NULL,
    @Status VARCHAR(20) = NULL
AS
BEGIN
    BEGIN TRY
        IF @FineID IS NULL
            BEGIN
                INSERT INTO dbo.Fines (ClientID, FineAmount, FineDate, Status)
                VALUES (@ClientID, @FineAmount, @FineDate, @Status);

                SET @FineID = SCOPE_IDENTITY();
            END
        ELSE
                BEGIN
                    UPDATE dbo.Fines
                SET
                    ClientID = ISNULL(@ClientID, ClientID),
                    FineAmount = ISNULL(@FineAmount, FineAmount),
                    FineDate = ISNULL(@FineDate, FineDate),
                    Status = ISNULL(@Status, Status)
                WHERE FineID = @FineID;

                    IF @@ROWCOUNT = 0
                    THROW 51000, 'FineID not found.', 1;
                END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;

-- Процедура для таблиці LicenceReplacementRequests
CREATE OR ALTER PROCEDURE dbo.sp_SetLicenceReplacementRequest
    @RequestID INT = NULL OUTPUT,
    @ClientID INT = NULL,
    @LicenseID INT = NULL,
    @RequestDate DATE = NULL ,
    @Reason NVARCHAR(255) = NULL,
    @Status VARCHAR(20) = NULL
AS
BEGIN
    BEGIN TRY
        IF @RequestID IS NULL
            BEGIN
                INSERT INTO dbo.LicenseReplacementRequests (ClientID, RequestDate, Reason, LicenseID, Status)
                VALUES (@ClientID, @RequestDate, @Reason, @LicenseID, @Status);

                SET @RequestID = SCOPE_IDENTITY();
            END
        ELSE
            BEGIN
                UPDATE dbo.LicenseReplacementRequests
                SET
                    ClientID = ISNULL(@ClientID, ClientID),
                    RequestDate = ISNULL(@RequestDate, RequestDate),
                    Reason = ISNULL(@Reason, Reason),
                    LicenseID = ISNULL(@LicenseID, LicenseID),
                    Status = ISNULL(@Status, Status)

                WHERE RequestID = @RequestID;

                IF @@ROWCOUNT = 0
                        THROW 51000, 'RequestID not found.', 1;
                END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;

-- Процедура для таблиці Notifications
CREATE OR ALTER PROCEDURE dbo.sp_SetNotification
    @NotificationID INT = NULL OUTPUT,
    @ClientID INT = NULL,
    @Message NVARCHAR(255) = NULL,
    @NotificationDate DATE = NULL,
    @IsRead bit = NULL
AS
    BEGIN
    BEGIN TRY
        IF @NotificationID IS NULL
            BEGIN
                INSERT INTO dbo.Notifications (ClientID, Message, NotificationDate, IsRead)
                VALUES (@ClientID, @Message, @NotificationDate, @IsRead);

                    SET @NotificationID = SCOPE_IDENTITY();
                END
            ELSE
                BEGIN
                UPDATE dbo.Notifications
                SET
                    ClientID = ISNULL(@ClientID, ClientID),
                    Message = ISNULL(@Message, Message),
                    NotificationDate = ISNULL(@NotificationDate, NotificationDate),
                    IsRead = ISNULL(@IsRead, IsRead)
                WHERE NotificationID = @NotificationID;

                IF @@ROWCOUNT = 0
                    THROW 51000, 'NotificationID not found.', 1;
            END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;

-- Процедура для таблиці ServiceTypes
CREATE OR ALTER PROCEDURE dbo.sp_SetServiceType
        @ServiceTypeID INT = NULL OUTPUT,
        @ServiceName NVARCHAR(100),
        @Description NVARCHAR(255) = NULL,
        @Price decimal(10,2) = NULL
    AS
    BEGIN
        BEGIN TRY
            IF @ServiceTypeID IS NULL
                BEGIN
                    INSERT INTO dbo.ServiceTypes (ServiceName, Description, Price)
                VALUES (@ServiceName, @Description, @Price);

                SET @ServiceTypeID = SCOPE_IDENTITY();
            END
        ELSE
            BEGIN
                UPDATE dbo.ServiceTypes
                SET
                    ServiceName = ISNULL(@ServiceName, ServiceName),
                    Description = ISNULL(@Description, Description),
                    Price = ISNULL(@Price, Price)
                WHERE ServiceTypeID = @ServiceTypeID;

                IF @@ROWCOUNT = 0
                    THROW 51000, 'ServiceTypeID not found.', 1;
            END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;

-- Процедура для таблиці VehicleRegistrationRequests
CREATE OR ALTER PROCEDURE dbo.sp_SetVehicleRegistrationRequest
    @RequestID INT = NULL OUTPUT,
    @ClientID INT = NULL,
    @VehicleID INT = NULL,
    @RequestDate DATE = NULL,
    @Status NVARCHAR(50) = NULL
AS
BEGIN
    BEGIN TRY
        IF @RequestID IS NULL
            BEGIN
                INSERT INTO dbo.VehicleRegistrationRequests (ClientID, VehicleID, RequestDate, Status)
                VALUES (@ClientID, @VehicleID, @RequestDate, @Status);

                SET @RequestID = SCOPE_IDENTITY();
            END
    ELSE
        BEGIN
                UPDATE dbo.VehicleRegistrationRequests
                    SET
                    ClientID = ISNULL(@ClientID, ClientID),
                    VehicleID = ISNULL(@VehicleID, VehicleID),
                    RequestDate = ISNULL(@RequestDate, RequestDate),
                    Status = ISNULL(@Status, Status)
                WHERE RequestID = @RequestID;

                IF @@ROWCOUNT = 0
                THROW 51000, 'RequestID not found.', 1;
           END
        END TRY
        BEGIN CATCH
            PRINT ERROR_MESSAGE();
            THROW;
    END CATCH
END;

CREATE OR ALTER PROCEDURE dbo.sp_SetEmployeeDepartment
    @EmployeeID INT = NULL,
    @DepartmentID INT = NULL,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN
    BEGIN TRY
        IF @EmployeeID IS NULL
            BEGIN
                INSERT INTO dbo.EmployeeDepartments (EmployeeID, DepartmentID, StartDate, EndDate)
                VALUES (@EmployeeID, @DepartmentID, @StartDate, @EndDate);
            END
        ELSE
            BEGIN
                UPDATE dbo.EmployeeDepartments
                SET
                    EmployeeID = ISNULL(@EmployeeID, EmployeeID),
                    DepartmentID = ISNULL(@DepartmentID, DepartmentID),
                    StartDate = ISNULL(@StartDate, StartDate),
                    EndDate = ISNULL(@EndDate, EndDate)
                WHERE EmployeeID = @EmployeeID;

                IF @@ROWCOUNT = 0
                    THROW 51000, 'RequestID not found.', 1;
            END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;






