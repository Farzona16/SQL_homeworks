create database homework_2;
 use homework_2;

 ----task-1-----

 create table test_identity(
	id int identity(1,1) primary key	
 )
 insert into test_identity default values;
 insert into test_identity default values;
 insert into test_identity default values;
 insert into test_identity default values;
 insert into test_identity default values;
 select*from test_identity;

 delete from test_identity;
 insert into test_identity default values;
 insert into test_identity default values;
 insert into test_identity default values;
 insert into test_identity default values;
 insert into test_identity default values;
 select*from test_identity;

 Truncate table test_identity;
 insert into test_identity default values;
 insert into test_identity default values;
 insert into test_identity default values;
 insert into test_identity default values;
 insert into test_identity default values;
 select*from test_identity;

 drop table test_identity;
 create table test_identity(
	id int identity(1,1) primary key	
 )
 insert into test_identity default values;
 insert into test_identity default values;
 insert into test_identity default values;
 insert into test_identity default values;
 insert into test_identity default values;
 select*from test_identity;


 ----task-2----
 use homework_2;
 create table data_types_demo(
	id int,
	char_type char(255),
	varchar_type varchar(7000),
	nchar_type nchar(3000),
	nvarchar_type nvarchar(3999),
	binary_type binary(500),
	varbinary_type varbinary(1000),
	bit_type bit,
	tiny_int tinyint,
	small_int smallint,
	big_int bigint,
	decimal_type decimal(10,2),
	numeric_type numeric(10,2),
	small_money smallmoney,
	money_type money,
	float_type float,
	real_type real,
	datetime_type datetime,
	date_type date,
	xml_type xml
)

insert into data_types_demo(
	id,
	char_type,
	varchar_type,
	nchar_type,
	nvarchar_type,
	binary_type,
	varbinary_type ,
	bit_type ,
	tiny_int ,
	small_int,
	big_int,
	decimal_type,
	numeric_type ,
	small_money ,
	money_type,
	float_type ,
	real_type,
	datetime_type,
	date_type ,
	xml_type
)
values (1,'A','varchar','nchar','nvarchar',0x546869732069732062696E617279,0x546869732069732062696E617279,0,100,300,1233,23234,23.46,223.46,213,1344,1111112.2342,'2024-12-20 23:34:00','2024-12-23','<data><item>Hello</item></data>')
select*from data_types_demo; 

-----task-3------
drop table photos;
create table photos(
	id int	primary key,
	name nvarchar(255),
	varbinary_col varbinary(max)
)

insert into photos
select 2,'nature',BulkColumn from openrowset(
	BULK 'C:\Users\user\Documents\Farzona\MAAB\BI and AI SQL\SQL_homeworks\lesson-2\homework\nature.png', SINGLE_BLOB 
) as img;
select*from photos;

select @@SERVERNAME

----task-4----

create table student(
	classes int,
	tuition_per_class int,
	total_tuition as (classes*tuition_per_class)
)
insert into student(classes,tuition_per_class)
values 
      (5,300),
	  (3,200),
	  (6,100)

select*from student;

---task-5----
create table worker(
	id int,
	name nvarchar(255)
)

bulk insert worker
from 'C:\Users\user\Documents\Farzona\MAAB\BI and AI SQL\SQL_homeworks\lesson-2\homework\workers.csv'
with(
	format='csv',
	firstrow=2,
	fieldterminator=',',
	rowterminator='\n'
);
select*from worker;