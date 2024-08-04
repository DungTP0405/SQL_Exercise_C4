-- --USE MX4

-- -----------------------------------------
-- -- Build the Schema
-- -----------------------------------------

-- CREATE TABLE Departments (
--   Code INTEGER PRIMARY KEY,
--   Name varchar(255) NOT NULL ,
--   Budget decimal NOT NULL 
-- );

-- CREATE TABLE Employees (
--   SSN INTEGER PRIMARY KEY,
--   Name varchar(255) NOT NULL ,
--   LastName varchar(255) NOT NULL ,
--   Department INTEGER NOT NULL , 
--   foreign key (department) references Departments(Code) 
-- );

-- INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
-- INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
-- INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
-- INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

-- INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
-- INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
-- INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
-- INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
-- INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
-- INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','ODonnell',77);
-- INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
-- INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
-- INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
-- INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
-- INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
-- INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);

SELECT * FROM Departments
SELECT * FROM Employees

-- 2.1 Select the last name of all employees.
SELECT Lastname
FROM Employees

-- 2.2 Select the last name of all employees, without duplicates.
SELECT DISTINCT Lastname
FROM Employees

-- 2.3 Select all the data of employees whose last name is "Smith".
SELECT *
FROM Employees
WHERE Lastname = 'Smith'

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
SELECT *
FROM Employees
WHERE Lastname IN ('Smith', 'Doe')

-- 2.5 Select all the data of employees that work in department 14.
SELECT *
FROM Employees
WHERE Department = 14

-- 2.6 Select all the data of employees that work in department 37 or department 77.
SELECT *
FROM Employees
WHERE Department = 37 OR Department = 77

-- 2.7 Select all the data of employees whose last name begins with an "S".
SELECT *
FROM Employees
WHERE LEFT(Lastname,1) = 'S'

-- 2.8 Select the sum of all the departments' budgets.
SELECT SUM (Budget)
FROM Departments

-- 2.9 Select the number of employees in each department (you only need to 
--show the department code and the number of employees).
SELECT Department, COUNT(*) AS [Total employee]
FROM Employees
GROUP BY Department

-- 2.10 Select all the data of employees, including each employee's department's data.
SELECT e.*,
        d.Name as [Department name],
        Budget
FROM Employees e
JOIN Departments d
ON Department = Code

-- 2.11 Select the name and last name of each employee, along with the name and budget 
-- of the employee's department.
SELECT e.Name as [Employee name],
        Lastname,
        d.Name as [Department name],
        Budget
FROM Employees e
JOIN Departments d
ON Department = Code

-- 2.12 Select the name and last name of employees working for departments 
-- with a budget greater than $60,000.
SELECT e.Name as [Employee name],
        Lastname
FROM Employees e
JOIN Departments d
ON Department = Code
WHERE budget > 60000

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
SELECT Code, Name
FROM Departments
WHERE Budget > (SELECT  AVG(Budget) FROM Departments)

-- 2.14 Select the names of departments with more than two employees.
WITH cte AS (
    SELECT Department, COUNT(*) AS [Total employee]
    FROM Employees
    GROUP BY Department
)

SELECT d.Name
FROM cte c 
JOIN Departments d 
ON c.Department = d.Code
WHERE [Total employee] > 2

-- 2.15 Very Important - Select the name and last name of employees working for departments 
--with second lowest budget.
SELECT Name, Lastname
FROM (
    SELECT e.Name,
            e.Lastname,
            DENSE_RANK() OVER(ORDER BY  Budget) AS RANK
    FROM Employees e
    JOIN Departments d ON e.Department = d.Code
    ) AS A
WHERE RANK = 2

-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 
-- and departmental code 11. 
INSERT INTO Departments(Code,Name,Budget) VALUES(11,'Quality Assurance',40000);

-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('847219811','Mary','Moore',11);

-- 2.17 Reduce the budget of all departments by 10%.
SELECT *, Budget*0.9 AS [Reduced budget]
FROM Departments

-- 2.18 Reassign all employees from the Research department (code 77) to 
--the IT department (code 14).
UPDATE Employees
SET Department = 14
WHERE Department = 77

-- 2.19 Delete from the table all employees in the IT department (code 14).
DELETE FROM Employees
WHERE Department =14

-- 2.20 Delete from the table all employees who work in departments with a budget 
--greater than or equal to $60,000.

DELETE FROM Employees
WHERE Department IN (
                SELECT Code
                FROM Departments
                WHERE Budget >= 60000
                )   

-- 2.21 Delete from the table all employees.
DELETE FROM Employees