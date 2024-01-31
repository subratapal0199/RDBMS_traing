create database Exam_DB
create schema mcc

--Q1: Write a query to implement scope_identity() and IIF(). 
--drop database Exam_DB

create table [mc].[temp_tbl](
							[temp_id] int identity(101,1) primary key,
							[tem_name] varchar(30)
							)
insert into [MC].[temp_tbl](tem_name) values('Avik'),('Souvik'),('Pranav')

select * from [MC].[temp_tbl]
-- it will display ta last identity value
select SCOPE_IDENTITY()

--Write a query to implement IIF()
select IIF(100<50, 'YES', 'NO');  -- it will display NO
select IIF(100<109, 'YES', 'NO'); -- it will display Yes


--Q2: Write quries to implement stuff and format function. 
select STUFF('My name is Subrata Pal',1,2,'His')  -- it will start the delete from 1  and end it 2. so it will delete only my and replaced by his


declare @d date=getdate() --- store the current date in the variable @d 
select FORMAT(@d,'dd/MM/yyyy') -- so we can assses the date from @d

--anoter way dsipaly. i want to display XXXXXXXXX in the value 657398729
select FORMAT(657398729,'XXXX-XXX-XX')



--Q4: Write a query to display the rank of using dense_rank() function.
create table [mc].[employee_tbl](
								[emp_id] int primary key,
								[emp_name] varchar(30),
								[city] varchar(40),
								[salary] money,
								[dept_id] int
								)


insert into [mc].[employee_tbl] values
(1, 'Subrata', 'Kolkata', 50000.00, 1),
(2, 'Avik', 'Salt lake', 60000.00, 2),
(3, 'Krishna', 'Salt lake', 55000.00, 1),
(4, 'Rahul', 'Behala', 65000.00, 3),
(5, 'pranav', 'sectoer v ', 70000.00, 2),
(6, 'Annesha', 'City center', 48000.00, 1),
(7, 'Rahul', 'krishnanagr', 52000.00, 4),
(8, 'Brisnu', 'moon', 58000.00, 1),
(9, 'Mahadev', 'Himalay', 62000.00, 2),
(10, 'durga', 'morte', 54000.00, 3);

select * from [MC].[employee_tbl]

SELECT * FROM (
SELECT [emp_id],[emp_name],[city],[salary],[dept_id], dense_rank () OVER (
PARTITION BY [dept_id]
ORDER BY [salary] DESC
) dept_rank
FROM [mc].[employee_tbl]
) d

drop table [MC].[employee_tbl]
--Q3: Delete duplicate data from a table using rownumber function. 
-- so i created a table in previous question now i use it here 
insert into [mc].[employee_tbl] values
(11, 'Avishek', 'Kolkata', 58000.00, 1),
(12, 'kumar', 'Himalay', 62000.00, 2),
(13, 'durga', 'salt lake', 54000.00, 3),
(14, 'Brisnu', 'kolkata', 58000.00, 1),
(15, 'Mahadev', 'Himalay', 62000.00, 2),
(16, 'durga', 'morte', 54000.00, 3);

select * from [mc].[employee_tbl]

with cte as(
select *, ROW_NUMBER() over(partition by dept_id order by city) as rowNumber
from [MC].[employee_tbl]
)
delete from cte where rowNumber>1









