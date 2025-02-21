create database class3;
go
use class3;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY identity(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY identity(1,1),
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);
drop table Products;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY identity(1,1) ,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

insert into employees(
    FirstName,
    LastName,
    Department,
    Salary,
    HireDate
)
values
	('John','Doe','HR','100000','2022-10-29'),
	('Anna','Little','PM','90000','2021-11-29'),
	('Jeck','Brown','SWE','80000','2023-4-29'),
	('Smith','Jacob','SWE','110000','2024-10-29'),
	('Adam','Little','SWA','120000','2023-11-29'),
	('Lisa','Smith','SWE','50000','2021-10-9'),
	('Mikel','Jekson','PM','60000','2020-5-25'),
	('Julie','Black','SWE','30000','2024-12-29'),
	('Sophie','Smith','SWA','150000','2021-11-29'),
	('Lisa','Little','PM','70000','2023-9-25'),
	('George','Wilsam','Cook','30000','2020-10-29')

	select *from  employees

--task-1----

select top 10 percent *  
from employees
order by salary desc;

select department, avg(salary) as avg_salary 
from employees
group by department
Order by avg_salary desc;

select *,
	case
		when salary>=80000 then 'high'
		when salary between 50000 and 80000 then 'medium'
		when salary<50000 then 'low'
		else 'not given'
	end as SalaryCategory
	
from employees
Order by salary desc
offset 2 rows fetch next 5 rows only;
select*from employees;


--task-2

insert into Orders(CustomerName,OrderDate,TotalAmount,Status)
values 
	  ('John','2024-12-20', 222.233 ,'Pending'),
	  ('Doe','2022-12-20',2232.456 ,'Cancelled'),
	  ('Jack','2020-2-29',344.454 ,'Delivered'),
	  ('Smith','2020-12-20', 344.454,'Shipped'),
	  ('George','2022-8-20',443.667 ,'Pending'),
	  ('Lisa','2021-2-10',565.545 ,'Cancelled'),
	  ('Sophia','2020-1-27',664.565 ,'Cancelled'),
	  ('Anna','2023-6-20', 566.656,'Shipped'),
	  ('Adam','2022-10-15',456.565 ,'Cancelled'),
	  ('Mikel','2019-12-20',465.55 ,'Pending'),
	  ('Slayer','2022-3-8',656.5 ,'Shipped'),
	  ('Rose','2020-12-27', 766.555,'Delivered')
select*from Orders;

select 
    CustomerName,
    Status,
	TotalAmount,
    case
        when Status = 'shipped' or Status = 'Delivered' then 'completed'
        when Status = 'Pending' then 'pending'
        when Status = 'Cancelled' then 'cancelled'
    end as OrderStatus,  
    count(*) as TotalOrders,
    sum(TotalAmount) as TotalRevenue
from Orders
where TotalAmount>=500
group by
    CustomerName,
    Status,
	TotalAmount,
    case
        when Status = 'shipped' or Status = 'Delivered' then 'completed'
        when Status = 'Pending' then 'pending'
        when Status = 'Cancelled' then 'cancelled'
    end
order by TotalRevenue desc;

select CustomerName
from Orders
where OrderDate between '2023-01-01'and '2023-12-31';
	

--task-3
insert into Products(ProductName,Category,Price,Stock)
values 
	  ('Laptop','Electronics',700 ,10 ),
	  ('Smartphone','Electronics', 200 , 15 ),
	  ('Chair','Furniture', 50 , 10),
	  ('Coffee maker','kitchen appliance', 100 , 20),
	  ('Brush','house appliance', 10 ,5 ),
	  ('Printer','Electronics',100 , 25 ),
	  ('Vacuum cleaner','house appliance', 100 , 15),
	  ('Airpods','Electronics', 20 , 15 ),
	  ('Bookshelf','house appliance', 100 ,5 ),
	  ('Set of kniwes','kitchen appliance', 100 , 25),
	  ('Table','Furniture', 80 , 10 ),
	  ('Screen','Electronics', 100 ,20 )
select*from Products;


select category, max(Price) as most_expensive 
from Products
group by category;