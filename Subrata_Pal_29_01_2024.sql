--1.Create two Tables using all the constraints and maintain relationship between them.     5  
create database [Exam_DB]
use [Exam_DB]
create schema [HR]

create table [hr].[employee_tbl](
							[emp_id] int identity(101,1) constraint [emp_tbl_pk] primary key,
							[emp_name] varchar(30) not null,
							[gender] char(1),
							[city] varchar(20) constraint [emp_tbl_c] default 'Kolkata',
							[age] tinyint constraint [emp_tbl_a] check([age]>17),
							[phone_no] char(10),
							unique([phone_no])
							)
create table [hr].[department_tbl](
								[dept_id] int identity(201,1) constraint [dept_tbl_pk] primary key,
								[dept_name] varchar(30) not null,
								[emp_id] int,
								constraint [dept_tb_fk] foreign key([emp_id]) references [hr].[employee_tbl]([emp_id])
								)

--2.	Write a query by using INSERT INTO SELECT and SELECT INTO.    2+2
create table [hr].[#temp_tbl](
					[emp_id] int primary key,
					[emp_name] varchar(30),
					[gender] varchar(40)
					)

insert into [dbo].[#temp_tbl]
select [emp_id],[emp_name],[gender]
from [hr].[employee_tbl]

select [emp_id],[emp_name],[gender],[city],[age],[phone_no]
into [hr].[temp_tbl] 
from [HR].[employee_tbl]


--3.	Write a query using MERGE INTO statement.      4
--drop table [HR].[target]
create table [HR].[source_tbl](
							[source_id] int primary key,
							[source_name] varchar(50),
							[sour_ammount] decimal(10,2)
							);
create table [HR].[target_tbl](
							[tar_id] int primary key,
							[tar_name] varchar(50),
							[tar_ammount] decimal(10,2)
							)

insert into [HR].[source_tbl] ([source_id],[source_name],[sour_ammount]) values(1,'himon',56438.45),
																			(3,'avik',56456.45),
																			(4,'Santonu',74388.45),
																			(5,'pranav',56456.45)

insert into [HR].[target_tbl] ([tar_id],[tar_name],[tar_ammount]) values(1,'one',65393.45),
																	(2,'two',57923.85),
																	(3,'three',78930.85),
																	(4,'four',837251.45)
select * from 	[HR].[source_tbl]	
select * from [HR].[target_tbl]

merge [HR].[target_tbl] as t using [HR].[source_tbl] as s on [t].[tar_id]=[s].[source_id]
	when matched 
	then 
		update set [tar_name]=[s].[source_name]
	when not matched by target
	then 
		insert ([tar_id],[tar_name],[tar_ammount]) values ([s].[source_id],[s].[source_name],[s].[sour_ammount])
	when not matched by source
	then 
		delete;

--4.	Write queries using update and delete statement by using JOINS.  4
create table [hr].[student](
							[std_id] int primary key,
							[std_name] varchar(30),
							[city] varchar(40)
							)
insert into [hr].[student]([std_id],[std_name],[city]) values 
(101,'sub','kolkata'),(102,'prav','saltlate'),(103,'avik','behala')

create table [hr].[collage](
							[coll_id] int primary key,
							[col_name] varchar(50),
							[std_id] int,
							constraint [collage_tbl_fk] foreign key([std_id]) references [hr].[student]([std_id]) 
							on delete cascade on update cascade
							)
insert into [hr].[collage]([coll_id],[col_name],[std_id]) values 
(201,'XYZ',101),(202,'MCC',101),(203,'IEM',102)

select * from [hr].[student]
select * from [hr].[collage]

delete s 
from [hr].[student] as s
join [hr].[collage] as c on s.[std_id]=c.std_id
where s.[std_id]=101

update [hr].[student]
set std_id=101
from [hr].[student] as s
join [hr].[collage] as c on s.[std_id]=c.std_id
where s.[std_id]=102


--5.	Write a query using CROSS JOIN & SELF JOIN    4
create table [hr].[student_tbl](
								[std_id] int primary key,
								[std_name] varchar(30),
								[age] tinyint,
								[roll_no] int,
								)

insert into [hr].[student_tbl]([std_id],[std_name],[age],[roll_no]) values
(101,'avik',19,111),(102,'pranb',18,112),(103,'rahul',18,113)

create table [hr].[course_tbl](
								[std_id] int primary key,
								[std_name] varchar(30),
								[roll_no] int,
								[course] varchar(30),
								)
drop table 	[hr].[course_tbl]						
insert into [hr].[course_tbl]([std_id],[std_name],[roll_no],[course] ) values (101,'avik',111,'eee')
insert into [hr].[course_tbl]([std_id],[std_name],[roll_no],[course] ) values (102,'pranb',112,'esc'),(103,'rahul',113,'MtG')

select t1.[std_name] , t2.[std_name] 
from [hr].[student_tbl] as t1
inner join[hr].[course_tbl] as t2 on t1.roll_no=t2.roll_no

select * from [HR].[student_tbl]
cross join [hr].[course_tbl]

--6.	Find the duplicate records from a table?       2

create table [hr].[dublicate_tbl](
								[dub_id] int ,
								[dub_name] varchar(30),
								[city] varchar(20)
								)

insert into [hr].[dublicate_tbl]([dub_id],[dub_name],[city])  values (1,'xyz','kolkata'),(1,'ymv','salt lake'),(2,'fmv','kolkata')

SELECT [dub_id], COUNT([dub_id]) as 'total_dublicate_element'
FROM [hr].[dublicate_tbl]
GROUP BY [dub_id]
HAVING COUNT([dub_id]) > 1


--7.	Show Salary to add comma/period. (5000000 -> 5,000,000)      
select salary=FORMAT(5000000,'c')
select salary=REPLACE(FORMAT(5000000,'c'),'$','c')



--8.	Show difference between two dates as DD: HH:MM format.                                                  


SELECT DATEDIFF(year, '2024-01-01 12:00:00', '2024-01-15 18:30:00') AS DateDiff;
SELECT DATEDIFF(MONTH, '2024-01-01 12:00:00', '2024-01-15 18:30:00') AS DateDiff;
SELECT DATEDIFF(DAY, '2024-01-01 12:00:00', '2024-01-15 18:30:00') AS DateDiff;
SELECT DATEDIFF(HOUR, '2024-01-01 12:00:00', '2024-01-15 18:30:00') AS DateDiff;
SELECT DATEDIFF(MINUTE, '2024-01-01 12:00:00', '2024-01-15 18:30:00') AS DateDiff;

--9.	Write a query to insert data from excel worksheet.  2
create table [hr].[excel_tbl](
							[ex_id] int primary key,
							[ex_name] varchar(30),
							[city] varchar(40)
							);

bulk insert [hr].[excel_tbl]
from 'E:\Subrata Pal\Ass_29_01_2024.csv'
with
(
	fieldterminator=',',
	rowterminator='\n',
	firstrow=2
)
select * from [hr].[excel_tbl]




--10.	Explain foreign key rules by giving examples.       3
--foreign key : Relationship between two or more tables we use foreign key.one table primary key is referenced into another table so that we can uniquely identify each record 
-- from both the table.In that relationship we can retribe the the data from both table
--there are some rules for foreign key 
--i) the column name should be same or different ( doesn't mater but the column name should be meaningfull)
--ii) the data type should be same 
--iii)size can be different/same its upto user
--iv) add a constraint for foreign key if we don't add constraint sql server autometically generate a constraint for foerign key 
--v) to add the foreign key to establish the connection between two tables we have to comma separation 
--example:

create table [HR].[parant_tbl](
								[p_id] int identity(101,1) constraint [par_tbl_pk] primary key,
								[p_name] varchar(30) not null,
								)

create table [HR].[child_tbl](
								[c_id] int identity(101,1) constraint [ch_tbl_pk] primary key,
								[c_name] varchar(30) not null,
								[p-id] int,
								constraint [child_tbl_fk] foreign key([p-id]) references [HR].[parant_tbl]([p_id])
								)


DECLARE @StartDate DATETIME = '2024-01-01 12:00:00';
DECLARE @EndDate DATETIME = '2024-01-15 18:30:00';

DECLARE @TimeDiff INT = DATEDIFF(MINUTE, @StartDate, @EndDate);

SELECT 
    CONVERT(VARCHAR(5), @TimeDiff / (24 * 60)) + ':' +  -- Days
    RIGHT('0' + CONVERT(VARCHAR(2), (@TimeDiff % (24 * 60)) / 60), 2) + ':' +  -- Hours
    RIGHT('0' + CONVERT(VARCHAR(2), @TimeDiff % 60), 2) AS TimeDifference;

select CONCAT(
				cast(datediff(DAY, '2024-01-01','2024-01-15')as varchar),
				':',
				cast(datediff(HOUR, '2024-01-01','2024-01-15')as varchar),
				':',
				cast(datediff(minute, '2024-01-01','2024-01-15')as varchar),
				':',
				cast(datediff(SECOND, '2024-01-01','2024-01-15')as varchar)
			)


create schema MCC          

create table [mcc].[student_tbl](
								[std_id] int primary key,
								[std_name] varchar(30),
								[subject] varchar(20)
								)

insert into [mcc].[student_tbl]([std_id],[std_name],[subject]) values (1,'Subrata','RDBMS'),(2,'pranab','data structure'),(3,'rahul','accounts'),
(4,'annesha','english')
select * from [mcc].[student_tbl]

create table [mcc].[course_tbl](
								[cour_id] int primary key,
								[cour_name] varchar(40),
								[cour_grade] char(1),
								[std_id] int,
								constraint [cour_tbl_fk] foreign key ([std_id]) references [mcc].[student_tbl]([std_id])
								)

insert into [mcc].[course_tbl]([cour_id],[cour_name],[cour_grade],[std_id]) values
(1,'Computer Science','A',1),(2,'Arts','C',2),(3,'Science','A',3)

insert into [mcc].[course_tbl]([cour_id],[cour_name],[cour_grade]) values
(4,'Science','A')
select *from [mcc].[course_tbl]

select s.[std_id],s.std_name
from [mcc].[student_tbl] as s
inner join [mcc].[course_tbl] as c on s.std_id=c.std_id

select s.[std_id],s.std_name
from [mcc].[student_tbl] as s
left outer join [mcc].[course_tbl] as c on s.std_id=c.std_id
where c.std_id is null

select s.[std_id],s.std_name
from [mcc].[student_tbl] as s
inner join [mcc].[course_tbl] as c on s.std_id=c.std_id
union 
select s.[std_id],s.std_name
from [mcc].[student_tbl] as s
left outer join [mcc].[course_tbl] as c on s.std_id=c.std_id
where c.std_id is null