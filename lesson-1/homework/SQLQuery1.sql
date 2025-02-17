CREATE DATABASE homework;

USE homework;


CREATE TABLE student(
	id int,
	name VARCHAR(50),
	age int 
)

ALTER TABLE student
ALTER COLUMN id int NOT NULL; 
--TASK1 COMPLETED--

CREATE TABLE product(
	product_id int UNIQUE,
	product_name VARCHAR(50),
	price VARCHAR(50)
	)

ALTER TABLE product
DROP CONSTRAINT unique_product;

ALTER TABLE product
ADD CONSTRAINT unique_product UNIQUE(product_id);

ALTER TABLE product
ADD CONSTRAINT unique_product UNIQUE(product_id,product_name);
---task2 was completed---


---task-3----
CREATE TABLE orders(
	order_id int PRIMARY KEY,
	customer_name VARCHAR(50),
	order_date date 
)
 ALTER TABLE orders
 DROP CONSTRAINT PK__orders__465962290ABD5487;

 ALTER TABLE orders
 ADD CONSTRAINT PK_orders PRIMARY KEY (order_id);
 ---TASK-3 completed----


 CREATE TABLE category(
	category_id int,
	category_name VARCHAR(50),
	CONSTRAINT PK_category PRIMARY KEY(category_id)
 )
 CREATE TABLE item(
	item_id int,
	item_name VARCHAR(50),
	category_id int,
	PRIMARY KEY (item_id),
	CONSTRAINT FK_item FOREIGN KEY (category_id)
	REFERENCES category(category_id)
)
ALTER TABLE item
DROP CONSTRAINT FK_item;

ALTER TABLE item
ADD CONSTRAINT FK_item FOREIGN KEY(category_id) REFERENCES category(category_id);
----task-4 completed----

CREATE TABLE account(
	account_id int PRIMARY KEY,
	balance	DECIMAL(10,2),
	account_type VARCHAR(255),
	CONSTRAINT CHECK_account CHECK (balance>=0  AND account_type IN ('Saving','Checking'))
)

ALTER TABLE account
DROP CONSTRAINT CHECK_account;

ALTER TABLE account
ADD CONSTRAINT CHECK_account CHECK (balance>=0 AND account_type IN ('Saving','Checking'));
----TASK-5 COMPLETED----

----task-6----
CREATE TABLE customer(
	customer_id int PRIMARY KEY,
	name VARCHAR(50),
	city VARCHAR(50) DEFAULT 'Unknown'
)
ALTER TABLE customer
DROP CONSTRAINT DF__customer__city__74AE54BC;

ALTER TABLE customer
ADD CONSTRAINT DF_CITY DEFAULT 'Unknown' for city;


---task-7----
CREATE TABLE invoice(
	invoice_id int IDENTITY(1,1) PRIMARY KEY,
	amount DECIMAL(10,2),
)
INSERT INTO invoice(amount)
VALUES 
	(25.5),
	(345.5),
	(34.4),
	(344),
	(22);

SET IDENTITY_INSERT invoice ON;
INSERT INTO invoice(invoice_id,amount)
values(234,235);
SET IDENTITY_INSERT invoice OFF;
select*from invoice;

----task-8----
CREATE TABLE books(
	book_id int PRIMARY KEY IDENTITY,
	title NVARCHAR(255) NOT NULL,
	price DECIMAL(10,2) CONSTRAINT CH_P CHECK (price>0),
	genre NVARCHAR(255) CONSTRAINT DF_G DEFAULT 'Unknown' 
)
INSERT INTO books(title,price)
VALUES
	('Thieves',-4)
	

select*from books

----task-9----
CREATE TABLE book(
	book_id int PRIMARY KEY,
	title NVARCHAR(255),
	author NVARCHAR(255),
	published_year int 
)

CREATE TABLE member(
	member_id int PRIMARY KEY,
	name NVARCHAR(255),
	email NVARCHAR(255) UNIQUE,
	phone_number NVARCHAR(255)
)

CREATE TABLE loan(
	loan_id int PRIMARY KEY,
	book_id int not null,
	member_id int not null,
	loan_date date not null,
	return_date date ,
	Constraint fk_book foreign key (book_id) references book(book_id), 
	Constraint fk_member foreign key (member_id) references member(member_id)
)
insert into book(book_id,title,author,published_year)
values
	(1,'1st book','qwewry',2013),
	(2,'2nd book','asdvfgg',2015),
	(3,'3rd book','vfgg',2014);

select*from book;

insert into member(member_id,name,email,phone_number)
values
	(1,'John','@John',233344444),
	(2,'Anna','@Anna',23445699);
select*from member;

insert into loan(loan_id,book_id,member_id,loan_date,return_date)
values
	(1,1,1,'2024-12-13','2024-12-31'),
	(2,2,2,'2024-12-23',Null);
select*from loan;

select*from book;
select*from member;
select*from loan;

