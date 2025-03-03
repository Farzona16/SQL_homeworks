use homework_2;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);
INSERT INTO Customers VALUES 
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Orders VALUES 
(101, 1, '2024-01-01'), (102, 1, '2024-02-15'),
(103, 2, '2024-03-10'), (104, 2, '2024-04-20');

INSERT INTO OrderDetails VALUES 
(1, 101, 1, 2, 10.00), (2, 101, 2, 1, 20.00),
(3, 102, 1, 3, 10.00), (4, 103, 3, 5, 15.00),
(5, 104, 1, 1, 10.00), (6, 104, 2, 2, 20.00);

INSERT INTO Products VALUES 
(1, 'Laptop', 'Electronics'), 
(2, 'Mouse', 'Electronics'),
(3, 'Book', 'Stationery');



---task-1----
select c.customername,
	   o.orderId,
	   o.orderdate
from customers as c
left join orders as o
	on c.customerid=o.customerid

---task-2
select c.customername
from customers as c
left join orders as o
	on c.customerid=o.customerid
where o.orderid is null

---task-3
select
	   o.orderid,
	   p.productname,
	   od.quantity
from orders as o
join orderdetails as od
	on o.orderid=od.orderid
join products as p
	on od.productid=p.productid

---task-4---
select c.customername,
	count(o.customerid)
from customers as c
join orders as o
	on c.customerId=o.customerid
group by o.customerid,c.customername
having count(o.customerid)>1

--task-5
select o.orderid, 
	  p.productname,
	  od.price
from orders as o
join orderdetails as od	
	on o.orderid=od.orderid
join products as p
	on od.productid=p.productid
where od.price=(
	select max(od2.price)
	from orderdetails as od2 ---for finding the query 
		where od2.orderid=od.orderid
);

---task-6
select  c.customername,
	max(o.orderdate)
from customers as c
join orders as o
	on c.customerid=o.customerid
group by c.customerid,c.customername

---task-7
select c.customername
from customers as c
join orders as o
	on c.customerid=o.customerid
join orderdetails od
	on od.orderid=o.orderid
join products p
	on p.productid=od.productid	
group by c.customerid, c.customername
having sum(case when p.category='electronics' then 1 else 0 end)=count(*);

---task-8
select c.customername
from customers as c
join orders as o
	on o.customerid=c.customerid
join orderdetails as od
	on od.orderid=o.orderid
join products as p
	on p.productid=od.productid
where p.category='stationery'

--task-9
select distinct c.customerid, c.customername,
		sum(od.price*od.quantity) over(partition by c.customerid) as total_spent
from customers c
left join orders o
	on o.customerid=c.customerid
left join orderdetails od
	on od.orderid=o.orderid

