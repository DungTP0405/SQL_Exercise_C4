-- USE MX4
-- DROP TABLE pizza_sales
-- CREATE TABLE pizza_sales (
--     pizza_id INT,
--     order_id INT,
--     pizza_name_id VARCHAR(255),
--     quantity INT,
--     order_date DATE,
--     order_time TIME,
--     unit_price DECIMAL(10, 2),
--     total_price DECIMAL(10, 2),
--     pizza_size VARCHAR(5),
--     pizza_category VARCHAR(255),
--     pizza_ingredients TEXT,
--     pizza_name VARCHAR(255)
-- );

-- BULK INSERT pizza_sales
-- FROM 'C:\Users\ASUS\Downloads\pizza_sales.csv'
-- WITH
-- (
--     FIELDTERMINATOR = ',',
--     ROWTERMINATOR = '\n',
--     FIRSTROW = 2,
--     FORMAT = 'CSV'
-- );

SELECT TOP 5 *
FROM pizza_sales
--
-- A. KPI

--1. Total revenue
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales

--2. Average Order Value
SELECT AVG(order_value) AS Avg_order_Value
FROM (
    SELECT order_id
            , SUM(total_price) AS order_value
    FROM pizza_sales
    GROUP BY order_id) AS A

--3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold
FROM pizza_sales

--4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales

--5. Average Pizzas Per Order
SELECT CAST(ROUND(AVG(total_quantity), 2) AS DECIMAL(10, 2)) AS Avg_pizzas_per_order
FROM (
    SELECT order_id
            , SUM(quantity)*1.0 AS total_quantity
    FROM pizza_sales
    GROUP BY order_id) AS A

--B. Daily Trend for Total Orders
SELECT day_of_week
        , COUNT(DISTINCT order_id) AS Total_orders
FROM (
    SELECT 
        FORMAT(CONVERT(date, order_date, 105), 'dddd') AS day_of_week,
        order_id
    FROM pizza_sales) AS a
GROUP BY day_of_week

--C. Monthly Trend for Orders

SELECT Month_Name
        , COUNT(DISTINCT order_id) AS Total_oders
FROM (
    SELECT 
        DATENAME(month, CONVERT(date, order_date, 105)) AS Month_Name,
        order_id
    FROM pizza_sales) AS a
GROUP BY Month_Name

--D. % of Sales by Pizza Category
SELECT *
        , CAST(ROUND(total_revenue/(SELECT SUM(total_price) FROM pizza_sales) *100,2)
                 AS DECIMAL(10, 2)) AS PCT
FROM (
    SELECT pizza_category
            , SUM(total_price) AS total_revenue
    FROM pizza_sales
    GROUP BY pizza_category) AS a 

--E. % of Sales by Pizza Size
SELECT *
        , CAST(ROUND(total_revenue/(SELECT SUM(total_price) FROM pizza_sales) *100,2)
                 AS DECIMAL(10, 2)) AS PCT
FROM (
    SELECT pizza_size
            , SUM(total_price) AS total_revenue
    FROM pizza_sales
    GROUP BY pizza_size) AS a 
ORDER BY PCT DESC

--F. Total Pizzas Sold by Pizza Category
SELECT pizza_category
        , SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

--G. Top 5 Pizzas by Revenue
SELECT TOP 5 pizza_name
            , SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

--H. Bottom 5 Pizzas by Revenue
SELECT TOP 5 pizza_name
            , SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue

--I. Top 5 Pizzas by Quantity
SELECT TOP 5 pizza_name
            , SUM(quantity) AS Total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_pizza_sold DESC

--J. Bottom 5 Pizzas by Quantity
SELECT TOP 5 pizza_name
            , SUM(quantity) AS Total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_pizza_sold

--K. Top 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name
            , COUNT(DISTINCT order_id) AS Total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_pizza_sold DESC

--L. Borrom 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name
            , COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders