--Перегляд для отримання повної інформації про транспортні засоби клієнтів та статус їх реєстрації.
CREATE VIEW ClientVehicleInfo AS
SELECT
    c.ClientID,
    c.FirstName,
    c.LastName,
    v.VehicleID,
    v.VehicleType,
    v.Brand,
    v.Model,
    v.YearOfManufacture,
    v.LicensePlate,
    r.Status AS RegistrationStatus
FROM Clients AS c
         JOIN Vehicles AS v ON c.ClientID = v.ClientID
         JOIN VehicleRegistrationRequests AS r ON v.VehicleID = r.VehicleID;
--Перегляд для отримання інформації про клієнтів, що мають несплачені штрафи, з деталями штрафів.
CREATE VIEW UnpaidFines AS
SELECT
    c.ClientID,
    c.FirstName,
    c.LastName,
    v.VehicleID,
    v.LicensePlate,
    f.FineAmount,
    f.FineDate,
    f.Status AS FineStatus
FROM Clients AS c
         JOIN Vehicles AS v ON c.ClientID = v.ClientID
         JOIN Fines AS f ON f.ClientID = c.ClientID AND f.VehicleID = v.VehicleID
WHERE f.Status = 'Не сплачено';
--Перегляд для отримання інформації про клієнтів, які залишили відгуки про послуги, з описом послуг та оцінками.
CREATE VIEW ClientFeedbacks AS
SELECT
    c.ClientID,
    c.FirstName,
    c.LastName,
    s.ServiceName,
    f.FeedbackText,
    f.Rating,
    f.FeedbackDate
FROM Clients AS c
         JOIN ServiceRequests AS sr ON c.ClientID = sr.ClientID
         JOIN ServiceTypes AS s ON sr.ServiceTypeID = s.ServiceTypeID
         JOIN Feedbacks AS f ON sr.ServiceRequestID = f.ServiceRequestID;
--Перегляд для отримання інформації про запити на заміну водійських прав із зазначенням причини, статусу та дати запиту.
CREATE VIEW LicenseReplacementDetails AS
SELECT
    c.ClientID,
    c.FirstName,
    c.LastName,
    d.LicenseNumber,
    l.Reason,
    l.RequestDate,
    l.Status AS ReplacementStatus
FROM Clients AS c
         JOIN DriverLicenses AS d ON c.ClientID = d.ClientID
         JOIN LicenseReplacementRequests AS l ON d.LicenseID = l.LicenseID;
--Перегляд для отримання інформації про запити на послуги з призначенням співробітників, їхньою посадою та датою запиту.
CREATE VIEW ServiceRequestAssignments AS
SELECT
    c.ClientID,
    c.FirstName AS ClientFirstName,
    c.LastName AS ClientLastName,
    s.ServiceName,
    e.EmployeeID,
    e.FirstName AS EmployeeFirstName,
    e.LastName AS EmployeeLastName,
    e.Position,
    sr.RequestDate,
    sr.Status AS RequestStatus
FROM Clients AS c
         JOIN ServiceRequests AS sr ON c.ClientID = sr.ClientID
         JOIN ServiceTypes AS s ON sr.ServiceTypeID = s.ServiceTypeID
         JOIN EmployeeDepartments AS ed ON ed.DepartmentID = s.ServiceTypeID
         JOIN Employees AS e ON ed.EmployeeID = e.EmployeeID;