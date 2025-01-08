CREATE DATABASE ServisniyCentrMVS;
USE ServisniyCentrMVS;
CREATE TABLE Clients (
                         ClientID INT PRIMARY KEY IDENTITY(1,1),
                         FirstName VARCHAR(50),
                         LastName VARCHAR(50),
                         DateOfBirth DATE,
                         Address VARCHAR(255),
                         PhoneNumber VARCHAR(15),
                         Email VARCHAR(100)
);
CREATE TABLE Vehicles (
                          VehicleID INT PRIMARY KEY IDENTITY(1,1),
                          ClientID INT,
                          VehicleType VARCHAR(50),
                          Brand VARCHAR(50),
                          Model VARCHAR(50),
                          YearOfManufacture INT,
                          LicensePlate VARCHAR(15),
                          FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);
CREATE TABLE DriverLicenses (
                                LicenseID INT PRIMARY KEY IDENTITY(1,1),
                                ClientID INT,
                                LicenseNumber VARCHAR(20),
                                LicenseCategory VARCHAR(10),
                                IssueDate DATE,
                                ExpiryDate DATE,
                                FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);
CREATE TABLE VehicleRegistrationRequests (
                                             RequestID INT PRIMARY KEY IDENTITY(1,1),
                                             ClientID INT,
                                             VehicleID INT,
                                             RequestDate DATE,
                                             Status VARCHAR(20),
                                             FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
                                             FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);
CREATE TABLE ServiceTypes (
                              ServiceTypeID INT PRIMARY KEY IDENTITY(1,1),
                              ServiceName VARCHAR(100),
                              Description TEXT,
                              Price DECIMAL(10, 2)
);
CREATE TABLE ServiceRequests (
                                 ServiceRequestID INT PRIMARY KEY IDENTITY(1,1),
                                 ClientID INT,
                                 ServiceTypeID INT,
                                 RequestDate DATE,
                                 Status VARCHAR(20),
                                 FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
                                 FOREIGN         KEY (ServiceTypeID) REFERENCES ServiceTypes(ServiceTypeID)
);
CREATE TABLE Appointments (
                              AppointmentID INT PRIMARY KEY IDENTITY(1,1),
                              ClientID INT,
                              AppointmentDate DATE,
                              TimeSlot VARCHAR(10),
                              ServiceTypeID INT,
                              FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
                              FOREIGN KEY (ServiceTypeID) REFERENCES ServiceTypes(ServiceTypeID)
);
CREATE TABLE Employees (
                           EmployeeID INT PRIMARY KEY IDENTITY(1,1),
                           FirstName VARCHAR(50),
                           LastName VARCHAR(50),
                           Position VARCHAR(50),
                           HireDate DATE,
                           Salary DECIMAL(10, 2)
);
CREATE TABLE Departments (
                             DepartmentID INT PRIMARY KEY IDENTITY(1,1),
                             DepartmentName VARCHAR(100),
                             Description TEXT
);
CREATE TABLE EmployeeDepartments (
                                     EmployeeID INT,
                                     DepartmentID INT,
                                     StartDate DATE,
                                     EndDate DATE,
                                     PRIMARY KEY (EmployeeID, DepartmentID),
                                     FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
                                     FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
CREATE TABLE Transactions (
                              TransactionID INT PRIMARY KEY IDENTITY(1,1),
                              ServiceRequestID INT,
                              PaymentAmount DECIMAL(10, 2),
                              PaymentDate DATE,
                              PaymentMethod VARCHAR(50),
                              FOREIGN KEY (ServiceRequestID) REFERENCES ServiceRequests(ServiceRequestID)
);
CREATE TABLE Fines (
                       FineID INT PRIMARY KEY IDENTITY(1,1),
                       ClientID INT,
                       VehicleID INT,
                       FineAmount DECIMAL(10, 2),
                       FineDate DATE,
                       Status VARCHAR(20),
                       FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
                       FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);
CREATE TABLE LicenseReplacementRequests (
                                            RequestID INT PRIMARY KEY IDENTITY(1,1),
                                            ClientID INT,
                                            LicenseID INT,
                                            Reason VARCHAR(255),
                                            RequestDate DATE,
                                            Status VARCHAR(20),
                                            FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
                                            FOREIGN KEY (LicenseID) REFERENCES DriverLicenses(LicenseID)
);
CREATE TABLE Notifications (
                               NotificationID INT PRIMARY KEY IDENTITY(1,1),
                               ClientID INT,
                               Message TEXT,
                               NotificationDate DATE,
                               IsRead BIT DEFAULT 0,
                               FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);
CREATE TABLE Feedbacks (
                           FeedbackID INT PRIMARY KEY IDENTITY(1,1),
                           ClientID INT,
                           ServiceRequestID INT,
                           FeedbackText TEXT,
                           Rating INT CHECK (Rating >= 1 AND Rating <= 5),
                           FeedbackDate DATE,
                           FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
                           FOREIGN KEY (ServiceRequestID) REFERENCES ServiceRequests(ServiceRequestID)
);
