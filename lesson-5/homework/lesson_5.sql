use TSQLV6;

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');

-----Tasks
---task-1
select 
	   Name,
	   Salary,
	   ROW_NUMBER() OVER (ORDER BY Salary desc) as Unique_rank
from Employees;

---task-2
select 
	Name,
	Salary,
	dense_rank() over(Order by salary desc) as same_rank
from employees
where Salary in(
	Select Salary
	from employees
	Group by Salary 
	Having count(*)>1
);

---task-3
select *from 
(select 
	*,
	ROW_NUMBER() OVER(partition by Department order by salary desc) as rn 
from employees) as sub
where rn<=2
Order by department,rn;

----task-4
select *from 
(select 
	*,
	ROW_NUMBER() OVER(partition by Department order by salary) as rn 
from employees) as sub
where rn<=1
Order by department,rn;

---task-5
select*,
	sum(salary) over(partition by department order by salary rows between unbounded preceding and current row) as sum_salary
from employees;

---task-6
select*,
	sum(salary) over(partition by department order by salary rows between unbounded preceding and unbounded following) as sum_salary
from employees;

--task-7
select*,
	avg(salary) over(partition by department) as avg_salary
from employees;

---task-8
select*,
	salary-Avg(salary) over(partition by department)as Salary_diff 
from employees;

----task-9
select *,
	avg(salary)  over(order by salary rows between 1 preceding and 1 following) as Moving_salary
from employees;

---task-10
select sum(salary) as last_hired
from( 
	 select salary
	 from employees
	 Order by hiredate
	 offset 0 rows fetch next 3 rows only) as last_hired_3;

---task-11
select *,
	  avg(salary) over(order by hiredate rows between unbounded preceding and current row) as running_av
from employees;

---task-12
select *,
		max(salary) over(order by salary rows between 1 preceding and 1 following) as max_salary
from employees;

---task-13
select*,
	Cast((Salary*100/sum(Salary) over(partition by department ))as DECIMAL(10,2))as Percentage
from employees;
