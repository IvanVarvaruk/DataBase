CREATE OR ALTER PROCEDURE dbo.sp_RegisterVehicle
    @ClientID INT,
    @VehicleType NVARCHAR(50),
    @Brand NVARCHAR(50),
    @Model NVARCHAR(50),
    @YearOfManufacture INT,
    @Status NVARCHAR(20) = 'В процесі'
    AS
BEGIN
BEGIN TRY
    BEGIN TRANSACTION;
        DECLARE @VehicleID INT;

EXEC dbo.sp_SetVehicle
            @VehicleID = @VehicleID OUTPUT,
            @ClientID = @ClientID,
            @VehicleType = @VehicleType,
            @Brand = @Brand,
            @Model = @Model,
            @YearOfManufacture = @YearOfManufacture
DECLARE @CurrentDate DATE;
SET @CurrentDate = CONVERT(DATE, SYSDATETIME());
EXEC dbo.sp_SetVehicleRegistrationRequest
            @ClientID = @ClientID,
            @VehicleID = @VehicleID,
            @RequestDate = @CurrentDate,
            @Status = @Status;
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT ERROR_MESSAGE();
        THROW;
END CATCH
END;

CREATE OR ALTER PROCEDURE dbo.sp_OrderService
    @ClientID INT,
    @ServiceTypeID INT,
    @Status NVARCHAR(20) = 'В процесі'
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @CurrentDate DATE;
        SET @CurrentDate = CONVERT(DATE, SYSDATETIME());
        EXEC dbo.sp_SetServiceRequest
             @ClientID = @ClientID,
             @ServiceTypeID = @ServiceTypeID,
             @RequestDate = @CurrentDate,
             @Status = @Status;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;


CREATE OR ALTER PROCEDURE dbo.sp_ReplaceLicense
    @ClientID INT,
    @LicenseID INT,
    @Reason NVARCHAR(255),
    @Status NVARCHAR(20) = 'В процесі'
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @CurrentDate DATE;
        SET @CurrentDate = CONVERT(DATE, SYSDATETIME());
        EXEC dbo.sp_SetLicenceReplacementRequest
             @ClientID = @ClientID,
             @LicenseID = @LicenseID,
             @RequestDate = @CurrentDate,
             @Reason = @Reason,
             @Status = @Status
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;

CREATE OR ALTER PROCEDURE dbo.sp_SendNotification
    @ClientID INT,
    @Message NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @CurrentDate DATE;
        SET @CurrentDate = CONVERT(DATE, SYSDATETIME());
        EXEC dbo.sp_SetNotification
             @ClientID = @ClientID,
             @Message = @Message,
             @NotificationDate = @CurrentDate,
             @IsRead = 0
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;

CREATE OR ALTER PROCEDURE dbo.sp_AddFine
    @ClientID INT,
    @VehicleID INT,
    @FineAmount DECIMAL(10, 2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @CurrentDate DATE;
        SET @CurrentDate = CONVERT(DATE, SYSDATETIME());
        EXEC dbo.sp_SetFine
             @ClientID = @ClientID,
             @VehicleID = @VehicleID,
             @FineAmount = @FineAmount,
             @FineDate = @CurrentDate,
             @Status = 'Не сплачено'
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;

CREATE OR ALTER PROCEDURE dbo.sp_HireEmployee
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Position NVARCHAR(50),
    @HireDate DATE,
    @Salary DECIMAL(10, 2),
    @DepartmentID INT,
    @StartDate DATE = NULL
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @EmployeeID INT;
        EXEC dbo.sp_SetEmployee
             @EmployeeID = @EmployeeID OUTPUT,
             @FirstName = @FirstName,
             @LastName = @LastName,
             @Position = @Position,
             @HireDate = @HireDate,
             @Salary = @Salary;
        IF @StartDate IS NULL
            SET @StartDate = @HireDate;
        EXEC dbo.sp_SetEmployeeDepartment
             @EmployeeID = @EmployeeID,
             @DepartmentID = @DepartmentID,
             @StartDate = @StartDate,
             @EndDate = NULL;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT ERROR_MESSAGE();
    END CATCH
END;