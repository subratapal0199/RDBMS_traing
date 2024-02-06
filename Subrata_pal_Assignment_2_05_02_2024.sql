--Subrata Pal -

create database Exam_DB
use Exam_DB
create schema mcc
---------------------------------------------------------------------------------------------
--1.	Write a query using Inline View.  2
-- I create a student table
create table [mcc].[Student_tbl](
								[std_id] int primary key,
								[std_name] varchar(30),
								[RDBMS] dec(10,2),
								[Java] dec(10,2)
								)
insert into [mcc].[Student_tbl]values(1,'Subrata',84.32,65.64),(2,'Rahul',66.45,75.45)
insert into [mcc].[Student_tbl]values(3,'Pranav',98.45,87.45)

select * from [mcc].[Student_tbl]

select
	[std_id],
	[std_name],
	[RDBMS],
	[java],
    totalMarks,
	case
        WHEN TotalMarks >= 150 THEN 'A'
        WHEN TotalMarks >= 100 AND TotalMarks < 150 THEN 'B'
        ELSE 'F'
    END as 'Grade'
FROM (
		select std_id,std_name,Rdbms,java,
		isnull(RDBMS,0)+isnull(Java,0) as totalmarks
			from 
				[mcc].[Student_tbl]
		) as totalmarksdetails
------------------------------------------------------------------------------------------------
/*2.	Print the following pattern in SQL Server                                                                                       2
*
**
***
****
*****
*/
declare @i int =1
while @i<6
begin 
	print replicate('*',@i)
	set @i=@i+1
end
----------------------------------------------------------------------------------------------
--3.Write a SQL Query to find the first Week Day of the month? 

select datename(weekday,getdate()) as date
select datename(WEEKDAY,'2024/01/01') as date


select
    case
        when DATEPART(WEEKDAY, GETDATE()) = 1 then 'Monday'
        when DATEPART(WEEKDAY, GETDATE()) = 2 then 'Tuesday'
        when DATEPART(WEEKDAY, GETDATE()) = 3 then 'Wednesday'
        when DATEPART(WEEKDAY, GETDATE()) = 4 then 'Thursday'
        when DATEPART(WEEKDAY, GETDATE()) = 5 then 'Friday'
    end as FirstWeekdayOfMonth;

----------------------------------------------------------------------------------
--4.How to find the 6th highest salary from the Employee table?                   3

create table [mcc].[Employee_tbl](
								[emp_id] int primary key,
								[emp_name] varchar(30),
								[gender] char(6),
								[salary] money
								)
insert into [mcc].[Employee_tbl] ([emp_id], [emp_name], [gender], [salary])values
(1, 'Rahul Sharma', 'Male', 50000.00),
(2, 'Priya Patel', 'Female', 45000.00),
(3, 'Amit Singh', 'Male', 55000.00),
(4, 'Neha Kapoor', 'Female', 48000.00),
(5, 'Raj Malhotra', 'Male', 60000.00),
(6, 'Ananya Gupta', 'Female', 52000.00),
(7, 'Vikram Verma', 'Male', 58000.00),
(8, 'Shreya Joshi', 'Female', 51000.00),
(9, 'Arjun Saxena', 'Male', 62000.00),
(10, 'Pooja Khanna', 'Female', 54000.00);

select * from [mcc].[Employee_tbl]

with cte as(
		select [emp_id],[emp_name],[gender],[salary],
		row_number() over (order by salary desc) as SalaryRank
   from 
        [mcc].[Employee_tbl]
)
select [emp_id],[emp_name],[gender],[salary]
from cte
where
    SalaryRank = 6
----------------------------------------------------------------------------------------
--5.Write a query by using ANY & ALL operator?                                         3
select * from [mcc].[Student_tbl]

alter table [mcc].[Student_tbl] add dept_id int
update [mcc].[Student_tbl] 
set dept_id=1
where std_id=1

update [mcc].[Student_tbl] 
set dept_id=1
where std_id=2

update [mcc].[Student_tbl] 
set dept_id=3
where std_id=3

insert into [mcc].[Student_tbl] ([std_id],[std_name], [RDBMS], [Java],[dept_id]) values
(4, 'Ravi Kumar', 76, 67, 2),
(5, 'Priya Sharma', 54, 76, 3),
(6, 'Amit Patel', 76, 78, 4),
(7, 'Neha Singh', 67, 67, 1),
(8, 'Raj Malhotra', 63, 87, 4),
(9, 'Ananya Gupta', 87, 78, null);

select * from [mcc].[Student_tbl]

--Any
select [std_id],[std_name],[dept_id]
from 
	[mcc].Student_tbl
where dept_id =any(select [dept_id] from [mcc].[Student_tbl] where dept_id in (1,3,5))


--all
select [std_id],[std_name],[dept_id]
from 
	[mcc].Student_tbl
where [dept_id] >all(select dept_id from [mcc].[Student_tbl] where [dept_id] between 1 and 3)
----------------------------------------------------------------------------------------------
--6.Assign a rank to each movie based on the ordering of their release dates.                2
create table [mcc].[movie_tbl](
								[movie_id] int primary key,
								[movie_name] varchar(50),
								[release_date] date
								);
insert into [mcc].[movie_tbl] ([movie_id],[movie_name],[release_date]) values
(1, 'Dangal', '2016-12-23'),
(2, 'PK', '2014-12-19'),
(3, 'Baahubali 2: The Conclusion', '2016-12-23'),
(4, 'Padmaavat', '2018-01-25'),
(5, 'Lagaan', '2014-12-19'),
(6, '3 Idiots', '2017-01-25'),
(7, 'Chennai Express', '2013-08-09');

insert into [mcc].[movie_tbl] ([movie_id],[movie_name],[release_date]) values
(8,'Chichoree', '2001-08-09');


select * 
from (select 
		[movie_id],	
		[movie_name],
		[release_date], 
		DENSE_RANK() over(
		order by [release_date] desc
		) as release_rank
from [mcc].[movie_tbl]
) t

-------------------------------------------------------------------------------------------
--7.Display the count of movies for each genre in a pivoted format.						  3
select * from [mcc].[movie_tbl]
alter table [mcc].movie_tbl add [genre] varchar(20)

update [mcc].[movie_tbl]
set [genre]='Horror'
where movie_id in (1,3,5)

update [mcc].[movie_tbl]
set [genre]='Drama'
where movie_id in (2,7)

update [mcc].[movie_tbl]
set [genre]='Thiler'
where movie_id in (4,8,6)

select 
		[Horror],
		[Drama],
		[thiler]
from(
		select [movie_name],[genre]
		from 
			[mcc].[movie_tbl]
		) as pivot_data
pivot(
		count(movie_name) for genre
		in ([Horror],[Drama],[thiler])
	) as pivot_table
------------------------------------------------------------------------------------------
--8.Display students who have enrolled in more than one course.							  3
select * from [mcc].[Student_tbl]  -- this is an old table i only use std_id and std_name

create table [mcc].[Courses_tbl](
							[Course_ID] INT PRIMARY KEY,
							[Course_Name] VARCHAR(255),
						);
insert into [mcc].[Courses_tbl]([Course_ID], [Course_Name]) values
(1, 'Mathematics'),
(2, 'Computer Science'),
(3, 'Physics'),
(4, 'English Literature'),
(5, 'History'),
(6, 'Chemistry'),
(7, 'Economics'),
(8, 'Art');

select * from [mcc].[Courses_tbl]


create table  [mcc].[Enrollments_tbl](
							[Enrollment_ID] int primary key,
							[Student_ID] int,
							[Course_ID] int,  
							foreign key (Student_ID) references [mcc].[Student_tbl]([std_id]),
							foreign key (Course_ID) references [mcc].[Courses_tbl]([Course_ID])
						);

insert into [mcc].[Enrollments_tbl] ([Enrollment_ID], [Student_ID], [Course_ID]) values
(1, 1, 2),
(2, 2, 2),
(3, 2, 1),
(4, 4, 3),
(5, 5, 3),
(6, 6, 4),
(7, 1, 5),
(8, 6, 5);

select * from [mcc].[Enrollments_tbl]
select
    s.std_id,
    s.std_name,
    count(e.Course_ID) as CoursesEnrolled
from
    [mcc].[Student_tbl] as s
join
    [mcc].[Enrollments_tbl] e ON s.std_id = e.Student_ID
join
	[mcc].[Courses_tbl] as c on e.Course_ID=c.Course_ID
group by
    s.std_id, s.std_name
having
    count(e.Course_ID) > 1



select s.[std_id],s.[std_name],count(c.[Course_ID])
from 
	[mcc].[Student_tbl] as s
join [mcc].[Enrollments_tbl] as e 
		on s.[std_id]=e.[Student_ID]
join [mcc].[Courses_tbl] as c
		on e.[Course_ID]=c.Course_ID
group by s.[std_id],s.[std_name]
having count(e.Course_ID)>2
-------------------------------------------------------------------------------------------
--9.Retrieve information about each book along with its author, publisher, and genre details. 3
create table [mcc].[author_tbl](
								[auth_id] int primary key,
								[author_name] varchar(30)
								);

insert into [mcc].[author_tbl] ([auth_id],[author_name]) values
(1, 'Rabindranath Tagore'),
(2, 'Jhumpa Lahiri'),
(3, 'Arundhati Roy'),
(4, 'Chetan Bhagat'),
(5, 'Amish Tripathi');

create table [mcc].[book_tbl](
								[book_id] int primary key,
								[book_name] varchar(40),
								[publiser_name] varchar(30),
								[publish_date] date,
								[auth_id] int,
								constraint [book_tbl_fk] foreign key([auth_id]) references [mcc].[author_tbl]([auth_id])
								);

insert into  [mcc].[book_tbl] ([book_id], [book_name], [publiser_name], [publish_date], [auth_id]) values
(1, 'Gitanjali', 'Macmillan', '1910-08-14', 1),
(2, 'The Namesake', 'Houghton Mifflin', '2003-09-01', 2),
(3, 'The God of Small Things', 'IndiaInk', '1997-04-01', 3),
(4, 'Five Point Someone', 'Rupa & Co.', '2004-01-01', 4),
(5, 'The Immortals of Meluha', 'Westland', '2010-02-01', 5),
(6, 'Chokher Bali', 'Macmillan', '1903-11-21', 1),
(7, '2 States', 'Bhagat Books', '2009-10-08', 4),
(8, 'The Secret of the Nagas', 'Westland', '2011-08-12', 5);

select * from [mcc].[author_tbl]
select * from [mcc].[book_tbl]

create function [mcc].[fn_getPubByauthor](@auth_id int)
returns table
as 
return
(
		select [book_name],
			   [publiser_name],
			   [publish_date],
			   [auth_id]
		from 
			 [mcc].[book_tbl]
		where [auth_id]=@auth_id
)

select a.[auth_id],a.[author_name],b.[book_name],b.[publiser_name],b.[publish_date]
from [mcc].[author_tbl] as a
cross apply [mcc].fn_getPubByauthor(a.auth_id) as b
-------------------------------------------------------------------------------------------------
--10.Find employees whose salaries are higher than the average salary of employees in departments 
--with at least 5 employees, with specific job titles.  3
create table [mcc].[department_tbl](
									[dept_id] int primary key,
									[dept_name] varchar(30),
									);
insert into [mcc].[department_tbl] ([dept_id], [dept_name]) values
(1, 'HR'),
(2, 'Finance'),
(3, 'Marketing'),
(4, 'IT'),
(5, 'Operations'),
(6, 'Sales');

create table [mcc].[emp_tbl](
							[emp_id] int primary key,
							[emp_name] varchar(30),
							[salary] money,
							[job_title] varchar(30),
							[dept_id] int
							)

Insert into  [mcc].[emp_tbl] ([emp_id], [emp_name], [salary], [job_title], [dept_id]) values
(1, 'Rajesh Kumar', 50000.00, 'Manager', 1),
(2, 'Priya Sharma', 45000.00, 'Analyst', 2),
(3, 'Amit Singh', 60000.00, 'Developer', 1),
(4, 'Sneha Patel', 55000.00, 'Designer', 3),
(5, 'Vikram Verma', 70000.00, 'Manager', 2),
(6, 'Meera Gupta', 48000.00, 'Analyst', 3),
(7, 'Anil Yadav', 52000.00, 'Developer', 2),
(8, 'Kavita Sharma', 58000.00, 'Designer', 1);

Insert into  [mcc].[emp_tbl] ([emp_id], [emp_name], [salary], [job_title], [dept_id]) values
(9, 'Subrata', 80000.00, 'Developer', 1);
Insert into  [mcc].[emp_tbl] ([emp_id], [emp_name], [salary], [job_title], [dept_id]) values
(10, 'Pranab', 80000.00, 'Developer', 1);


select * from [mcc].[department_tbl]
select * from [mcc].[emp_tbl]

--using corelated subquary
select [emp_id],[emp_name],[salary],[job_title],[dept_id]
from
    [mcc].[emp_tbl] as e1
where [salary] > (
        select AVG(e2.[salary])
		from
            [mcc].[emp_tbl] as e2
        where
            e2.[dept_id] = e1.[dept_id]
            and e1.[job_title] = 'Developer'   
			--- in this logic we can use in operator e1.job_title in ('Developer','Manager')
        having count(e2.[emp_id]) >= 5
    );
-----------------------------------------------------------------------------------------




								







								







