create database Exam_DB
use Exam_DB
create schema mc
---------------------------------------------------------------------------------
--Q1: Write a to display organization hierarchy  
create table [mc].[employee_tbl](
								[emp_id] int primary key,
								[emp_name] varchar(30),
								[manager_id] int,
								[ceo_id] int,
								[vice_president_id] int,
								foreign key ([manager_id]) references [mc].[employee_tbl]([emp_id]),
								foreign key ([vice_president_id]) references [mc].[employee_tbl]([emp_id]),
								foreign key ([ceo_id]) references [mc].[employee_tbl]([emp_id])
								)

insert into [mc].[employee_tbl] ([emp_id], [emp_name], [manager_id], [ceo_id], [vice_president_id]) values
(1, 'CEO John', NULL, 1, NULL),
(2, 'VP Alice', 1 , NULL, 2),
(3, 'Manager Bob', 2, NULL, 3),
(4, 'Employee Carol', 3, 1, NULL),
(5, 'Employee Dave', 3, 1, NULL),
(6, 'VP Eve', 1, NULL, 4),
(7, 'Manager Frank', 6, NULL, 5),
(8, 'Employee Grace', 7, 1, NULL);

select * from [mc].[employee_tbl]

select m.emp_name AS manager,c.emp_name AS CEO,v.emp_name AS VP
FROM [mc].[employee_tbl] AS e
LEFT JOIN 
    [mc].[employee_tbl] AS m ON e.[manager_id] = m.[emp_id]
LEFT JOIN 
    [mc].[employee_tbl] AS c ON e.[ceo_id] = c.[emp_id]
LEFT JOIN 
    [mc].[employee_tbl] AS v ON e.[vice_president_id] = v.[emp_id]

---------------------------------------------------------------------------------
--Q2: Write a query to display count of orders placed by each customer
create table [mc].[customer_tbl](
								[cust_id] int primary key,
								[cust_name] varchar(40),
								[city] varchar(30)
								)

INSERT INTO [mc].[customer_tbl] (cust_id, cust_name, city) VALUES
    (1, 'Rajesh Kumar', 'Mumbai'),
    (2, 'Priya Sharma', 'Delhi'),
    (3, 'Amit Patel', 'Ahmedabad'),
    (4, 'Sneha Singh', 'Bangalore'),
    (5, 'Vikram Verma', 'Chennai'),
    (6, 'Neha Gupta', 'Kolkata');

create table [mc].[order_tbl](
								[or_id] int primary key,
								[order_no] int,
								[order_name] varchar(40),
								[cust_id] int
								unique([order_no])
								)

INSERT INTO mc.order_tbl (or_id, order_no, order_name, cust_id) VALUES
    (1, 1001, 'Electronics Order', 1),
    (2, 1002, 'Clothing Order', 2),
    (3, 1003, 'Furniture Order', 1),
    (4, 1004, 'Appliance Order', 3),
    (5, 1005, 'Book Order', 2),
    (6, 1006, 'Jewelry Order', 6)

select * from [mc].[customer_tbl]
select * from [mc].order_tbl

select c.cust_id,c.cust_name,count(distinct o.or_id) as 'total_order_count'
from [mc].[customer_tbl] as c
join [mc].[order_tbl] as o
on c.[cust_id]=o.cust_id
group by c.cust_id,c.cust_name

---------------------------------------------------------------------------------
--Q3: Write a query to apply union, union all, intersect and except operator.

create table [mc].[Student_tbl_1](
		[std_ID] int  constraint t1_pk primary key,
		[std_name] varchar(50),
		[city] varchar(50),
		[total_marks] int
	);

insert into [mc].[Student_tbl_1]([std_ID],[std_name],[city],[total_marks])values 
(1,'Suvam','kolkata',234),
(2,'susmita','medinipur',452),
(3,'payel','kolkata',567),
(4,'moumita','kolkata',456),
(5,'pranav','medinipur',569),
(6,'Koyel','kolkata',386)

 select * from [mc].[Student_tbl_1];

 
 create TABLE [mc].[Student_tbl_2](
							[std_ID] int  constraint t2_pk primary key,
							[std_name] varchar(50),
							[city] varchar(50),
							[total_marks] int
						);

insert into [mc].[Student_tbl_2]([std_ID],[std_name],[city],[total_marks])values 
(1,'Suvam','kolkata',334),
(2,'susmita','medinipur',462),
(3,'payel','kolkata',567),
(4,'moumita','kolkata',456),
(5,'pranav','medinipur',369),
(6,'Koyel','kolkata',376)

select * from [mc].[Student_tbl_2];


select [std_id],[std_name],[city] 
from 
	[mc].[Student_tbl_1]
UNION
select [std_id],[std_name],[city] 
from 
	[mc].[Student_tbl_2];


select * from [mc].[Student_tbl_1]
UNION ALL
select * from [mc].[Student_tbl_2];


select [std_id],[std_name],[city] 
from 
	[mc].[Student_tbl_1]
intersect
select [std_id],[std_name],[city] 
from 
	[mc].[Student_tbl_2];


select [std_id],[std_name],[total_marks]
from 
	[mc].[Student_tbl_1]
except
select [std_id],[std_name],[total_marks]
from 
	[mc].[Student_tbl_2];

-----------------------------------------------------------------------------------
-- Q4: Write a query using cross & outer apply operator.
Create Table [mc].[Department_tbl](
								[dept_Id] int primary key,
								[Dept_Name] nvarchar(50)
							);
Insert into [mc].[Department_tbl] values (1, 'Manager')
Insert into [mc].[Department_tbl] values (2, 'HR')
Insert into [mc].[Department_tbl] values (3, 'Accounts')
Insert into [mc].[Department_tbl] values (4, 'IT')
Insert into [mc].[Department_tbl] values (5, 'Sales')

select * from [mc].[Department_tbl]


Create table [mc].[Employee_tbl_1](
								[emp_Id] int primary key,
								[emp_Name] nvarchar(50),
								[Gender] nvarchar(10),
								[Salary] int,
								[DepartmentId] int foreign key references [mc].[Department_tbl]([dept_Id])
							);


Insert into [mc].[Employee_tbl_1] values (1, 'Mark', 'Male', 50000, 1)
Insert into [mc].[Employee_tbl_1] values (2, 'Mary', 'Female', 60000, 3)
Insert into [mc].[Employee_tbl_1] values (3, 'Steve', 'Male', 45000, 2)
Insert into [mc].[Employee_tbl_1] values (4, 'John', 'Male', 56000, 1)
Insert into [mc].[Employee_tbl_1] values (5, 'Sara', 'Female', 39000, 2)

create function fn_getEmpByDeptid(@Dept_id int)
returns table
as 
return
(
		select [emp_Id],[emp_Name],[gender],[salary],[DepartmentId]
		from [mc].[Employee_tbl_1]
		where [DepartmentId]=@Dept_id
)

select * from fn_getEmpByDeptID(1)

select d.[dept_Id],e.[emp_Name],e.[Gender],e.[Salary]
from [mc].[Department_tbl] as d
cross apply fn_getEmpByDeptid(d.dept_Id) as e 

select d.[dept_Id],e.[emp_Name],e.[Gender],e.[Salary]
from [mc].[Department_tbl] as d
outer apply fn_getEmpByDeptid(d.dept_Id) as e
------------------------------------------------------------------------------