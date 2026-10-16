USE HotelManagementDB;
CREATE TABLE Hotels (
    HotelId INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(50) NOT NULL,
    Address NVARCHAR(100),
    City NVARCHAR(20),
    StarRating INT,
    ContactNumber VARCHAR(50),
    ManagedId INT UNIQUE
);
CREATE TABLE Staff (
    StaffId INT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50),
    Salary DECIMAL(10, 2),
    HotelId INT FOREIGN KEY REFERENCES Hotels(HotelId)
);
ALTER TABLE Hotels ADD FOREIGN KEY (ManagedId) REFERENCES Staff(StaffId);
CREATE TABLE Rooms (
    RoomNumber INT PRIMARY KEY,
    RoomType NVARCHAR(50),
    Capacity INT,
    DailyRate DECIMAL(10, 2),
    Availability BIT,
    HotelId INT FOREIGN KEY REFERENCES Hotels(HotelId)
);
CREATE TABLE Amenities (
    RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber),
    Amenity NVARCHAR(100),
    PRIMARY KEY (RoomNumber, Amenity)
);
CREATE TABLE Services (
    ServiceId INT PRIMARY KEY IDENTITY,
    ServiceName NVARCHAR(100) NOT NULL,
    Charge DECIMAL(10, 2),
    RequestDate DATE,
    StaffId INT FOREIGN KEY REFERENCES Staff(StaffId)
);
CREATE TABLE Guests (
    GuestId INT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(100) NOT NULL,
    Nationality NVARCHAR(30),
    PassportNumber VARCHAR(20),
    DateOfBirth DATE
);
CREATE TABLE Guest_Contact_Details (
    GuestId INT FOREIGN KEY REFERENCES Guests(GuestId),
    Detail NVARCHAR(255),
    PRIMARY KEY (GuestId, Detail)
);
CREATE TABLE Reservations (
    ReservationId INT PRIMARY KEY IDENTITY,
    BookingDate DATETIME,
    CheckInDate DATE,
    CheckOutDate DATE,
    ReservationStatus NVARCHAR(40),
    TotalPrice DECIMAL(10, 2),
    NumberOfAdults INT,
    NumberOfChildren INT
);
CREATE TABLE Payments (
    PaymentId INT PRIMARY KEY IDENTITY,
    Method NVARCHAR(50),
    Date DATETIME,
    Amount DECIMAL(10, 2),
    ConfirmationNumber VARCHAR(20)
);
CREATE TABLE Reservations_Payment (
    ReservationId INT FOREIGN KEY REFERENCES Reservations(ReservationId),
    PaymentId INT FOREIGN KEY REFERENCES Payments(PaymentId),
    PRIMARY KEY (ReservationId, PaymentId)
);
CREATE TABLE Reservations_Rooms (
    ReservationId INT FOREIGN KEY REFERENCES Reservations(ReservationId),
    RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber),
    PRIMARY KEY (ReservationId, RoomNumber)
);
CREATE TABLE Reservations_Guest (
    ReservationId INT FOREIGN KEY REFERENCES Reservations(ReservationId),
    GuestId INT FOREIGN KEY REFERENCES Guests(GuestId),
    PRIMARY KEY (ReservationId, GuestId)
);
CREATE TABLE ReservationService (
    ServiceId INT FOREIGN KEY REFERENCES Services(ServiceId),
    ReservationId INT FOREIGN KEY REFERENCES Reservations(ReservationId),
    PRIMARY KEY (ServiceId, ReservationId)
);