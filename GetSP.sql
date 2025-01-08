CREATE
OR
ALTER PROCEDURE dbo.sp_GetEmployees
    @EmployeeID INT = NULL,
    @FirstName varchar (50)= NULL,
    @LastName varchar (50)= NULL,
    @Position varchar (50)= NULL,
    @HireDate date = NULL,
    @Salary decimal (10, 2)= NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR (128) = 'EmployeeID',
    @SortDirection BIT = 0
    AS
BEGIN
     IF
@EmployeeID IS NOT NULL
        AND NOT EXISTS (SELECT 1
                        FROM Employees
                        WHERE EmployeeID = @EmployeeID)
BEGIN
            PRINT
'Incorrect value of @EmployeeID'
            RETURN
END
SELECT *
FROM Employees
WHERE (@EmployeeID IS NULL OR EmployeeID = @EmployeeID)
  AND (@FirstName IS NULL OR FirstName LIKE @FirstName + '%')
  AND (@LastName IS NULL OR LastName LIKE @LastName + '%')
  AND (@Position IS NULL OR Position = @Position)
  AND (@HireDate IS NULL OR HireDate = @HireDate)
  AND (@Salary IS NULL OR Salary = @Salary)
ORDER BY CASE
             WHEN @SortDirection = 0 THEN
                 CASE @SortColumn
                     WHEN 'EmployeeID' THEN RIGHT ('          ' + CAST (EmployeeID AS NVARCHAR(50)), 10)
    WHEN 'LastName' THEN LastName
    WHEN 'FirstName' THEN FirstName
    WHEN 'Position' THEN Position
    WHEN 'HireDate' THEN RIGHT ('          ' + CAST (HireDate AS NVARCHAR(50)), 10)
    WHEN 'Salary' THEN RIGHT ('          ' + CAST (Salary AS NVARCHAR(50)), 10)
END
END
ASC,
         CASE
             WHEN @SortDirection = 1 THEN
                 CASE @SortColumn
                     WHEN 'EmployeeID' THEN RIGHT('          ' + CAST(EmployeeID AS NVARCHAR(50)), 10)
                     WHEN 'LastName' THEN LastName
                     WHEN 'FirstName' THEN FirstName
                     WHEN 'Position' THEN Position
                     WHEN 'HireDate' THEN RIGHT('          ' + CAST(HireDate AS NVARCHAR(50)), 10)
                     WHEN 'Salary' THEN RIGHT('          ' + CAST(Salary AS NVARCHAR(50)), 10)
END
END
DESC
OFFSET (@PageNumber - 1) * @PageSize ROWS FETCH NEXT @PageSize ROWS ONLY;
END

CREATE
OR
ALTER PROCEDURE dbo.sp_GetClients @ClientID INT = NULL,
    @FirstName varchar (50)= NULL,
    @LastName varchar (50)= NULL,
    @Address varchar (255)= NULL,
    @PhoneNumber varchar (15)= NULL,
    @DateOfBirth date = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR (128) = 'ClientID',
    @SortDirection BIT = 0
    AS
    IF @ClientID IS NOT NULL
    AND NOT EXISTS (SELECT 1
    FROM Clients
    WHERE ClientID = @ClientID)
BEGIN
                PRINT
'Incorrect value of @ClientID'
                RETURN
END
SELECT *
FROM Clients
WHERE (@ClientID IS NULL OR ClientID = @ClientID)
  AND (@FirstName IS NULL OR FirstName LIKE @FirstName + '%')
  AND (@LastName IS NULL OR LastName LIKE @LastName + '%')
  AND (@Address IS NULL OR Address = @Address + '%')
  AND (@DateOfBirth IS NULL OR DateOfBirth = @DateOfBirth)
  AND (@PhoneNumber IS NULL OR PhoneNumber = @PhoneNumber + '%')
ORDER BY CASE
             WHEN @SortDirection = 0 THEN
                 CASE @SortColumn
                     WHEN 'ClientID' THEN RIGHT ('          ' + CAST (ClientID AS NVARCHAR(50)), 10)
    WHEN 'FirstName' THEN FirstName
    WHEN 'LastName' THEN LastName
    WHEN 'Address' THEN Address
    WHEN 'DateOfBirth' THEN RIGHT ('          ' + CAST (DateOfBirth AS NVARCHAR(50)), 10)
    WHEN 'PhoneNumber' THEN RIGHT ('          ' + CAST (PhoneNumber AS NVARCHAR(50)), 10)
END
END
ASC,
             CASE
                 WHEN @SortDirection = 1 THEN
                     CASE @SortColumn
                         WHEN 'ClientID' THEN RIGHT('          ' + CAST(ClientID AS NVARCHAR(50)), 10)
                         WHEN 'FirstName' THEN FirstName
                         WHEN 'LastName' THEN LastName
                         WHEN 'Address' THEN Address
                         WHEN 'DateOfBirth' THEN RIGHT('          ' + CAST(DateOfBirth AS NVARCHAR(50)), 10)
                         WHEN 'PhoneNumber' THEN RIGHT('          ' + CAST(PhoneNumber AS NVARCHAR(50)), 10)
END
END
DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS FETCH NEXT @PageSize ROWS ONLY;


CREATE
OR
ALTER PROCEDURE dbo.sp_GetServiceTypes @ServiceTypeID INT = NULL,
    @ServiceName varchar (50) = NULL,
    @Price decimal (10, 2) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR (128) = 'DepartmentID',
    @SortDirection BIT = 0
    AS
    IF @ServiceTypeID IS NOT NULL
    AND NOT EXISTS (SELECT 1 FROM ServiceTypes WHERE ServiceTypeID = @ServiceTypeID)
BEGIN
                PRINT
'Incorrect value of @DepartmentID'
                RETURN
END
SELECT *
FROM ServiceTypes
WHERE (@ServiceTypeID IS NULL OR ServiceTypeID = @ServiceTypeID)
  AND (@ServiceName IS NULL OR ServiceName LIKE @ServiceName + '%')
  AND (@Price IS NULL OR Price LIKE @Price)
ORDER BY CASE
             WHEN @SortDirection = 0 THEN
                 CASE @SortColumn
                     WHEN 'ServiceTypeID' THEN RIGHT ('          ' + CAST (ServiceTypeID AS NVARCHAR(50)), 10)
    WHEN 'ServiceName' THEN ServiceName
    WHEN 'Price' THEN RIGHT ('          ' + CAST (Price AS NVARCHAR(50)), 10)
END
END
ASC,
                CASE
            WHEN @SortDirection = 1 THEN
                    CASE @SortColumn
                        WHEN 'ServiceTypeID' THEN RIGHT('          ' + CAST(ServiceTypeID AS NVARCHAR(50)), 10)
                        WHEN 'ServiceName' THEN ServiceName
                        WHEN 'Price' THEN RIGHT('          ' + CAST(Price AS NVARCHAR(50)), 10)
END
END
DESC
OFFSET (@PageNumber - 1) * @PageSize ROWS FETCH NEXT @PageSize ROWS ONLY;

CREATE
OR
ALTER PROCEDURE dbo.sp_GetDepartments
    @DepartmentID INT = NULL,
    @DepartmentName varchar (50)= NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR (128) = 'DepartmentID',
    @SortDirection BIT = 0
    AS
    IF @DepartmentID IS NOT NULL
    AND NOT EXISTS (SELECT 1
    FROM Departments
    WHERE DepartmentID = @DepartmentID)
BEGIN
                    PRINT
'Incorrect value of @DepartmentID'
                RETURN
END
SELECT *
FROM Departments
WHERE (@DepartmentID IS NULL OR DepartmentID = @DepartmentID)
  AND (@DepartmentName IS NULL OR DepartmentName LIKE @DepartmentName + '%')
ORDER BY CASE
             WHEN @SortDirection = 0 THEN
                 CASE @SortColumn
                     WHEN 'DepartmentID' THEN RIGHT ('          ' + CAST (DepartmentID AS NVARCHAR(50)), 10)
    WHEN 'DepartmentName' THEN DepartmentName
END
END
ASC,
        CASE
            WHEN @SortDirection = 1 THEN
                CASE @SortColumn
                    WHEN 'DepartmentID' THEN RIGHT('          ' + CAST(DepartmentID AS NVARCHAR(50)), 10)
                    WHEN 'DepartmentName' THEN DepartmentName
END
END
DESC
OFFSET (@PageNumber - 1) * @PageSize ROWS FETCH NEXT @PageSize ROWS ONLY;

CREATE
OR
ALTER PROCEDURE dbo.sp_GetVehicles
    @VehicleID INT = NULL,
    @ClientID INT = NULL,
    @VehicleType VARCHAR (50) = NULL,
    @Brand VARCHAR (50) = NULL,
    @Model VARCHAR (50) = NULL,
    @LicensePlate VARCHAR (15) = NULL,
    @YearOfManufacture INT = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR (128) = 'VehicleID',
    @SortDirection BIT = 0
    AS
BEGIN
SELECT *
FROM Vehicles
WHERE (@VehicleID IS NULL OR VehicleID = @VehicleID)
  AND (@ClientID IS NULL OR ClientID = @ClientID)
  AND (@VehicleType IS NULL OR VehicleType LIKE @VehicleType + '%')
  AND (@Brand IS NULL OR Brand LIKE @Brand + '%')
  AND (@Model IS NULL OR Model LIKE @Model + '%')
  AND (@LicensePlate IS NULL OR LicensePlate LIKE @LicensePlate + '%')
  AND (@YearOfManufacture IS NULL OR YearOfManufacture = @YearOfManufacture)
ORDER BY CASE
             WHEN @SortDirection = 0 THEN
                 CASE @SortColumn
                     WHEN 'VehicleID' THEN RIGHT ('          ' + CAST (VehicleID AS NVARCHAR(50)), 10)
    WHEN 'ClientID' THEN RIGHT ('          ' + CAST (ClientID AS NVARCHAR(50)), 10)
    WHEN 'VehicleType' THEN VehicleType
    WHEN 'Brand' THEN Brand
    WHEN 'Model' THEN Model
    WHEN 'LicensePlate' THEN RIGHT ('          ' + CAST (LicensePlate AS NVARCHAR(50)), 10)
    WHEN 'YearOfManufacture' THEN RIGHT ('          ' + CAST (YearOfManufacture AS NVARCHAR(50)), 10)
END
END
ASC,
            CASE
                WHEN @SortDirection = 1 THEN
                    CASE @SortColumn
                        WHEN 'VehicleID' THEN RIGHT('          ' + CAST(VehicleID AS NVARCHAR(50)), 10)
                        WHEN 'ClientID' THEN RIGHT('          ' + CAST(ClientID AS NVARCHAR(50)), 10)
                        WHEN 'VehicleType' THEN VehicleType
                        WHEN 'Brand' THEN Brand
                        WHEN 'Model' THEN Model
                        WHEN 'LicensePlate' THEN RIGHT('          ' + CAST(LicensePlate AS NVARCHAR(50)), 10)
                        WHEN 'YearOfManufacture' THEN RIGHT('          ' + CAST(YearOfManufacture AS NVARCHAR(50)), 10)
END
END
DESC
            OFFSET (@PageNumber - 1) * @PageSize ROWS FETCH NEXT @PageSize ROWS ONLY;
END;