use homework;
DROP TABLE IF EXISTS Groupings;

CREATE TABLE Groupings
(
StepNumber  INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NOT NULL,
[Status]    VARCHAR(100) NOT NULL
);
INSERT INTO Groupings (StepNumber, TestCase, [Status]) 
VALUES
(1,'Test Case 1','Passed'),
(2,'Test Case 2','Passed'),
(3,'Test Case 3','Passed'),
(4,'Test Case 4','Passed'),
(5,'Test Case 5','Failed'),
(6,'Test Case 6','Failed'),
(7,'Test Case 7','Failed'),
(8,'Test Case 8','Failed'),
(9,'Test Case 9','Failed'),
(10,'Test Case 10','Passed'),
(11,'Test Case 11','Passed'),
(12,'Test Case 12','Passed');

-----------------------------------------

DROP TABLE IF EXISTS [dbo].[EMPLOYEES_N];

CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
)
 
INSERT INTO [dbo].[EMPLOYEES_N]
VALUES
	(1001,'Pawan','1975-02-21'),
	(1002,'Ramesh','1976-02-21'),
	(1003,'Avtaar','1977-02-21'),
	(1004,'Marank','1979-02-21'),
	(1008,'Ganesh','1979-02-21'),
	(1007,'Prem','1980-02-21'),
	(1016,'Qaue','1975-02-21'),
	(1155,'Rahil','1975-02-21'),
	(1102,'Suresh','1975-02-21'),
	(1103,'Tisha','1975-02-21'),
	(1104,'Umesh','1972-02-21'),
	(1024,'Veeru','1975-02-21'),
	(1207,'Wahim','1974-02-21'),
	(1046,'Xhera','1980-02-21'),
	(1025,'Wasil','1975-02-21'),
	(1052,'Xerra','1982-02-21'),
	(1073,'Yash','1983-02-21'),
	(1084,'Zahar','1984-02-21'),
	(1094,'Queen','1985-02-21'),
	(1027,'Ernst','1980-02-21'),
	(1116,'Ashish','1990-02-21'),
	(1225,'Bushan','1997-02-21');

	select* from groupings
	select*from [dbo].[EMPLOYEES_N]

----task-1

SELECT status, COUNT(*) AS consecutive_count
FROM (
    SELECT status, stepnumber,
        SUM(CASE WHEN status <> LAG(status) OVER (ORDER BY stepnumber) THEN 1 ELSE 0 END)
        OVER (ORDER BY stepnumber ROWS UNBOUNDED PRECEDING) AS grp
    FROM Groupings
) AS sub
GROUP BY status, grp
ORDER BY MIN(stepnumber);





-----lesson_10
drop table if exists orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE
);
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductName VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
INSERT INTO Orders VALUES 
    (1, 'Alice', '2024-03-01'),
    (2, 'Bob', '2024-03-02'),
    (3, 'Charlie', '2024-03-03');
INSERT INTO OrderDetails VALUES 
    (1, 1, 'Laptop', 1, 1000.00),
    (2, 1, 'Mouse', 2, 50.00),
    (3, 2, 'Phone', 1, 700.00),
    (4, 2, 'Charger', 1, 30.00),
    (5, 3, 'Tablet', 1, 400.00),
    (6, 3, 'Keyboard', 1, 80.00)
	
	select*from orders;
	select*from orderdetails


select customername,
	productname,
	quantity,
	unitprice
from(
	select o.orderid,
		o.customername,
		od.productname,
		od.quantity,
		od.unitprice,
		row_number() over(partition by o.customername order by od.unitprice) as rnk
	from orders o
	join orderdetails od
		on od.orderid=o.orderid) as t1
where rnk=1


CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);
INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);