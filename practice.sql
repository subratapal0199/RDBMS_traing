use PracticeDB

--write a quary to display customer whose place the order amount grather thamn 2000
select c.firstname,c.lastname, c.phone, o.ordernumber 
from [dbo].Customer as c 
inner join [dbo].[Order] as o
on c.Id=o.CustomerId
where o.TotalAmount>2000

-- to display customer first name city and country in which city rita is lives
--first i have to find where rita live
select Country from [dbo].[Customer]
where FirstName='rita'

select firstname, city, country
from [dbo].Customer where Country=(select Country from [dbo].[Customer]
where FirstName='rita')

--display those suplier who have not supply any product
select s.id,s.companyname,p.id,p.productname 
from [dbo].Supplier as s
inner join [dbo].Product as p
on s.Id=p.SupplierId
where p.IsDiscontinued=1

--display the orders against which sales not generated o_id, o_date
select o.id,o.orderdate,o.totalamount 
from [dbo].[Order] as o
join [dbo].OrderItem as oi 
on oi.OrderId=o.Id
where oi.OrderId is null

--display customer first name, order no, quantity
select c.firstname,o.ordernumber,oi.quantity
from [dbo].Customer as c
inner join [dbo].[Order] as o on c.Id=o.CustomerId
inner join [dbo].OrderItem as oi on o.id=oi.OrderId

--count the total quantity for order placed
select c.firstname,o.ordernumber,count(*) as 'quantity'
from [dbo].Customer as c
inner join [dbo].[Order] as o on c.Id=o.CustomerId
inner join [dbo].OrderItem as oi on o.id=oi.OrderId
group by c.firstname,o.ordernumber

--display the customer first name, last name,city where first name ends with th
select firstname,lastname,city 
from [dbo].[Customer]
where FirstName like ('%th')

use Bikestores
--display the store name, city,productname, quantity
select s.store_name,s.city,p.product_name,oi.quantity
from sales.stores as s
inner join production.products as p on s.store_id=p.product_id
inner join sales.order_items as oi on p.product_id=oi.product_id




select s.first_name as staff, m.first_name as manager
from [sales].staffs as s
left join [sales].staffs as m
on s.manager_id=m.staff_id

select * from sales.staffs

use HRDB

use bikestores
select d.department_name, count(e.department_id) as 'total'
from [dbo].[departments] as d
inner join [dbo].[employees] as e on d.department_id=e.department_id
group by d.department_name
having count(e.department_id)=0

select e.customer_id,year(o.order_date) as order_year,count(o.order_id) as total
from [sales].customers as e 
inner join [sales].orders as o on e.customer_id=o.customer_id
---where e.customer_id in (1,2)
group by e.customer_id,year(o.order_date) 
having e.customer_id in (1,2)
order by e.customer_id


USE Subrata_DB
create table[HR].[source_tbl](
								[sour_id] int primary key,
								[sour_name] varchar(30),
								[sour_ammount] dec(10,2)
								)
create table[HR].[target_tbl](
								[tar_id] int primary key,
								[tar_name] varchar(30),
								[tar_ammount] dec(10,2)
								)
insert into [HR].[source_tbl] values
(1,'yusi',5567.30),(2,'kusi',3546.26),(4,'papan',4783.30),(5,'amit',7782.40)

insert into [HR].[target_tbl] values
(1,'one',6673.45),(2,'two',8930.26),(3,'three',4683.60),(5,'five',9782.40)

select * from [HR].[source_tbl]
select * from [HR].[target_tbl]

merge [HR].[target_tbl] as t using [HR].[source_tbl] as s on t.[tar_id]=s.[sour_id]
	when not matched by target
	then
		insert ([tar_id],[tar_name],[tar_ammount]) values (s.[sour_id],s.[sour_name],s.[sour_ammount])
	when matched 
	then
		update set t.[tar_name]=s.[sour_name],
					t.[tar_ammount]=s.[sour_ammount]
	when not matched by source 
	then
		delete;

select * from [HR].[target_tbl]

--write a quary to show update and delete


alter table [HR].[emp_tbl] drop constraint [emp_tbl_fk]

delete d 
from [HR].[dept_tbl] as d
inner join [HR].[emp_tbl] as e on d.dept_id=e.dept_id

update [HR].[dept_tbl] set dept_id=101 
where dept_name='Technical'

dbcc checkident('[HR].[dept_tbl]',reseed,100)

insert into [HR].[dept_tbl](dept_name,[location],city,pincode) values
('CEO','salt lake','kolkata','700142')

update [HR].[emp_tbl] set dept_id=102
where dept_id=103

select * from [HR].[dept_tbl]
select * from [HR].[emp_tbl]

delete e
from [HR].[emp_tbl] as e
inner join [HR].[dept_tbl] as d on e.dept_id=d.dept_id
where d.dept_id=102


alter table [HR].[emp_tbl] add constraint emp_tbl_fk foreign key([dept_id]) references  [HR].[dept_tbl](dept_id) on delete cascade on update cascade


delete d 
from [HR].[dept_tbl] as d
inner join [HR].[emp_tbl] as e on d.dept_id=e.dept_id
where e.dept_id=101

dbcc checkident('[HR].[emp_tbl]',reseed,200)
insert into [HR].[emp_tbl] (emp_name,gender,[address],salary,doj,dept_id) values
('Avik','F','Sanyouo',46700.56,'2023/02/23',102)

update [HR].[dept_tbl] 
set [HR].[dept_tbl].[dept_id]=102

use Subrata_DB
select * from [HR].[dept_tbl]
select * from [HR].[emp_tbl]

select  dept_id,dept_name,[location],city,pincode
into #dept_history 
from [HR].[dept_tbl]

create table #emp_tbl(
						[emp_id] int ,
						[emp_name] varchar(30),
						[gender] char(1),
						[address]  varchar(50),
						[salary] money,
						[doj] date,
						[dept_id] int
						)

insert into #emp_tbl
select emp_id,emp_name,gender,[address],salary,doj,dept_id
from [HR].emp_tbl

select * from #emp_tbl

use Bikestores

select o.order_id,sum(list_price*qouantity) as 'order_value'
case when sum(list_price*qouantity)<500
then 'very low'
from [sales].[oders] as o 
inner join [sales]

select o.order_id ,sum(list_price* quantity) as 'order_value',
CASE when sum(list_price*quantity)<=500
		then 'very low'
	when sum(list_price*quantity)>500 and sum(list_price*quantity)<=1000
		then 'low'
	when sum(list_price*quantity)>1000 and sum(list_price*quantity)<=5000
		then 'Medium'
	when sum(list_price*quantity)>5000 and sum(list_price*quantity)<=10000
		then 'High'
	when sum(list_price*quantity)>10000
		then 'very high'
end as 'order_priority'
from [sales].[orders] as o
inner join [sales].[order_items] as oi on oi.order_id=o.order_id
where year(order_date) =2018
group by o.order_id 
order by order_id

SELECT product_name, list_price 
FROM production.products
WHERE list_price < 200
OR list_price > 6000
ORDER BY list_price;

SELECT product_name, brand_id, list_price
FROM production.products
WHERE brand_id = 1 or
brand_id = 2
AND list_price > 500
ORDER BY brand_id DESC, list_price;

SELECT city, state, zip_code
FROM sales.customers
GROUP BY city, state, zip_code
ORDER BY city, state, zip_code

use Subrata_DB
create table [HR].[exel_tbl](
							[ex_id] int primary key,
							[ex_name] varchar(40),
							[age] tinyint 
							)

alter table [HR].[exel_tbl] drop column [age]
alter table [HR].[exel_tbl] add [city] varchar(20) 


bulk insert [HR].[exel_tbl]
from 'D:\Subrata_pal\ex_file.csv'
with(
	fieldterminator=',',
	rowterminator='\n',
	firstrow=2
	);

select * from [HR].exel_tbl

create table [HR].[manager_tbl](
							[manager_id] int identity constraint [man_tbl_pk] primary key,
							[manager_name] varchar(20) not null,
							[gender] char(1),
							[city] char(15) constraint [man_city_c] default 'Kolkata', --default constraint
							[age] tinyint constraint [man_age_c] check([age]>18), --check constraint
							[phone_no] char(10),
							unique([phone_no]) -- unique key
							)
select * from [HR].[manager_tbl]
insert into [HR].[manager_tbl](manager_name,gender,age,phone_no) values
('subrata','F',19,'7003167405')
dbcc checkident('[HR].[manager_tbl]',reseed,0)
insert into [HR].[manager_tbl](manager_name,gender,age,phone_no) values
('Avik','M',20,'8733167407')

-- i want to disable check constraint
alter table [HR].[manager_tbl] nocheck constraint [man_age_c] 

insert into [HR].[manager_tbl](manager_name,gender,age,phone_no) values
('susmita','F',10,'8735167407')

alter table [HR].[manager_tbl] drop constraint [man_age_c] 


alter table [HR].[manager_tbl] check constraint [man_age_c] 
alter table [HR].[manager_tbl] add constraint [man_age_c] check([age]>17)

drop table [HR].company
 create table[HR].[Stud_tbl](
							[std_id] int primary key,
							[std_name] varchar(30),
							[city] varchar(40)
							)
 create table[HR].[company](
							[com_id] int primary key,
							[com_name] varchar(30),
							[city] varchar(40),
							[std_id] int,
							constraint comp_tbl_fk foreign key ([std_id]) references [HR].[Stud_tbl]([std_id])
							)
insert into [HR].[Stud_tbl](std_id,std_name,city) values
(101,'CTC','kolkata'),(102,'ACC','salt lake'),(103,'MCC','Rajarhat')
insert into [HR].[company](com_id,com_name,city,std_id) values
(201,'sub','kolkata',101),(202,'Aranb','salt lake',101),(203,'VMM','Howrah',102)

in

delete s 
from [HR].Stud_tbl as s
inner join [HR].company as c on s.std_id=c.std_id
where s.std_id=101

alter table [HR].[company] drop constraint comp_tbl_fk 

alter table [HR].[company] add constraint comp_tbl_fk  foreign key([std_id])references [HR].[Stud_tbl]([std_id]) 
on delete cascade

select * from [HR].[Stud_tbl]
select * from [HR].[company]


delete s 
from [HR].Stud_tbl as s
inner join [HR].company as c on s.std_id=c.std_id
where s.std_id=101

alter table [HR].[company] drop constraint comp_tbl_fk 

alter table [HR].[company] add constraint comp_tbl_fk  foreign key([std_id])references [HR].[Stud_tbl]([std_id]) 
on delete set null

delete s 
from [HR].Stud_tbl as s
inner join [HR].company as c on s.std_id=c.std_id
where s.std_id=102

update [HR].[company] set std_id=102 where std_id is null

select * from [HR].[Stud_tbl]
select * from [HR].[company]

use Subrata_DB

alter table [HR].[company] drop constraint comp_tbl_fk 

alter table [HR].[company] add constraint comp_tbl_fk  foreign key([std_id])references [HR].[Stud_tbl]([std_id]) 
on update cascade


update [HR].[Stud_tbl] 
set std_id=100
from [HR].[Stud_tbl]  as s
inner join [HR].[company] as c on s.std_id=c.std_id
where s.std_id=101


alter table [HR].[company] drop constraint comp_tbl_fk 

alter table [HR].[company] add constraint comp_tbl_fk  foreign key([std_id])references [HR].[Stud_tbl]([std_id]) 
on update set null

update [HR].[Stud_tbl] 
set std_id=101
from [HR].[Stud_tbl]  as s
inner join [HR].[company] as c on s.std_id=c.std_id
where s.std_id=100


use PracticeDB

select c.firstname,c.lastname,c.phone,o.id,o.ordernumber
from [dbo].[Customer] as c
inner join [dbo].[Order] as o on c.Id=o.CustomerId
where o.TotalAmount>2000

select s.id,s.companyname,p.productname
from [dbo].Supplier as s
inner join [dbo].Product as p on s.Id=p.SupplierId
where p.IsDiscontinued=1 -- null 

select c.Country 
from [dbo].Customer as c
where c.FirstName='rita' collate sql_latin1_general_cp1_ci_as

select c.firstname, c.city, c.country 
from [dbo].Customer as c
where c.Country in (select c.Country 
from [dbo].Customer as c
where c.FirstName='rita' collate sql_latin1_general_cp1_ci_as)

select o.id,o.ordernumber
from [dbo].[Order] as o
join [dbo].[OrderItem] as oi on o.Id=oi.OrderId
where oi.OrderId is null

use PracticeDB
select c.id,c.firstname,o.ordernumber,count(oi.Quantity) as 'total_quantity'
from [dbo].[Customer] as c
inner join [dbo].[Order] as o on c.Id=o.CustomerId
inner join [dbo].[OrderItem] as oi on o.Id=oi.OrderId
group by c.id,c.firstname,o.ordernumber

use Bikestores
select s.store_name, s.city,p.product_name,st.quantity
from [sales].[stores] as s
inner join [production].[stocks] as st on s.store_id=st.store_id
inner join [production].products as p on p.product_id=st.product_id


select s.first_name as 'staff', m.first_name as 'manager'
from [sales].staffs as s
inner join [sales].staffs as m on 
s.manager_id=m.staff_id

--write a quary to find out dept without employe
use HRDB
select d.department_id,d.department_name,count(d.department_id)
from [dbo].[departments] as d
left outer join [dbo].[employees] as e on 
d.department_id=e.department_id
group by d.department_id,d.department_name
having count(d.department_id) =0

--how many employee working under each and every manager
select e.employee_id, e.first_name, COUNT(e.employee_id) as 'no of emp'
from [dbo].[employees] as e
inner join [dbo].[employees] as m on e.manager_id=m.employee_id
group by  e.employee_id, e.first_name


select * from [dbo].employees
--find out emp whose salary is less than os that emp_id 192
select salary from [dbo].[employees] where employee_id=192

select e.first_name,e.last_name
from [dbo].[employees] as e
where salary<(select salary from [dbo].[employees] where employee_id=192)

select * from [dbo].employees
where last_name='taylor'

select e.first_name,e.last_name
from [dbo].employees as e
inner join [dbo].[departments] as d
on e.department_id=d.department_id
where e.last_name='Taylor'

select first_name,last_name
from [dbo].departments as d 
where department_id in (select department_id from [dbo].employees as e where last_name='toylor')

use HRDB
select e.employee_id, hire_date
from [dbo].employees as e
where hire_date between '1993/01/01' and  '1997/08/31'

select c.country_name, l.city , count(d.department_id)
from [dbo].[countries] as c 
inner join [dbo].[locations] as l on c.country_id=l.country_id
inner join [dbo].departments as d on l.location_id=d.location_id
group by c.country_name,l.city 
having count(d.department_id)>2


use Subrata_DB

--format function
declare @d date=getdate()
select FORMAT(@d,'dd/MM/yyy') as 'date1'

select FORMAT(@d,'dd/MM/yyy','en-US') as 'date2'

select format(7003167407,'XXXX-XXX-XXX')

select 
		CONCAT(
				SUBSTRING(FORMAT(7003167407,'XXXXXXXXXX'),1,5),
				'-',
				SUBSTRING(FORMAT(7003167407,'0000000000'),6,10)
				)

--datediff function 
select DATEDIFF(day,'2024/01/24','2024/01/25') as days

--datepart- it returns a integer which is the part of date such as day, month, year
select DATEPART(day,getdate()) as 'day'
select DATEPART(MONTH,'2024/01/23') as 'day'

--year fun, month fun 
select YEAR(getdate()) as 'year'
select MONTH('2024/01/23') as 'month'

--convert and cust
select convert(char, 'Avik Hazra') as 'Char_value'
select convert(date, GETDATE(),100) as 'date'
select convert(char, GETDATE(),100) as 'date'
--cast
select CAST(getdate() as date) as 'date'

--string split
select value from string_split('My name is subrata pal',' ')

--is numeric 
select ISNUMERIC('char')

select TRY_CAST(1.533 as dec(4,3))
select TRY_CAST(11.342 as dec(4,3))

select ROUND(123.455,2)
select ABS(-12)
select CEILING(24.75)
select floor(24.75)

select NEWID() as 'GUID'

declare @id uniqueidentifier
set @id=NEWID()
select @id as 'GUId'
-------------------------------------------------------------------------------------------
--03/02/2024
use Subrata_DB

create table [mc].[binary_tree_tbl](
								[node_id] int primary key,
								[node_value] int,
								[parent_node] int,
								foreign key([parent_node]) references [mc].[binary_tree_tbl]([node_id])
								)

insert into [mc].[binary_tree_tbl] values(1,10,null),
										 (2,20,1),
										 (3,30,1),
										 (4,40,2),
										 (5,50,2),
										 (6,60,3),
										 (7,70,3)

select * from [mc].[binary_tree_tbl]

select p.node_id as 'Parent_node',p.node_value as 'Parent_value',c.node_id as 'child_node', c.node_value as 'child_value'
from [mc].[binary_tree_tbl] as p
left join [mc].[binary_tree_tbl] as c
on p.node_id=c.parent_node

-------------------------------------------------------------------------------------------------
select * from mc.customer_tbl
select * from mc.order_placed

select or_id,or_name,or_no, cust_id 
from mc.order_placed where cust_id in (select cust_id from mc.customer_tbl where city='kolkata')

select or_id,or_name,or_no,(select max(salary) from [mc].[customer_tbl] as c where c.cust_id=o.cust_id) as 'max_salary'
from [mc].order_placed as o
order by or_no desc

CREATE TABLE mc.Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);
INSERT INTO mc.Department (DepartmentID, DepartmentName)
VALUES
    (1, 'HR'),
    (2, 'IT'),
    (3, 'Marketing');
INSERT INTO mc.Department (DepartmentID, DepartmentName)
VALUES
    (4, 'Finance'),
    (5, 'Operations'),
    (6, 'Sales');

create table mc.employee_tbl(
							[emp_id] int primary key,
							[emp_name] varchar(30),
							[city] varchar(40),
							[salary] money,
							[age] tinyint,
							[dept_id] int foreign key references mc.Department([DepartmentID])
							)

insert into mc.employee_tbl ([emp_id], [emp_name], [city], [salary], [age], [dept_id]) VALUES
(1, 'Aarav Kumar', 'Mumbai', 50000.00, 25, 1),
(2, 'Aisha Gupta', 'Delhi', 55000.00, 28, 1),
(3, 'Arjun Sharma', 'Bangalore', 60000.00, 30, 2),
(4, 'Ananya Patel', 'Chennai', 70000.00, 22, 4),
(5, 'Advait Singh', 'Kolkata', 75000.00, 35, 2),
(6, 'Arya Mishra', 'Hyderabad', 80000.00, 27, 3),
(7, 'Aryan Reddy', 'Pune', 60000.00, 32, 5),
(8, 'Amara Desai', 'Ahmedabad', 65000.00, 29, 3);

INSERT INTO mc.employee_tbl ([emp_id], [emp_name], [city], [salary], [age], [dept_id])
VALUES
    (9, 'Akshay Jain', 'Mumbai', 52000.00, 26, 1),
    (10, 'Aditi Singh', 'Delhi', 60000.00, 30, 1),
    (11, 'Aniket Kumar', 'Bangalore', 62000.00, 29, 2),
    (12, 'Bhavana Patel', 'Chennai', 72000.00, 23, 4),
    (13, 'Bharat Singh', 'Kolkata', 76000.00, 34, 2),
    (14, 'Bhavya Mishra', 'Hyderabad', 81000.00, 28, 3),
    (15, 'Biren Reddy', 'Pune', 65000.00, 31, 5),
    (16, 'Bina Desai', 'Ahmedabad', 67000.00, 27, 3);

select * from mc.employee_tbl
select * from mc.Department

/*Nested Subquery : Display employees whose salaries are greater than the average salary of employees in their department, 
and the department has a minimum of 3 employees.*/

select emp_id,emp_name,city 
from mc.employee_tbl as e1
where salary>( select AVG(salary) 
				from mc.employee_tbl as e2 
				where dept_id=e1.dept_id) 
				and dept_id in (
								select DepartmentID 
									from mc.Department as d
									join mc.employee_tbl as eee
									on eee.dept_id=d.DepartmentID
									group by DepartmentID
									having COUNT(*)>=3
								)

select emp_id,emp_name,city 
from mc.employee_tbl as e1
where salary>( select AVG(salary) 
				from mc.employee_tbl as e2 
				where dept_id=e1.dept_id) 
				and dept_id in (
								select dept_id
									from mc.employee_tbl
									group by dept_id
									having COUNT(*)>=3
								)


ALTER TABLE mc.Department
ADD region VARCHAR(50);

UPDATE mc.Department
SET region = 'south'
WHERE DepartmentID IN (1, 2, 3);

UPDATE mc.Department
SET region = 'East'
WHERE DepartmentID IN (4, 5, 6);

/*Nested Subquery: Display employees who have a salary higher than the average salary of employees in departments 
with at least 2 employees, and those departments are located in a specific region, let's say 'South'*/
select * from mc.Department

select emp_id,emp_name,city 
from mc.employee_tbl as e1
where salary>( select AVG(salary) 
				from mc.employee_tbl as e2 
				where dept_id=e1.dept_id) 
				and dept_id in (
								select DepartmentID 
									from mc.Department as d
									join mc.employee_tbl as eee
									on eee.dept_id=d.DepartmentID
									where d.region='south'
									group by DepartmentID
									having COUNT(eee.emp_id)>=2
								) 

select emp_id,emp_name,city
from mc.employee_tbl 
where city =all (
				select city 
				from mc.employee_tbl
				where city='kolkata' and city='salt lake'
				)

select * 
from mc.employee_tbl as e where exists(	
									select  departmentId from mc.Department as d
									where e.dept_id=d.DepartmentID
									)

select * 
from mc.employee_tbl as e where not exists(	
									select  dept_id from mc.employee_tbl as d
									)

create function mc.fn_getEmpBYDeptID(@depart_id int)
returns table
as 
return
(
		select emp_id,emp_name,city,salary,age,dept_id
		from mc.employee_tbl
		where dept_id=@depart_id
)

select * from mc.fn_getEmpBYDeptID(1)

select * from mc.Department

select e.emp_id,e.emp_name,d.departmentname,d.region 
from mc.Department as d
outer apply mc.fn_getEmpBYDeptID(d.departmentid) as e


CREATE TABLE mc.student_tbl (
    StudentID INT PRIMARY KEY,
    Subject1Marks INT,
    Subject2Marks INT,
    Subject3Marks INT,

);

INSERT INTO mc.student_tbl (StudentID, Subject1Marks, Subject2Marks, Subject3Marks)
VALUES
    (1, 80, 75, 90),
    (2, 70, 85, 80)

select * from mc.student_tbl

SELECT
    StudentID,
    Subject1Marks,
    Subject2Marks,
    Subject3Marks,
    totalMarks,
	case
        WHEN TotalMarks >= 400 THEN 'A+'
        WHEN TotalMarks >= 350 AND TotalMarks < 400 THEN 'A'
        WHEN TotalMarks >= 300 AND TotalMarks < 350 THEN 'B'
        WHEN TotalMarks >= 250 AND TotalMarks < 300 THEN 'C'
        WHEN TotalMarks >= 200 AND TotalMarks < 250 THEN 'D'
        ELSE 'F'
    END as 'Grade'
FROM (
		select 
				studentid,
				subject1marks,
				subject2marks,
				subject3marks,
				ISNULL(subject1marks,0)+ISNULL(subject2marks,0)+ISNULL(subject3marks,0) as totalmarks
			from 
				mc.student_tbl
		) as totalmarksdetails
------------------------------------------------------------------------------------     
--Using Case : Calculates a bonus for employees based on their salary. 
--Condition 1. salary >6000 then bonus 0.1, 2. salary between 45000 and 59999 then bonus 0.65 otherwise 0.
select * from mc.employee_tbl

select emp_id,emp_name,city,salary,
		case
			when salary>60000 then cast(round(salary*0.1,2) as dec(20,2))
			when salary between 45000 and 59999 then cast(round(salary*0.65,2) as dec(20,2))
			else 0
		end as Bonus
from mc.employee_tbl

--using scaler function
EXEC sp_help 'mc.employee_tbl'

create function mc.fn_calcu_bonus(@salary money)
returns decimal(10,2)
as 
begin
	declare @bonus decimal(10,2)
	set @bonus=
				case
					when @salary>60000 then cast(round(@salary*0.1,2) as dec(20,2))
					when @salary between 45000 and 59999 then cast(round(@salary*0.65,2) as dec(20,2))
					else 0
				end
	return @bonus
end;

select *, mc.fn_calcu_bonus(salary)
from mc.employee_tbl

-----------------------------------------------------------------------------------
--Using Case : calculate the final price of a product based on availability and apply discounts accordingly. 
--Assuming a Products table with columns ProductID, ProductName, Price, StockQuantity, and DiscountPercentage.
--drop table mc.Product_tbl
CREATE TABLE mc.Product_tbl(
							Pro_ID INT PRIMARY KEY,
							Pro_Name VARCHAR(50),
							Price DECIMAL(10, 2),
							StockQuantity INT,
							DiscountPercentage INT
							);

INSERT INTO mc.Product_tbl(Pro_ID, Pro_Name, Price, StockQuantity, DiscountPercentage)
VALUES
    (1, 'Laptop', 1000.00, 20, 10),
    (2, 'Smartphone', 500.00, null, 5),
    (3, 'Headphones', 50.00, 30, 15),
    (4, 'Tablet', 300.00, 10, 8),
    (5, 'Printer', 150.00, null, 12),
    (6, 'Camera', 800.00, 5, 20),
    (7, 'Monitor', 200.00, 18, 10),
    (8, 'Keyboard', 30.00, 40, 5);

select Pro_ID,Pro_Name,Price,StockQuantity,DiscountPercentage,
		case	
			when StockQuantity>0
				then 
					cast(ROUND(price-(price*discountpercentage/100),2) as decimal(10,2))
			else 0
		end as 'After_discount'
from mc.Product_tbl
------------------------------------------------------------------------------------------
--Rank()
select * from mc.employee_tbl

select * 
from 
	(select emp_name,city,row_number() over(
									partition by dept_id
									order by city asc
									) 'rank'
				from mc.employee_tbl
		)t

