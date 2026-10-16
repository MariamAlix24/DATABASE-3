CREATE DATABASE StoreDB;
use StoreDB;
CREATE TABLE Suppliers (
    SupplierId INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(60) NOT NULL,
    Country NVARCHAR(50),
    Email VARCHAR(20),
    Address NVARCHAR(60),
    ContactNumber VARCHAR(20)
);
CREATE TABLE Categories (
    CategoryId INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(60) NOT NULL,
    Description NVARCHAR(70),
    MainCategory INT FOREIGN KEY REFERENCES Categories(CategoryId)
);
CREATE TABLE Customers (
    CustomerId INT PRIMARY KEY IDENTITY(1,3),
    FullName NVARCHAR(60) NOT NULL,
    PhoneNumber VARCHAR(20),
    Email VARCHAR(30),
    ShippingAddress NVARCHAR(70),
    RegistrationDate DATE
);
CREATE TABLE Payments (
    PaymentId INT PRIMARY KEY IDENTITY,
    PaymentDate DATETIME,
    Amount DECIMAL(10, 4),
    Status NVARCHAR(40),
    Method NVARCHAR(40)
);
CREATE TABLE Products (
    ProductId INT PRIMARY KEY IDENTITY,
    StockQuantity INT,
    Name NVARCHAR(50) NOT NULL,
    AddedDate DATE,
    Description NVARCHAR(60),
    UnitPrice DECIMAL(10, 2),
    CategoryId INT FOREIGN KEY REFERENCES Categories(CategoryId)
);
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY,
    Status NVARCHAR(50),
    OrderAmount DECIMAL(10, 2),
    OrderDate DATETIME,
    CustomerId INT FOREIGN KEY REFERENCES Customers(CustomerId)
);
CREATE TABLE Shipments (
    ShipmentId INT PRIMARY KEY IDENTITY,
    ShipmentDate DATETIME,
    Status NVARCHAR(50),
    DeliveryDate DATETIME,
    CarrierName NVARCHAR(100),
    TrackingNumber VARCHAR(40),
    OrderId INT FOREIGN KEY REFERENCES Orders(OrderId)
);
CREATE TABLE StockTransactions (
    TransId INT PRIMARY KEY IDENTITY,
    TransDate DATETIME,
    QuantityChange INT,
    Type NVARCHAR(50),
    Reference NVARCHAR(100),
    ProductId INT FOREIGN KEY REFERENCES Products(ProductId)
);
CREATE TABLE Reviews (
    ReviewId INT PRIMARY KEY IDENTITY,
    Rating INT,
    Date DATETIME,
    Comment NVARCHAR(200),
    ProductId INT FOREIGN KEY REFERENCES Products(ProductId),
    CustomerId INT FOREIGN KEY REFERENCES Customers(CustomerId)
);
CREATE TABLE OrderItems (
    OrderItemId INT PRIMARY KEY IDENTITY,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    ProductId INT FOREIGN KEY REFERENCES Products(ProductId),
    OrderId INT FOREIGN KEY REFERENCES Orders(OrderId)
);
CREATE TABLE Products_Suppliers (
    SupplierId INT FOREIGN KEY REFERENCES Suppliers(SupplierId),
    ProductId INT FOREIGN KEY REFERENCES Products(ProductId),
    PRIMARY KEY (SupplierId, ProductId)
);
CREATE TABLE Orders_Payments (
    OrderId INT FOREIGN KEY REFERENCES Orders(OrderId),
    PaymentId INT FOREIGN KEY REFERENCES Payments(PaymentId),
    PRIMARY KEY (OrderId, PaymentId)
);