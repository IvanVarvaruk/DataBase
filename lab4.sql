--Вибірка всіх транспортних засобів клієнтів разом з їхніми даними та інформацією про стан реєстрації транспортного засобу.
SELECT c.FirstName, c.LastName, v.Brand, v.Model, v.LicensePlate, v.YearOfManufacture, r.Status AS RegistrationStatus
FROM Clients AS c
         JOIN Vehicles AS v ON c.ClientID = v.ClientID
         JOIN VehicleRegistrationRequests AS r ON v.VehicleID = r.VehicleID;
--Вибірка інформації про клієнтів, які мають штрафи, з деталями штрафів і станом їх сплати.
SELECT c.FirstName, c.LastName, f.FineAmount, f.FineDate, f.Status AS FineStatus
FROM Clients AS c
         JOIN Fines AS f ON c.ClientID = f.ClientID
WHERE f.Status = 'Не сплачено';
--Вибірка клієнтів разом з їхніми запитами на заміну водійських прав і станом запитів.
SELECT c.FirstName, c.LastName, d.LicenseNumber, l.Reason, l.RequestDate, l.Status AS LicenseRequestStatus
FROM Clients AS c
         JOIN DriverLicenses AS d ON c.ClientID = d.ClientID
         JOIN LicenseReplacementRequests AS l ON d.LicenseID = l.LicenseID;
--Вибірка всіх клієнтів, які залишили відгуки про надані послуги, разом з деталями послуг та оцінкою клієнта.
SELECT c.FirstName, c.LastName, s.ServiceName, f.FeedbackText, f.Rating, f.FeedbackDate
FROM Clients AS c
         JOIN ServiceRequests AS sr ON c.ClientID = sr.ClientID
         JOIN ServiceTypes AS s ON sr.ServiceTypeID = s.ServiceTypeID
         JOIN Feedbacks AS f ON sr.ServiceRequestID = f.ServiceRequestID;
--Вибірка інформації про клієнтів, які мають запити на послуги, з зазначенням призначених співробітників, їхньої посади та дати запиту.
SELECT c.FirstName AS ClientFirstName, c.LastName AS ClientLastName, s.ServiceName, e.FirstName AS EmployeeFirstName, e.LastName AS EmployeeLastName, e.Position, sr.RequestDate
FROM Clients AS c
         JOIN ServiceRequests AS sr ON c.ClientID = sr.ClientID
         JOIN ServiceTypes AS s ON sr.ServiceTypeID = s.ServiceTypeID
         JOIN EmployeeDepartments AS ed ON ed.DepartmentID = s.ServiceTypeID
         JOIN Employees AS e ON ed.EmployeeID = e.EmployeeID;
