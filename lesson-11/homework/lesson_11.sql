use homework;
drop table if exists employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES
    (1, 'Alice', 'HR', 5000),
    (2, 'Bob', 'IT', 7000),
    (3, 'Charlie', 'Sales', 6000),
    (4, 'David', 'HR', 5500),
    (5, 'Emma', 'IT', 7200);


-- ==============================================================
--                          Puzzle 2 DDL
-- ==============================================================

CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1 VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);


-- ==============================================================
--                          Puzzle 3 DDL
-- ==============================================================

CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

--task-1
create table #EmployeeTransfers(
	EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);
insert into #EmployeeTransfers
VALUES
    (1, 'Alice', 'HR', 5000),
    (2, 'Bob', 'IT', 7000),
    (3, 'Charlie', 'Sales', 6000),
    (4, 'David', 'HR', 5500),
    (5, 'Emma', 'IT', 7200);---this way is 1st way of creating temptable

select* into #EmployeeTransfers from Employees where 1=0; ---it is 2nd way to create temptable
update #EmployeeTransfers
set department=
	case 
		when Department='HR' then 'IT'
		when Department='IT' then 'Sales'
		when Department='Sales' then 'HR'
		else Department
	end
select*from #EmployeeTransfers;

---task-2
declare @MissingOrders table(  --creating the declaration
	 OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
)
insert into @MissingOrders( 
	OrderID ,
    CustomerName,
    Product ,
    Quantity) 
select OrderID ,
    CustomerName,
    Product ,
    Quantity from orders_db1 o1
	where  not exists ( ---find the orders that not exists in orders_db2
		select 1 from orders_db2 o2
			where o2.OrderID=o1.orderid
	)
select*from @MissingOrders

--task-3
create view vw_MonthlyWorkSummary  as ---create a view
select employeeid,employeename,department,
	   sum(hoursworked) over(partition by employeeid) as total_hour_emp,
	   sum(hoursworked) over(partition by department) as total_our_dept,
	   avg(hoursworked) over(partition by department) as avg_our_dept
from WorkLog; --calculations 
select*from vw_MonthlyWorkSummary; ---retrieve all records




