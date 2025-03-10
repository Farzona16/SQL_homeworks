create database class9;
use class9;
CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');


--task-1
with table_with_depth as (
	select employeeid, managerid, jobtitle, 0 as depth
	from employees 
	where managerid is null
	union all
	select e.employeeid, e.managerid, e.jobtitle, eh.depth+1 --depth must be greater 1 from employeeid 
	from employees e
	join table_with_depth eh
		on e.managerid=eh.employeeid
)
select * from table_with_depth

--task-2
with factorial as(
	select 1 as n, 1 as fact
	union all
	select n+1,fact*(n+1)
	from factorial
	where n<10)
select*from factorial


--task-3
with fibonacci(n,fib_num,prev_num) as(
	select 1,1,0
	union all
	select n+1,fib_num+prev_num,fib_num
	from fibonacci
	where n<10
)
select n,fib_num from fibonacci