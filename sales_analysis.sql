-- Step 1: Create Products Table
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Category VARCHAR(50),
    Unit_Price DECIMAL(10, 2)
);

-- Insert Data into Products Table
INSERT INTO Products (Product_ID, Product_Name, Category, Unit_Price)
VALUES
    (1, 'Laptop', 'Electronics', 1200.00),
    (2, 'Smartphone', 'Electronics', 800.00),
    (3, 'Tablet', 'Electronics', 500.00),
    (4, 'Headphones', 'Accessories', 150.00),
    (5, 'Keyboard', 'Accessories', 50.00);

-- Step 2: Create Customers Table
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Region VARCHAR(50)
);

-- Insert Data into Customers Table
INSERT INTO Customers (Customer_ID, Customer_Name, Region)
VALUES
    (1, 'John Doe', 'North'),
    (2, 'Jane Smith', 'South'),
    (3, 'Michael Brown', 'East'),
    (4, 'Emily Davis', 'West'),
    (5, 'David Wilson', 'North');

-- Step 3: Create Sales Table
CREATE TABLE Sales (
    Transaction_ID INT PRIMARY KEY,
    Product_ID INT,
    Customer_ID INT,
    Quantity INT,
    Transaction_Date DATE,
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Insert Data into Sales Table
INSERT INTO Sales (Transaction_ID, Product_ID, Customer_ID, Quantity, Transaction_Date)
VALUES
    (1, 1, 1, 2, '2025-01-01'),
    (2, 2, 2, 1, '2025-01-02'),
    (3, 3, 3, 3, '2025-01-03'),
    (4, 4, 4, 5, '2025-01-04'),
    (5, 5, 5, 4, '2025-01-05'),
    (6, 1, 2, 1, '2025-01-06'),
    (7, 3, 1, 2, '2025-01-07'),
    (8, 2, 3, 3, '2025-01-08'),
    (9, 4, 4, 1, '2025-01-09'),
    (10, 5, 5, 2, '2025-01-10');

	-- View Products Table
SELECT * FROM Products;

-- View Customers Table
SELECT * FROM Customers;

-- View Sales Table
SELECT * FROM Sales;

-- Check the Number of Rows in Each Table
SELECT 'Products' AS Table_Name, COUNT(*) AS Row_Count FROM Products
UNION ALL
SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL
SELECT 'Sales', COUNT(*) FROM Sales;

-- Check for Nulls in Products
SELECT * FROM Products WHERE Product_Name IS NULL OR Category IS NULL OR Unit_Price IS NULL;

-- Check for Nulls in Customers
SELECT * FROM Customers WHERE Customer_Name IS NULL OR Region IS NULL;

-- Check for Nulls in Sales
SELECT * FROM Sales WHERE Product_ID IS NULL OR Customer_ID IS NULL OR Quantity IS NULL OR Transaction_Date IS NULL;

SELECT Product_Name, COUNT(*) 
FROM Products
GROUP BY Product_Name
HAVING COUNT(*) > 1;

SELECT Customer_Name, COUNT(*) 
FROM Customers
GROUP BY Customer_Name
HAVING COUNT(*) > 1;

-- Check for Invalid Data in Sales (e.g., Invalid Product_ID or Customer_ID)
SELECT *
FROM Sales
WHERE Product_ID NOT IN (SELECT Product_ID FROM Products)
   OR Customer_ID NOT IN (SELECT Customer_ID FROM Customers);

   SELECT 
    SUM(S.Quantity * P.Unit_Price) AS Total_Revenue
FROM 
    Sales S
JOIN 
    Products P ON S.Product_ID = P.Product_ID;

	SELECT 
    MONTH(S.Transaction_Date) AS Month, 
    SUM(S.Quantity * P.Unit_Price) AS Monthly_Revenue
FROM 
    Sales S
JOIN 
    Products P ON S.Product_ID = P.Product_ID
GROUP BY 
    MONTH(S.Transaction_Date)
ORDER BY 
    Month;

SELECT TOP 5 
    P.Product_Name, 
    SUM(S.Quantity * P.Unit_Price) AS Product_Revenue
FROM 
    Sales S
JOIN 
    Products P ON S.Product_ID = P.Product_ID
GROUP BY 
    P.Product_Name
ORDER BY 
    Product_Revenue DESC;



SELECT 
    C.Region, 
    SUM(S.Quantity * P.Unit_Price) AS Regional_Revenue
FROM 
    Sales S
JOIN 
    Products P ON S.Product_ID = P.Product_ID
JOIN 
    Customers C ON S.Customer_ID = C.Customer_ID
GROUP BY 
    C.Region
ORDER BY 
    Regional_Revenue DESC;
