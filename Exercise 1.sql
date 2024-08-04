-- Create database MX4

-- Use MX4
-- CREATE TABLE Manufacturers (
--   Code INTEGER,
--   Name VARCHAR(255) NOT NULL,
--   PRIMARY KEY (Code)   
-- );

-- CREATE TABLE Products (
--   Code INTEGER,
--   Name VARCHAR(255) NOT NULL ,
--   Price DECIMAL NOT NULL ,
--   Manufacturer INTEGER NOT NULL,
--   PRIMARY KEY (Code), 
--   FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
-- );

-- INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
-- INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
-- INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
-- INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
-- INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
-- INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');

-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);


SELECT * FROM Products

-- 1.1 Select the names of all the products in the store.
SELECT DISTINCT NAME FROM Products

-- 1.2 Select the names and the prices of all the products in the store.
SELECT DISTINCT Name, Price FROM Products

-- 1.3 Select the name of the products with a price less than or equal to $200.
SELECT Name
FROM Products
WHERE Price <= 200

-- 1.4 Select all the products with a price between $60 and $120.
SELECT Name
FROM Products
WHERE price BETWEEN 60 AND 120

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
SELECT Name,
        Price*100 AS [Price in cents]
FROM Products

-- 1.6 Compute the average price of all the products.
SELECT AVG(Price)
FROM Products

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
SELECT AVG(Price)
FROM Products
WHERE code = 2

-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT COUNT(DISTINCT Name)
FROM Products
WHERE Price >=180

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, 
-- and sort first by price (in descending order), and then by name (in ascending order).
SELECT Name, Price
FROM Products
WHERE Price >= 200
ORDER BY PRICE DESC, NAME

-- 1.10 Select all the data from the products, including all the data for each 
--product's manufacturer.

-- 1.11 Select the product name, price, and manufacturer name of all the products.
SELECT Name, Price, Manufacturer
FROM Products

-- 1.12 Select the average price of each manufacturer's products, showing only the 
--manufacturer's code.
SELECT Manufacturer, 
        AVG(Price) AS [Avg price]
FROM Products
GROUP BY Manufacturer

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.

-- 1.14 Select the names of manufacturer whose products have an average price larger 
--than or equal to $150.
SELECT Manufacturer
FROM Products
GROUP BY Manufacturer
HAVING AVG(Price) >= 150

-- 1.15 Select the name and price of the cheapest product.
SELECT Name, Price
FROM Products
WHERE Price = (SELECT MIN (Price) FROM Products)

-- 1.16 Select the name of each manufacturer along with the name and price of its most 
--expensive product.

WITH cte AS (
    SELECT Manufacturer, MAX(Price) as Max
    FROM Products
    GROUP BY Manufacturer   
)

SELECT m.Name, p.Name, Price
FROM Products p
JOIN cte c ON p.Manufacturer = c.Manufacturer
                AND p.Price = c. Max
JOIN Manufacturers m ON p.Manufacturer = m.Code

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO Products VALUES (11, 'Loudspeakers', 70, 2)

-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE Products
SET Name = 'Laser Printer'
WHERE Code = 8

-- 1.19 Apply a 10% discount to all products.
SELECT *, Price*0.9 AS [Discounted price]
FROM Products

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
SELECT *,
        CASE
            WHEN Price >= 120 THEN Price*0.9
            ELSE Price
        END [New price]
FROM Products