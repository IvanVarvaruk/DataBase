EXEC sp_GetEmployees  @EmployeeID = NULL, @FirstName = NULL, @LastName = NULL, @Position = NULL, @HireDate = NULL, @Salary = NULL, @PageSize = 6, @PageNumber = 1, @SortColumn = Salary, @SortDirection = 1

EXEC sp_GetClients @ClientID = NULL, @FirstName = NULL, @LastName = NULL, @Address = NULL, @PhoneNumber = NULL, @DateOfBirth = NULL, @PageSize = 10, @PageNumber = 1, @SortColumn = 'FirstName', @SortDirection = 0

EXEC sp_GetDepartments @DepartmentID = NULL, @DepartmentName = Null, @PageSize = 5, @PageNumber = 1, @SortColumn = 'DepartmentName', @SortDirection = 0

EXEC sp_GetServiceTypes @ServiceTypeID = NULL, @ServiceName = NULL, @Price = NULL, @PageSize = 20, @PageNumber = 1, @SortColumn = 'Price', @SortDirection = 0

EXEC sp_GetVehicles @VehicleID = NULL, @ClientID = NULL, @VehicleType = NULL, @Brand = NULL, @Model = NULL, @LicensePlate = NULL, @YearOfManufacture = NULL, @PageSize = 5, @PageNumber = 1, @SortColumn = 'Brand', @SortDirection = 0
