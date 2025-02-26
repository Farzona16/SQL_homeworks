use homework;

create table employees(
	Employeeid int primary key identity(1,1),
	name nvarchar(50),
	departmentId int,
	salary int
)
insert into employees(name,departmentId,salary)
values
	('Alice',101,60000),
	('Bob',102,70000),
	('Charlie',101,65000),
	('David',103,72000),
	('Eva',null,68000)

create table departments(
	departmentId int,
	departmentName nvarchar(50))

insert into departments(departmentId,departmentName)
values 
	(101,'IT'),
	(102,'HR'),
	(103,'Finance'),
	(104,'Marketing')

create table projects(
	projectId int Primary key identity(1,1),
	projectName nvarchar(50),
	employeeId int
)

insert into projects(projectName,employeeId)
values
	('Alpha',1),
	('Beta',2),
	('Gamma',3),
	('Delta',4),
	('Omega',Null)

---task-1
select
	e.name, d.departmentName 
from employees as e
join departments as d	
	on e.departmentId=d.departmentId

---task-2
select
	e.name, d.departmentName
from employees as e
left join departments as d
	on e.departmentId=d.departmentId

---task-3
select
	e.name, d.departmentName
from employees as e
right join departments as d
	on d.departmentId=e.departmentId

---task-4
select
	e.name,d.departmentName
from employees as e
full join departments as d
	on d.departmentId=e.departmentId

---task-5
select d.departmentName,
	sum(salary) over(partition by departmentName order by departmentName rows between unbounded preceding and unbounded following) as sum_expense_department
from employees as e ---this window function calculates the sum of salary for each department
right join departments as d
	on d.departmentId=e.departmentId

---task-6
select d.departmentName, p.projectName
from departments as d ---cross join
cross join projects as p

---task-7
select e.name,d.departmentName,p.projectName
from departments as d
right join employees as e ---to include each employee even they dont have the department
	on d.departmentId=e.departmentId
	left join projects as p 
		on p.employeeId=e.employeeId

