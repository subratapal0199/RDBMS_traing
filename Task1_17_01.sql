create database [studentDB]
use studentDB
alter database [studentDB] modify name=[student_new_DB]
exec sp_renamedb 'student_new_DB','StudentDB'
drop database [StudentDB]
create database [studentDB]
use studentDB
create schema marks

create table marks.[science](
subject_id int primary key identity,
physics int not null,
Math int  not null,
chemistry int not null
);



create schema HR
use studentDB
create schema [HR]

create table [HR].[dept_tbl](
							[dept_id] int identity(101,1) constraint [dept_id_pk] primary key,
							[dept_name] varchar(50) not null,
							[location] varchar(20),
							[city] varchar(20) not null, 
							[pincode] char(6) not null
							);

create table [HR].[emp_tbl](
							[emp_id] int identity(201,1) constraint [emp_id_pk] primary key,
							[emp_name] varchar(50) not null,
							[gender] char(1) not null,
							[address] varchar (50),
							[salary] money,
							[doj] date,
							[dept_id] int,
							foreign key([dept_id]) references [HR].[dept_tbl]([dept_id])
							);

insert into [HR].[dept_tbl]([dept_name],[location],[city],[pincode]) values('HR','candor gate 2','kolkata','700001')
insert into [HR].[dept_tbl]([dept_name],[location],[city],[pincode]) values('Technical','city center','kolkata','700345')
insert into [HR].[dept_tbl]([dept_name],[location],[city],[pincode]) values('Accounts','sector v','salt lake','700103')

select * from [HR].[dept_tbl];

insert into [HR].[emp_tbl]([emp_name],[gender],[address],[salary],[doj],[dept_id]) values('Subrata pal','M','Maheshtala',60000.50,'2024/01/18',101),
																					('Swapnasias guha','M','New Alipore',28000.00,'2023/05/12',101),
																					('Ankita maulic','F','candor gate 2',15000.00,'2024/03/01',103)

select * from [HR].[emp_tbl];

insert into [HR].[emp_tbl]([emp_name],[gender],[address],[salary],[doj],[dept_id]) values('Sumon','other','DLF2',40000.50,'2023/06/10',102)

delete from [HR].[dept_tbl] where dept_id between 105 and 107 

insert into [HR].[dept_tbl]([dept_name],[location],[city],[pincode]) values('manegment','sector v','kolkata','700103')
insert into [HR].[dept_tbl]([dept_name],[location],[city],[pincode]) values('Account','sector v','kolkata','700103')
insert into [HR].[dept_tbl]([dept_name],[location],[city],[pincode]) values('Helper','sector v','kolkata','700103')

dbcc checkident('[HR].[dept_tbl]',reseed,110)

drop table [HR].[emp_tbl]

create table [HR].[emp_tbl](
							[emp_id] int identity(201,1) constraint [emp_id_pk] primary key,
							[emp_name] varchar(50) not null,
							[gender] char(1) not null,
							[address] varchar (50),
							[salary] money,
							[doj] date,
							[dept_id] int,
							constraint emp_tbl_id_fk foreign key([dept_id]) references [HR].[dept_tbl]([dept_id])
							);

insert into [HR].[emp_tbl]([emp_name],[gender],[address],[salary],[doj],[dept_id]) values('Subrata pal','M','Maheshtala',60000.50,'2024/01/18',101),
																					('Swapnasias guha','M','New Alipore',28000.00,'2023/05/12',101),
																					('Ankita maulic','F','candor gate 2',15000.00,'2024/03/01',103)

select * from [HR].[emp_tbl];


drop table [HR].[dept_tbl]

alter table [HR].[emp_tbl] drop constraint emp_tbl_id_fk

drop table [HR].[dept_tbl]

create table [HR].[dept_tbl](
							[dept_id] int identity(101,1) constraint [dept_id_pk] primary key,
							[dept_name] varchar(50) not null,
							[location] varchar(20),
							[city] varchar(20) not null, 
							[pincode] char(6) not null
							);

select * from [HR].[dept_tbl]

insert into [HR].[dept_tbl]([dept_name],[location],[city],[pincode]) values('HR','candor gate 2','kolkata','700001')
insert into [HR].[dept_tbl]([dept_name],[location],[city],[pincode]) values('Technical','city center','kolkata','700345')
insert into [HR].[dept_tbl]([dept_name],[location],[city],[pincode]) values('Accounts','sector v','salt lake','700103')

alter table [HR].[emp_tbl] add constraint  emp_id_fk foreign key([dept_id]) references [HR].[dept_tbl]([dept_id])


create table [HR].[test](
						[test_id] int identity(301,1) constraint [test_id_pk] primary key,
						[test_name] varchar(50) not null,
						[location] varchar(20),
						[city] varchar(20) not null, 
					);


select * from [HR].[test]
alter table [HR].[test] add pincode varchar(6) not null

alter table [HR].[test] alter column pincode char(6)

alter table [HR].[test] drop column pincode




exec sp_rename '[HR].[test]','testDB' 

alter table [HR].[testDB] alter column city varchar(20)  default 'Kolkata'


alter table [HR].[testDB] add cityy varchar(30) constraint test_tbl_dc default 'Kolkata'

insert into [HR].[testDB]([test_name],[location]) values('MCQ','kolkata')


select * from [HR].[testDB]

select [test_id],[test_name],[location] into #temp_tbl from [HR].[testDB]

select * from [dbo].[#temp_tbl]

create table #temp_productionDB (
							[test_name] varchar(max),
							[location] varchar(20) , 
							)

drop table  #temp_productionDB




insert into #temp_productionDB 
select [test_name], [location] 
from [HR].[testDB] 

select * from [dbo].[#temp_productionDB]

use studentDB

create schema sales

create table [sales].[participants](
								[activity_id] int,
								[customer_id] int,
								constraint ac_id_pk primary key([activity_id],[customer_id])
								);


create table [sales].[events](
								[event_id] int not null,
								[event_name] varchar(200),
								[start_date] date not null,
								[duration] dec(5,2)
							);
insert into [sales].[events]([event_id],[event_name],[start_date],[duration]) values(111,'Birth day','2024/02/01',345.23)
insert into [sales].[events]([event_id],[event_name],[start_date],[duration]) values(111,'Teachers day','2024/08/05',759.44)
insert into [sales].[events]([event_id],[event_name],[start_date],[duration]) values(113,'Birth day','2024/02/01',345.24)

alter table [sales].[event] add constraint [event_id_pk] primary key([event_id])

create table [sales].[student](
								[std_id] int identity(101,1) constraint [std_tbl_pk] primary key ,
								[std_name] varchar(50) not null,
							);
insert into [sales].[student]([std_name]) values('Birth day')
insert into [sales].[student]([std_name]) values('Avik')
insert into [sales].[student]([std_name]) values('kamal')

select * from [sales].[student]


create table [sales].[dept](
								[dept_id] int identity(201,1) constraint [dept_tbl_pk] primary key ,
								[dept_name] varchar(50) not null,
								[std_id] int,
								constraint [dept_tbl_fk] foreign key([std_id]) references [sales].[student]([std_id]) on delete CASCADE on update cascade		
							);

insert into [sales].[dept]([dept_name],[std_id]) values('HR',101)
insert into [sales].[dept]([dept_name],[std_id]) values('Management',101)
insert into [sales].[dept]([dept_name],[std_id]) values('Technical',102)

select * from [sales].[dept]

delete from [sales].[student] where std_id=102

alter table [sales].[dept] drop constraint [dept_tbl_fk]
alter table [sales].[student] drop constraint [std_tbl_pk]
alter table [sales].[student] add constraint  [std_id_pk] primary key([std_id])
alter table [sales].[dept] add constraint  [dept_id_pk] foreign key([std_id]) references [sales].[student]([std_id])

set identity_insert [sales].[student] on

UPDATE [sales].[student] SET std_id = 555 WHERE  std_id=101








create table [sales].[collage](
								[coll_id] int constraint [std_tbl_pk] primary key ,
								[col_name] varchar(50) not null,
							);

insert into [sales].[collage]([coll_id],[col_name]) values(1,'xyz')
insert into [sales].[collage]([coll_id],[col_name]) values(2,'yyy')
insert into [sales].[collage]([coll_id],[col_name]) values(3,'zzz')

select * from [sales].[collage]

create table [sales].[teacher](
								[t_id] int identity(201,1) constraint [t_tbl_pk] primary key ,
								[t_name] varchar(50) not null,
								[coll_id] int,
								constraint [t_tbl_fk] foreign key([coll_id]) references [sales].[collage]([coll_id]) on delete CASCADE on update cascade		
							);

drop table [sales].[teacher]

create table [sales].[teacher](
								[t_id] int constraint [t_tbl_pk] primary key ,
								[t_name] varchar(50) not null,
								[coll_id] int,
								constraint [t_tbl_fk] foreign key([coll_id]) references [sales].[collage]([coll_id]) on delete CASCADE on update cascade		
							);

insert into [sales].[teacher]([t_id],[t_name],[coll_id]) values(1,'subrata',1)
insert into [sales].[teacher]([t_id],[t_name],[coll_id]) values(2,'suumon',1)
insert into [sales].[teacher]([t_id],[t_name],[coll_id]) values(3,'subrata',2)

select * from [sales].[teacher]

delete from [sales].[collage] where coll_id=3
delete from [sales].[collage] where coll_id=1

UPDATE [sales].[collage] SET coll_id =1  WHERE  coll_id=2

select GETDATE()
select FORMAT(getdate(),'dd/MM/yyyy')

select ASCII ('a')


create table [sales].[university](
								[coll_id] int constraint [uni_tbl_pk] primary key ,
								[col_name] varchar(50) not null,
							);

insert into [sales].[university] select * from [sales].[collage]

select * from [sales].[collage]

create table companyDB(
					[com_id] int,
					[com_name] varchar(20),
					[location] varchar(20)
					);

bulk insert companyDB 
from 'E:\Subrata Pal/myfile.csv'
with(
	FieldTerminator=',',
	rowterminator='\n',
	firstrow=2
	)
select *from companyDB


create table [HR].[companyDB](
					[com_id] int,
					[com_name] varchar(20),
					[location] varchar(20)
					);

exec sp_rename '[HR].[companyDB].[location]','city'

use studentDB

create table [HR].[companyDB](
					[com_id] int,
					[com_name] varchar(20),
					[location] varchar(20)
					);

exec sp_rename '[HR].[companyDB].[location]','city'

select * from [HR].[companyDB]
use [BikeStores]

select [city],COUNT(*) 
from [sales].[customers]
where [state]='ca' collate sql_latin1_general_cp1_cs_as
group by [city]
order by [city]

select [city],COUNT(*)
from [sales].[customers]
where [state]='CA' 
group by [city]
having COUNT(*)>10
order by [city]

select [city],[first_name],[last_name]
from [sales].[customers]
order by [city],[first_name]


SELECT [city], [first_name], [last_name]
FROM [sales].[customers]
ORDER BY [city] DESC, [first_name] ASC;

SELECT [first_name], [last_name],LEN([first_name])
FROM [sales].[customers]
ORDER BY LEN([first_name]) DESC;

SELECT [first_name], [last_name],LEN(concat([first_name],[last_name])) "Total Chars"
FROM [sales].[customers]
ORDER BY LEN(concat([first_name],[last_name])) DESC;

select [product_name],[list_price]
from [production].[products]
order by [list_price], [product_name]
offset 10 rows
fetch next 10 rows only

select [product_name],[list_price]
from [production].[products]
order by [list_price], [product_name]
offset 10 rows

select top 10 [product_name],[list_price]
from [production].[products]
order by [list_price] desc

select [city]
from [sales].[customers]
order by [city]

select distinct [city]
from [sales].[customers]
order by [city]

select [city],[state]
from [sales].[customers]
order by [city],[state]

select distinct [city],[state]
from [sales].[customers]
order by [city],[state]

SELECT [city], [state], [zip_code]
FROM [sales].[customers]
GROUP BY [city], [state], [zip_code]
ORDER BY [city], [state], [zip_code]

select distinct [city], [state], [zip_code]
from [sales].[customers]

select [product_id], [product_name], [category_id], [model_year], [list_price]
from [production].[products]
where [list_price] IN (299.99, 369.99, 489.99)
order by [list_price] DESC;

select [product_id], [product_name], [category_id], [model_year], [list_price]
from [production].[products]
where [list_price] not IN (299.99, 369.99, 489.99)
order by [list_price] desc;

select [product_id], [product_name], [category_id], [model_year], [list_price]
from [production].[products]
where [product_name] like '%cruiser%'
order by [list_price]

select [product_id], [product_name], [category_id], [model_year], [list_price]
from [production].[products]
where [product_name] like '%cruiser' -- if the cruiser is in the last  
order by [list_price]

select [product_id], [product_name], [category_id], [model_year], [list_price]
from [production].[products]
where [product_name] like 'cruiser%' -- if the cruiser is in the first  
order by [list_price]

select [product_name], [brand_id],[list_price]
from [production].[products]
where [brand_id]=1
	or [brand_id]=2
	and [list_price]>500
	order by [brand_id] desc, [list_price]

select [product_id]
from [production].[stocks]
where [store_id]=1 and [quantity]>=30

select [product_id],[list_price]
from [production].[products]
where [product_id] in(select [product_id]
from [production].[stocks]
where [store_id]=1 and [quantity]>=30)
order by [product_name]

SELECT [c].[customer_id], [first_name], [last_name], [order_id]
FROM [sales].[customers] as c
INNER JOIN [sales].[orders] as o ON [o].[customer_id] = [c].[customer_id];

select sum(case when [order_status]=1 then 1 else 0 end) as 'Pending',
	   sum(case when [order_status]=2 then 1 else 0 end) as 'Processing',
	   sum(case when [order_status]=3 then 1 else 0 end) as 'Rejected',
	   sum(case when [order_status]=4 then 1 else 0 end) as 'Completed',
	   count(*) as total
from [sales].[orders]
where year(order_date)=2018

select [o].[order_id], sum(quantity*list_price) as [order_value],
	case when sum(quantity*list_price)<=500 then 'very low'
		when sum(quantity*list_price)>1000 and sum([quantity]*[list_price])<=5000 then 'medium'
		when sum([quantity]*[list_price])>5000 and sum([quantity]*[list_price])<=10000	then 'High'
		when sum([quantity]*[list_price])>10000 then 'very high'
		end as [order_priority]
	from [sales].[orders] as o inner join [sales].[order_items] as i on [i].[order_id]=[o].[order_id]
	where year([order_date])=2018
	group by [o].[order_id]

use studentDB
create table [HR].[source](
							[source_id] int primary key,
							[source_name] varchar(50),
							[sour_ammount] decimal(10,2)
							)
create table [HR].[target](
							[tar_id] int primary key,
							[tar_name] varchar(50),
							[tar_ammount] decimal(10,2)
							)

insert into [HR].[source] ([source_id],[source_name],[sour_ammount]) values(1,'xyz',56438.45),
																			(3,'yyy',56456.45),
																			(4,'rrr',74388.45),
																			(5,'mmm',56456.45)
insert into [HR].[target] ([tar_id],[tar_name],[tar_ammount]) values(1,'uuu',56438.45),
																	(2,'ttt',56456.45),
																	(3,'ccc',74388.45),
																	(4,'nnn',56456.45)
select * from [HR].[source]
select * from [HR].[target]

MERGE [HR].[target] as t using [HR].[source] as s on (s.[source_id]=t.[tar_id])
		when matched then
			update set t.[tar_name]=s.[source_name]
		when not matched by target then 
		insert (tar_id,tar_name, tar_ammount) values (s.source_id,s.source_name,s.sour_ammount)
	when not matched by source then
		delete;

select * from [HR].[target]

use BikeStores
select p.product_id, product_name, order_id
from production.products as p 
left join sales.order_items o ON o.product_id = p.product_id and o.order_id = 100
order by order_id desc

select p.product_id, product_name, order_id
from production.products as p 
left join sales.order_items o ON o.product_id = p.product_id 
--where o.order_id = 100
order by order_id desc

select * from sales.order_items
select * from production.products

select p.product_id, product_name, order_id
from production.products as p 
inner join sales.order_items o ON o.product_id = p.product_id 
where o.order_id = 100
order by order_id desc

select p.product_id, product_name, order_id
from production.products as p 
left join sales.order_items o ON o.product_id = p.product_id 
where o.order_id = 100
order by order_id desc


use BikeStores
CREATE TABLE hr.candidates(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

CREATE TABLE hr.employees(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

INSERT INTO 
    hr.candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');

INSERT INTO 
    hr.employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');

select * from HR.employees
select * from HR.candidates

select 
		c.id as candidate_id,
		c.fullname as candidate_fullname,
		e.id as employe_id,
		e.fullname as emp_fullname
	from 
		HR.candidates as c
	inner join
		HR.employees as e
	on e.fullname=c.fullname

select 
		c.id as candidate_id,
		c.fullname as candidate_fullname,
		e.id as employe_id,
		e.fullname as emp_fullname
	from 
		HR.candidates as c
		left join
		HR.employees as e
			on e.fullname=c.fullname
	--where e.id is null

select 
		c.id as candidate_id,
		c.fullname as candidate_fullname,
		e.id as employe_id,
		e.fullname as emp_fullname
	from 
		HR.candidates as c
	right join
		HR.employees as e
			on e.fullname=c.fullname

select 
		c.id as candidate_id,
		c.fullname as candidate_name,
		e.id as emp_id,
		e.fullname as emp_name
	from 
		HR.candidates as c
		full join hr.employees as e
				on e.fullname=c.fullname

select * from HR.employees
select * from HR.candidates

create table [hr].[source](
							id int not null primary key,
							name varchar(30) not null
							)
create table [hr].[target](
							id int not null primary key,
							name varchar(30) not null
							)
insert into 
			[HR].[target]([id],[name])
		values
			(1,'yksi'),(2,'kaksi'),(4,'nelja'),(5,'kussi')
insert into 
			[HR].[source]([id],[name])
		values
			(1,'one'),(2,'two'),(4,'three'),(5,'five')

merge [hr].[target]  as t using [hr].[source] as s on t.[id]=s.[id]
	when not matched by target 
	then
		insert ([id],[name]) values (s.[id],s.[name])
	when matched 
	then
		update set name=s.[name]
	when not matched by source
	then
		delete;

select * from [HR].[source]
select * from [HR].[target]


select * from sales.customers
select [first_name], [state]
from [sales].[customers]
where [state]='CA' --sql_latin1_general_cp1_cs_as
order by [first_name]

select [city],count(*)
from [sales].[customers]
where [state]='ca' collate SQL_Latin1_General_CP1_CS_AS
group by [city]
order by [city]

select [city],count(*)
from sales.customers
where [state]='ca'
group by [city]
having count(*)>10
order by [city]

select * from [sales].customers

select [first_name], [last_name],len(first_name) 
from sales.customers
order by len(first_name) desc

select [first_name], [last_name],len(concat(first_name,last_name)) 
from sales.customers
order by len(concat(first_name,last_name))

create table [Hr].[test_tbl](
							[id] int primary key,
							[name] varchar(40),
							[price] decimal(10,2)
							)
insert into [Hr].[test_tbl](id,name,price) values(1,'A',40.34),
												(2,'B',56.34),
												(3,'C',89.34),
												(4,'D',34.34),
												(5,'E',78.34),
												(6,'F',33.34),
												(7,'G',23.34),
												(8,'H',67.34),
												(9,'I',89.34),
												(10,'G',80.34)

select * from [Hr].[test_tbl]

select [name],[price]
from [HR].[test_tbl]
order by [id]
offset 5 rows
fetch next 3 rows only


select top 3 [name],[price]
from [HR].[test_tbl]
order by [price] desc

SELECT distinct city
FROM sales.customers
ORDER BY city;

use BikeStores
SELECT c.id candidate_id, c.fullname candidate_name, e.id employee_id, e.fullname employee_name
FROM hr.candidates c
FULL JOIN hr.employees e
ON e.fullname = c.fullname

select * from sales.stores

select s.[store_id], p.[product_id] isnull(sales,0) as sales
from sales.[stores] as s
cross join production.products as p
left join(
			select s.[store_id],p.[product_id],sum(quantity*i.[list_price]) as sales
			from [sales].[orders] as o
			inner join [sales].[order_items] as i on i.[order_id]=o.[order_id]
			inner join [sales].[stores] as s on s.[store_id]=o.[store_id]
			inner join [production].[products] as p on p.[product_id]=i.[product_id]
			group by s.[store_id],p.[product_id]
) c on c.[store_id]=s.[store_id] and c.[product_id]=p.[product_id]
where sales is null
order by [product_id],[store_id]



SELECT s.store_id, p.product_id,
ISNULL(sales, 0) as sales
FROM sales.stores as s
CROSS JOIN production.products as p
LEFT JOIN (
			SELECT s.store_id, p.product_id, SUM (quantity * i.list_price)as sales
			FROM sales.orders o
			INNER JOIN sales.order_items i ON i.order_id = o.order_id
			INNER JOIN sales.stores s ON s.store_id = o.store_id
			INNER JOIN production.products p ON p.product_id = i.product_id
			GROUP BY s.store_id, p.product_id
) c ON c.store_id = s.store_id AND c.product_id = p.product_id
WHERE sales IS NULL
ORDER BY product_id, store_id;

create table [hr].[emp_tbl](
							[emp_id] int primary key,
							[emp_name] varchar(30) not null,
							[manager_id] int foreign key references [hr].[emp_tbl]([emp_id])
							);

insert into [HR].[emp_tbl]([emp_id],[emp_name]) values(1,'A')
insert into [HR].[emp_tbl]([emp_id],[emp_name],[manager_id]) values (2,'B',1),
																	(3,'C',1),
																	(4,'D',2),
																	(5,'E',3),
																	(6,'F',2),
																	(7,'G',3),
																	(8,'H',5)
select * from [HR].[emp_tbl]

select e.[emp_name] as Employee ,m.[emp_name] as Manager  
from [HR].[emp_tbl] as e
inner join [HR].[emp_tbl] as m
on e.manager_id=m.emp_id 


select e.[emp_name] as Employee ,m.[emp_name] as Manager  
from [HR].[emp_tbl] as e
left join [HR].[emp_tbl] as m
on e.manager_id=m.emp_id 

create table [sales].[targets]
(
[target_id] int primary key,
[percentage] decimal(4, 2) not null default 0 
);

insert into [sales].[targets] ([target_id],[percentage])values


														(2,0.3),
														(3,0.5), 
														(4,0.6), 
														(5,0.8);

create table [sales].[commissions](
									[staff_id] int primary key,
									[target_id] int,
									[base_ammount] decimal(10,2) not null default 0,
									[commission] decimal(10,2) not null default 0,
									foreign key([target_id]) references [sales].[targets]([target_id]),
									);
Insert into [sales].[commissions] ([staff_id], [base_ammount],[target_id]) values (1,100000,2), (2,120000,1),(3,80000,3),(4,900000,4),
(5,950000,5);

select * from [sales].[targets]
select * from [sales].[commissions]

update [sales].[commissions] 
set [sales].[commissions].[commission] =c.[base_ammount] * t.[percentage]
from [sales].[commissions] as c 
inner join [sales].[targets] as t
on c.target_id = t.target_id;

insert into [sales].[commissions]([staff_id],[base_ammount],[target_id]) values
																		(6,100000,null),
																		(7,12000,null);

update [sales].[commissions]
set [sales].[commissions].[commission]=[base_ammount]*coalesce(t.[percentage],0.1)
from [sales].[commissions] as c 
left join [sales].[targets] as t
on c.target_id = t.target_id;

select * from [sales].commissions


create table[HR].[product_tbl](
								[pro_id] int primary key,
								[pro_name] varchar(30) not null
								)
create table [HR].[order_tbl](
								[o_id] int primary key,
								[o_date] date,
								[pro_id] int foreign key references [HR].[product_tbl]([pro_id])
								)
insert into [HR].[product_tbl]([pro_id],[pro_name]) values 
															(1,'Dress'),(2,'jacket'),(3,'Shirt')
insert into [HR].[order_tbl]([o_id],[o_date],[pro_id]) values 
															(101,'2024/01/12',1),(102,'2024/01/23',1),(103,'2024/02/22',2)

select * from [HR].[product_tbl]
select * from [HR].[order_tbl]


delete o from [HR].[order_tbl] as o
left join [HR].[product_tbl] as p on p.[pro_id]=o.[pro_id]
where o.[pro_id]=2


--small assignment
use PracticeDB

select c.firstname,c.lastname, c.phone,o.OrderNumber,o.totalamount 
from dbo.Customer as c
inner join dbo.[Order] as o 
on c.Id=o.CustomerId
where o.[TotalAmount]>2000

select firstname,city,country  
from [dbo].[Customer] where Country=(select country from [dbo].[Customer] where firstname='rita')

select s.id, s.companyname,s.Country,s.phone,p.id,p.productname 
from [dbo].[Supplier] as s
inner join [dbo].[Product] as p on s.[id]=p.[SupplierId]
where p.[IsDiscontinued]=1

select * from [dbo].[Product]

select o.id,o.orderdate,TotalAmount from [dbo].[Order] as o
join [dbo].OrderItem as oi on oi.[orderid]=o.[id]
where oi.OrderId is null

select c.firstname,o.OrderNumber,oi.quantity 
from [dbo].Customer as c
inner join [dbo].[Order] as o on c.Id=o.CustomerId
inner join [dbo].OrderItem as oi on oi.OrderId=o.Id

select o.OrderNumber,c.FirstName,count(*) as 'total'
from [dbo].Customer as c
inner join [dbo].[Order] as o on c.Id=o.CustomerId
inner join [dbo].OrderItem as oi on oi.OrderId=o.Id
group by o.OrderNumber,c.FirstName

select FirstName,lastname,city 
from [dbo].[Customer] 
where FirstName like('%th')

use BikeStores

select s.store_name,s.city , p.product_name,oi.quantity 
from [production].[products] as p
inner join [sales].order_items as oi on p.product_id=oi.product_id
inner join [production].stores as s on s.prod



select s.first_name as staff, m.first_name as manager
from [sales].staffs as s
left  join [sales].staffs as m
on s.manager_id=m.staff_id

use BikeStores
select c.category_name, cast(round(AVG(p.list_price),2)  as dec(10,2)) as avg_product_price
from production.products as p
inner join production.categories as c
on p.category_id=c.category_id
group by c.category_name
order by c.category_name

select c.category_name, cast(round(AVG(p.list_price),2)  as dec(10,2)) as avg_product_price
from production.products as p
inner join production.categories as c
on p.category_id=c.category_id
group by c.category_name
having cast(round(AVG(p.list_price),2)  as dec(10,2)) >500
order by c.category_name

select count(*) as product_count
from production.products
where list_price>500

select * into [bikestores].[hr].[employe]
from [HRDB].[dbo].employees

select * from [hr].[employe]

select department_id,sum(salary) as total,count(department_id) as totalEmplyee
from [BikeStores].[HR].[employe]
group by [department_id]


select manager_id,count(first_name)
from HR.employe
group by manager_id

select m.first_name, count(e.employee_id) as 'totalEmp'
from HR.employe as e
join HR.employe as m
on e.manager_id=m.employee_id
group by m.first_name

select customer_id,year(order_date) as order_year,count(order_id) as order_placed 
from sales.orders 
where customer_id in(1,2)
group by customer_id,year(order_date)
order by customer_id

select c.first_name,o.customer_id,year(o.order_date) as order_year,count(o.order_id) as order_placed 
from sales.customers as c
inner join sales.orders as o on c.customer_id=o.customer_id
where o.customer_id in(1,2)
group by c.first_name,o.customer_id,year(o.order_date)
order by o.customer_id


select b.brand_name,min(p.list_price) as min_value,max(p.list_price) as max_value
from production.brands as b
inner join production.products as p on b.brand_id=p.brand_id
where p.model_year=2018
group by  b.brand_name
order by  b.brand_name


use HRDB 
--1.write a quary to find department without employee
select b.department_id,count(a.department_id) as 'total'
from [dbo].departments as b
left outer join [dbo].employees as a ON a.department_id=b.department_id
group by b.department_id
having count(a.department_id) = 0;

--2.write a quary to find employees whose salary is less than emp_id =192
--first name, last name , salary
select first_name,last_name,salary
from dbo.employees
where employee_id=192

select first_name,last_name,salary
from dbo.employees where salary<(select salary from [dbo].employees where employee_id=192)


--3.find employees who works in the same department as employee with last name taylor
select * from [dbo].employees
where last_name='taylor'

select e.first_name, e.last_name
from [dbo].employees as e
inner join [dbo].dependents as d
on e.employee_id=d.employee_id
where e.last_name='taylor'


--4.find out all employee who have joined 1st january 1993 and before 31st aug 1997

select * from [dbo].employees
where hire_date between '1993/01/01' and '1997/08/31'

--5.write a quary to calculate avg salary number of employee reciving the commission in the dept 
--deptname, avg salary, number of emp

--6.find out depatmens who has atleast 2 comployee, group the result on country name
--country name, city, number of employee
select c.country_name,l.city, count(d.department_id) as 'Total'
from [dbo].countries as c
inner join [dbo].locations as l on c.country_id=l.country_id
inner join [dbo].departments as d on l.location_id=d.location_id
group by c.country_name,l.city 
having count(d.department_id)>2

select DATEDIFF(dd,hire_date,GETDATE()) as 'Days'
from dbo.employees



--write a quary to calculate number of days work by employees in a department

select d.department_id, max(e.salary) as max_sal
from [dbo].departments as d
inner join [dbo].employees as e on d.department_id=e.department_id
group by d.department_id

--display emp_name,depart name, country name whose joining date is 1997
select e.first_name,d.department_name,c.country_name, e.hire_date
from [dbo].employees as e
inner join [dbo].departments as d on d.department_id=e.department_id
inner join [dbo].locations l on l.location_id=d.location_id
inner join [dbo].countries as c on c.country_id=l.country_id
where hire_date like '1997%'

--write a quary to dispaly the region_name, job_title,no of employees agaist region
select r.region_name, j.job_title,COUNT(e.employee_id) as 'total'
from [dbo].regions as r 
join [dbo].countries as c on c.region_id=r.region_id
join [dbo].locations as l on l.country_id=c.country_id
join [dbo].departments as d on d.location_id=l.location_id
join [dbo].employees as e on e.department_id=d.department_id
join [dbo].jobs as j on j.job_id=e.job_id
group by r.region_name, j.job_title


use BikeStores

select o.order_id,o.order_date ,(select MAX(oi.list_price) from [sales].order_items as oi 
where oi.[order_id]=o.[order_id]) as 'max_price'
from [sales].orders as o
order by order_date

select o.order_id,o.order_date,MAX(list_price) as Max_list_price
from [sales].orders as o
inner join sales.order_items as oi on o.order_id=oi.order_id
group by o.order_id,o.order_date
order by order_date

select b.brand_name,b.brand_id from [production].brands as b 
where b.brand_name='strider' or b.brand_name='trek'

select product_name, list_price
from [production].[products] 
where list_price >( select AVG(list_price) from [production].products
where brand_id in (select brand_id from [production].brands as b
where brand_name='strider' or brand_name='trek' ))
order by list_price;

select p.product_name,p.list_price
from [production].[products] as p 
inner join [production].[brands] as b on b.[brand_id]=p.[brand_id]
where b.brand_name='strider' or b.brand_name='trek' and p.list_price>(select AVG(list_price) from [production].[products])


/*select c.first_name, c.email, c.city ,p.product_name 
from [sales].[customers] as c
inner join [sales].[orders] as o on c.customer_id=o.c8*/

select c.first_name, c.email, c.city 
from [sales].customers as c 
where city='port washington'

select c.first_name, c.email, c.city ,product_name
from [sales].[customers] as c where c.customer_id in ( select c.customer_id from [sales].orders as o 
where o.order_id in (select o.order_id from [sales].order_items as oi where oi.order_id=o.order_id and 
oi.product_id in (select p.product_id from [production].products as p

select c.customer_id from [sales].customers as c
where city='port washington'

select o.order_id from [sales].orders as o where customer_id in (select c.customer_id from [sales].customers as c
where city='port washington')

select oi.order_id from [sales].order_items as oi
where oi.order_id in (select o.order_id from [sales].orders as o where customer_id in (select c.customer_id from [sales].customers as c
where city='port washington'))

select p.product_name ,p.product_id
from [production].products as p 
where p.product_id in (select oi.product_id from [sales].order_items as oi
where oi.order_id in (select o.order_id from [sales].orders as o where customer_id in (select c.customer_id from [sales].customers as c
where city='port washington')))

select AVG(list_price)  as avg_list_price
from production.products 
group by brand_id

SELECT product_name, list_price
FROM production.products
WHERE list_price<= ANY ( SELECT min (list_price) FROM production.products group by brand_id)
order by list_price

select customer_id, first_name, last_name,city
from sales.customers as c where exists(select customer_id from sales.orders as o 
where o.customer_id=c.customer_id and YEAR(order_date)=2017)
order by first_name, last_name

SELECT [product_name], list_price, (SELECT AVG(list_price) FROM Production.products) AS Average, list_price - (SELECT
AVG(list_price) FROM Production.products) AS Difference
FROM Production.Products


SELECT product_name, list_price, category_id
FROM production.products p1
WHERE list_price IN ( SELECT MAX (p2.list_price)
FROM production.products p2
WHERE p2.category_id = p1.category_id
GROUP BY p2.category_id )
ORDER BY category_id, product_name;

use HRDB
select first_name, salary, YEAR(hire_date)
from [dbo].employees as e1 
where YEAR(hire_date) in ( select year(e1.hire_date)
from [dbo].employees as e2
where year(e2.hire_date)=year(e1.hire_date)
group by year(e2.hire_date)
having count(*)>2
)order by year(e1.hire_date)


select employee_id,first_name,salary
from [dbo].[employees] as e1
where salary>(select AVG(e2.salary)
from [dbo].[employees] as e2
where e2.department_id=e1.department_id)
order by salary desc





--30/01/2024
--Apply operator
use studentDB
drop table [hr].Department
Create Table [hr].Department_1
(
[Id] int primary key,
[DepartmentName] nvarchar(50)
)
Insert into [hr].Department_1 values (1, 'IT')
Insert into [hr].Department_1 values (2, 'HR')
Insert into [hr].Department_1 values (3, 'Payroll')
Insert into [hr].Department_1 values (4, 'Administration')
Insert into [hr].Department_1 values (5, 'Sales')

Create table [hr].Employee_1
(
[Id] int primary key,
[Name] nvarchar(50),
[Gender] nvarchar(10),
[Salary] int,
[DepartmentId] int foreign key references [hr].Department_1(Id)
)
Insert into [hr].Employee_1 values (1, 'Mark', 'Male', 50000, 1)
Insert into [hr].Employee_1 values (2, 'Mary', 'Female', 60000, 3)
Insert into [hr].Employee_1 values (3, 'Steve', 'Male', 45000, 2)
Insert into [hr].Employee_1 values (4, 'John', 'Male', 56000, 1)
Insert into [hr].Employee_1 values (5, 'Sara', 'Female', 39000, 2)

create function fn_getEmpByDeptID(@Department_id int)
returns table
as 
return
(
		select [id],[name],[gender],[salary],[DepartmentId]
		from [HR].Employee_1 
		where [DepartmentId]=@Department_id
)

select * from fn_getEmpByDeptID(1)

select d.id,e.[name],e.gender,e.salary
from [HR].Department_1 as d
cross apply fn_getEmpByDeptID(d.id) as e 

select d.id,e.[name],e.gender,e.salary
from [HR].Department_1 as d
outer apply fn_getEmpByDeptID(d.id) as e 

select d.id,e.[name],e.gender,e.salary
from [HR].Department_1 as d
cross apply [hr].Employee_1 as e
where e.Salary>5000
order by e.Salary

create table [hr].[developer_tbl](
								[dev_id] int primary key,
								[dev_name] varchar(30), 
								[dev_salary] money,
								[location] varchar(40)
								)

insert into [hr].[developer_tbl] values 
(1,'Avik',50000,'kolkata'),(2,'Subrata',15000,'Behala'),(3,'Koyel',33000,'salt lake'),(4,'Ankita',24000,'kolkata'),(5,'Spandita',44000,'howrah')

--drop table [hr].[projects]
create table [hr].[projects_tbl](
							[project_id] int primary key,
							[project_name] varchar(60),
							[devoloper_id] int foreign key references [hr].[developer_tbl]([dev_id])
							)
						
insert into [hr].[projects_tbl] values
(1,'Skin lession segmentation using u-net',1),
(2,'Catarct detection using u-net',1),
(3,'calcutta university marks project',2),
(4,'libary management system',3),
(5,'MCC pms management system',1),
(6,'Sql server log histry project',5)


select * from [HR].developer_tbl
select * from [HR].projects_tbl

create function fn_getprojectByDevID(@developer_id int)
returns table
as 
return
(
		select [project_id],[project_name],[devoloper_id]
		from [hr].[projects_tbl]
		where [devoloper_id]=@developer_id
)


select * from fn_getprojectByDevID(1)

select d.[dev_id],d.[dev_name],d.[dev_salary],d.[location],p.[project_id],p.[project_name] 
from [hr].[developer_tbl] as d
cross apply fn_getprojectByDevID(d.dev_id) as p 


select d.[dev_id],d.[dev_name],d.[dev_salary],d.[location],p.[project_id],p.[project_name] 
from [hr].[developer_tbl] as d
outer apply fn_getprojectByDevID(d.dev_id) as p
--where p.project_id is null

use BikeStores
create function fn_getOrderdetailsBycusID(@cust_id int)
returns table
as 
return
(
		select order_id,order_date,[customer_id]
		from [sales].orders
		where [customer_id]=@cust_id
)

select * from fn_getOrderdetailsBycusID(1)

select c.customer_id,c.first_name,c.last_name,c.email,c.city,o.order_id,o.order_date 
from [sales].[customers] as c
cross apply fn_getOrderdetailsBycusID(c.customer_id) as o


select c.customer_id,c.first_name,c.last_name,c.email,c.city,o.order_id,o.order_date 
from [sales].[customers] as c
outer apply fn_getOrderdetailsBycusID(c.customer_id) as o
where o.customer_id is null

use studentDB
-- Create the author table
CREATE TABLE [hr].author (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

-- Create the book table with a foreign key relationship
CREATE TABLE [hr].book (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(255) NOT NULL,
    publish_date DATE,
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES [hr].author(author_id)
);

-- Insert data into the author table
INSERT INTO [hr].author (author_id, author_name) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Bob Johnson');

-- Insert data into the book table
INSERT INTO [hr].book (book_id, book_name, publish_date, author_id) VALUES
(101, 'The Mystery of the Lost Key', '2022/01/15', 1),
(102, 'The Adventure in the Hidden Cave', '2022/02/20', 2),
(103, 'Coding for Beginners', '2022/03/10', 3),
(104, 'Data structure', '2024/01/15', 3),
(105, 'Python', '2024/01/01', null),
(106, 'Core java', '2023/02/02', 2),
(107, 'C programming', '2024/01/01', null),
(108, 'RDBMS', '2023/08/01', 1),
(109, 'Shell script', '2024/01/05', null),
(110, 'Soft skils', '2024/01/08', 2)


drop function fn_getAuthorByBookID
create function fn_getAuthorByBookID(@auth_id int)
returns table
as 
return
(
		select top (1) book_id, book_name, publish_date, author_id
		from [hr].book
		where author_id=@auth_id
		order by publish_date desc ,author_id
	
)

select * from fn_getAuthorByBookID(1)


select a.author_id,a.author_name,b.book_id, b.book_name, b.publish_date
from [hr].author  as a
cross apply fn_getAuthorByBookID(a.author_id) as b


select a.author_id,a.author_name,b.book_id, b.book_name, b.publish_date
from [hr].author  as a
outer apply fn_getAuthorByBookID(a.author_id) as b


-- Create the bank_customer table
CREATE TABLE [hr].bank_customer (
    cust_id INT PRIMARY KEY,
    cust_name VARCHAR(255) NOT NULL
);

-- Create the bank table with a foreign key relationship
CREATE TABLE [hr].bank (
    bank_id INT PRIMARY KEY,
    bank_name VARCHAR(255) NOT NULL,
    account_number VARCHAR(20) NOT NULL,
    account_type VARCHAR(50) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL,
    cust_id INT,
    FOREIGN KEY (cust_id) REFERENCES [hr].bank_customer(cust_id)
);

-- Insert sample data into the bank_customer table
INSERT INTO [hr].bank_customer (cust_id, cust_name) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Bob Johnson'),
(4, 'Alice Brown'),
(5, 'Charlie White'),
(6, 'Eva Green'),
(7, 'David Black'),
(8, 'Sophie Red'),
(9, 'Mike Grey'),
(10, 'Olivia Blue');

-- Insert sample data into the bank table
INSERT INTO [hr].bank (bank_id, bank_name, account_number, account_type, balance, cust_id) VALUES
(101, 'ABC Bank', '1234567890', 'Savings', 5000.00, 1),
(102, 'XYZ Bank', '9876543210', 'Checking', 10000.00, 2),
(103, 'PQR Bank', '5678901234', 'Savings', 7500.00, 3),
(104, 'LMN Bank', '3456789012', 'Checking', 12000.00, 1),
(105, 'JKL Bank', '6789012345', 'Savings', 3000.00, 4),
(106, 'RST Bank', '0123456789', 'Checking', 8000.00, 4),
(107, 'UVW Bank', '7890123456', 'Savings', 9500.00, 5),
(108, 'MNO Bank', '2345678901', 'Checking', 6000.00, 3),
(109, 'GHI Bank', '4567890123', 'Savings', 4000.00, 7),
(110, 'DEF Bank', '8901234567', 'Checking', 11000.00, 10);

drop function fn_getCustBybankID
create function fn_getCustBybankID(@cust_id int)
returns table
as 
return
(
		select top (1) bank_id, bank_name, account_number, account_type, balance, cust_id
		from [hr].bank
		where cust_id=@cust_id
		order by balance desc ,bank_id
)

select c.cust_id,c.cust_name,b.bank_id, b.bank_name, b.account_number, b.account_type, b.balance
from [hr].bank_customer  as c
cross apply fn_getCustBybankID(c.cust_id) as b

select c.cust_id,c.cust_name,b.bank_id, b.bank_name, b.account_number, b.account_type, b.balance
from [hr].bank_customer  as c
outer apply fn_getCustBybankID(c.cust_id) as b




select nullif('abc','abc') as result
select nullif('abc','10') as result


use BikeStores
select * from sales.customers
where phone is not null

select coalesce(phone,'N/A') from sales.customers

select @@IDENTITY

use studentDB
create table [hr].[temp_tbl](
						[tem_id] int identity(101,1) constraint temp_tbl_pk primary key,
						[tem_name] varchar(20)
						)
select @@IDENTITY

--Query: Find students who have not enrolled in any courses using except set operator.

create schema MC
 create table [mc].[student_tbl](
								std_id int primary key,
								std_name varchar(30)
								)

insert into [mc].[student_tbl] values(1,'Sabita'),(2,'Kanchona'),(3,'Horipriya'),(4,'Nilanjana'),(6,'sumaya')

create table [mc].[course_tbl](
								cour_id int primary key,
								cour_name varchar(40),
								enrolled_id int foreign key references [mc].[student_tbl](std_id)
								)
INSERT INTO [mc].[course_tbl] (cour_id, cour_name, enrolled_id) VALUES
(1, 'Mathematics', 1),    
(2, 'Physics', 6),
(3, 'History', 3),
(4, 'Computer Science', 1),
(5, 'English', 3);

select std_id, std_name
from [MC].student_tbl
except
select enrolled_id,std_name
from [MC].course_tbl
JOIN [mc].[student_tbl] ON [mc].[course_tbl].enrolled_id = [mc].[student_tbl].std_id;

--Query: Display employees who are both managers and have a salary greater than 45000 using intersect. 
--Employees table have employee_id,employee_name, job_title, salary columns.
create table [mc].[Employees] (
    [employee_id] INT PRIMARY KEY,
    [employee_name] VARCHAR(50),
    [job_title] VARCHAR(50),
    [salary] DECIMAL(10, 2)
);

INSERT INTO [mc].[Employees] (employee_id, employee_name, job_title, salary) VALUES
(1, 'subrata', 'Manager', 50000.00),
(2, 'Pranav', 'Manager', 55000.00),
(3, 'Rahul', 'Clerk', 42000.00),
(4, 'priyanka', 'Manager', 48000.00),
(5, 'annesha', 'Manager', 46000.00),
(6, 'Tubai', 'Clerk', 40000.00);

select employee_id,employee_name,job_title
from [MC].Employees 
where job_title='manager' and salary>45000
intersect
select employee_id,employee_name,job_title
from MC.Employees

--Query: Customers who have placed an order along with their order information and also those 
--customers who have not placed any orders using union.
use studentDB
create schema mc

create table [mc].customer_tbl(
								cust_id int primary key,
								cust_name varchar(30),
								city varchar(40),
								salary money,
								depart_id int
							)

insert into  [mc].customer_tbl (cust_id, cust_name, city, salary, depart_id) values (1, 'Subara', 'kolkata', 50000.00, 1),
(2, 'Pritam', 'salt lake', 60000.50, 1),
(3, 'Rahul', 'Behala', 55000.75, 3),
(4, 'Souvik', 'newtown', 70000.25, 4),
(5, 'Pranb', 'DLF1', 65000.80, 3);


create table [mc].order_placed(
								or_id int primary key,
								or_name varchar(30),
								or_no int,
								cust_id int,
								constraint or_tbl_fk foreign key (cust_id)  references [mc].customer_tbl(cust_id)
							)

INSERT INTO [mc].order_placed (or_id, or_name, or_no, cust_id)
VALUES
    (1, 'Order1', 101, 1),
    (2, 'Order2', 102, 1),
    (3, 'Order3', 103, 3),
    (4, 'Order4', 104, 5),
    (5, 'Order5', 105, 5);

select * from mc.customer_tbl
select * from mc.order_placed

select c.cust_id, c.cust_name,c.city, o.or_id,o.or_no
from mc.customer_tbl as c
inner join mc.order_placed as o
on c.cust_id=o.cust_id
union
select c.cust_id, c.cust_name,c.city, o.or_id,o.or_no
from mc.customer_tbl as c
left outer join mc.order_placed as o
on c.cust_id=o.cust_id
where o.or_id is null

--Query: Display employees whose salary is greater than the average salary in their department using correlated subquery.
select * from mc.customer_tbl

select cust_id,cust_name,city,salary
from mc.customer_tbl as c1
where salary>(select AVG(salary) from mc.customer_tbl as c2
				where c2.depart_id=c1.depart_id
				group by depart_id)

insert into  [mc].customer_tbl (cust_id, cust_name, city, salary, depart_id) values (6, 'pappu', 'kolkata', 80000.00, 3)

--Query : Find customers who have placed orders with an amount greater than the average order amount using correlated subquery.
select * from mc.customer_tbl
select * from mc.order_placed

select c1.cust_id,c1.cust_name,c1.city,c1.salary, o.or_id, o.or_name
from mc.customer_tbl as c1, mc.order_placed as o
where o.cust_id=c1.cust_id and salary>
(select AVG(salary) from mc.customer_tbl as an where c1.cust_id=an.cust_id
group by cust_id)

 



select c1.cust_id,c1.cust_name,c1.city,c1.salary, o.or_id, o.or_name
from mc.customer_tbl as c1
inner join mc.order_placed as o 
on c1.cust_id=o.cust_id 
where salary>(select AVG(salary) from mc.customer_tbl as c2 where c2.cust_id=o.cust_id)

select SUBSTRING ('Sql server',1,4)

---31/01/2024
--fromat fucntion
declare @d date=getdate()
select FORMAT(@d,'dd/MM/yyyy','en-US') as 'date'

declare @dt datetime=getdate()
select FORMAT(getdate(),'dd/MM/yyyy hh:mm tt') as 'Today'


select FORMAT(123456789,'XXX-XX-XXXX') as 'customer number'

SELECT 
  CONCAT(
    SUBSTRING(FORMAT(123456789, 'XXXXXXXXXX'), 1, 4),
    '-',
    SUBSTRING(FORMAT(123456789, '000000000'), 5, 4)
  ) AS 'Last_digit_of_Account_number';


select STUFF(123456789,1,5,'XXXXX-')

use BikeStores
SELECT order_id, required_date, shipped_date,
CASE WHEN DATEDIFF(day, required_date, shipped_date) > 0
THEN 'Late' ELSE 'OnTime'
END shipment
FROM sales.orders
WHERE shipped_date IS NOT NULL
ORDER BY required_date;


--only specific part display from the date
select DATEPART(MONTH,getdate()) as 'year'

--the gate date function returns date and time so if we want to covert into date we use this . so it will delete the time
SELECT CONVERT(DATE, GETDATE()) date;
select CONVERT(char,GETDATE(),100)

--another whay to display
 -- using cast
 SELECT CAST(GETDATE() AS DATE) as 'date';


 SELECT TRY_CAST('12.34' AS DECIMAL(4, 2)) Result -- display 12.34 no error
 SELECT TRY_CAST('14562.34' AS DECIMAL(4, 2)) Result -- display null because there is an error

 SELECT TRY_CAST(GETDATE() AS DATE) Result;


 SELECT ROUND(235.465, 2) AS RoundValue

 SELECT ISNUMERIC('gte') result;


 select isnumeric(salary) as is_numeric
 from HR.employee

 select * from HR.employee
 
 insert into [HR].employee(emp_name,dept_id) values('mm',101)

 SELECT value
FROM STRING_SPLIT('I am a boy', ' ');


SELECT NEWID() AS GUID;

use BikeStores

SELECT * FROM (
SELECT product_id,product_name,brand_id,list_price, rank () OVER (
PARTITION BY brand_id
ORDER BY list_price DESC
) price_rank
FROM production.products
) t
WHERE price_rank <= 3;


SELECT * FROM (
SELECT product_id,product_name,brand_id,list_price, dense_rank () OVER (
PARTITION BY brand_id
ORDER BY list_price DESC
) price_rank
FROM production.products
) t
--WHERE price_rank <= 3;


SELECT first_name, last_name, city,
ROW_NUMBER() OVER (PARTITION BY city ORDER BY first_name ) row_num
FROM sales.customers
ORDER BY city;

use studentDB


insert into hr.emp_tbl(emp_name,gender,address,salary,doj,dept_id)values ('subrata pal','M','New Alipore',33000,'2024-01-16',101)


select emp_id,emp_name,address,dept_id,
ROW_NUMBER() over(partition by dept_id order by address) as 'row_number'
from [HR].emp_tbl
order by address

use BikeStores
select * from HR.order_tbl
select * from HR.product_tbl

INSERT INTO [hr].product_tbl (pro_id, pro_name)
VALUES
    (4, 'Jeans'),
    (5, 'Jeans'),
    (6, 'Shirt'),
    (7, 'Sweater'),
    (8, 'Dress');

-- Assuming you have already created the order table
INSERT INTO hr.order_tbl (o_id, o_date, pro_id)
VALUES
    (103, '2024-02-05', 2),
    (104, '2024-02-18', 3),
    (105, '2024-03-02', 2),
    (106, '2024-03-15', 1);

select * from HR.order_tbl
select * from HR.product_tbl

SELECT * FROM (
SELECT o_id,o_date,pro_id, dense_rank () OVER (
PARTITION BY pro_id
ORDER BY o_date 
) as 'rank_details'
FROM HR.order_tbl
) t


--  delete dublicate rows from based on title and author from books table book_id,title,author id publish year using row number
use studentDB
select * from [HR].book

with cte as(
select *, ROW_NUMBER() over(partition by author_id order by publish_date) as rowNumber
from HR.book
)
delete from cte where rowNumber>1

select * from cte


-- Create the sales table
CREATE TABLE hr.sales (
    transiton_id INT primary key,
    sales_rp_id INT,
    transtion_date DATE,
    ammount DECIMAL(10, 2)
);
drop table sales
-- Insert 10 rows of data into the sales table
INSERT INTO hr.sales (transiton_id, sales_rp_id, transtion_date, ammount)
VALUES
    (1, 101, '2024-01-01', 500.50),
    (2, 102, '2023-03-02', 150.75),
    (3, 101, '2023-01-03', 200.00),
    (4, 101, '2024-03-04', 120.25),
    (5, 103, '2022-02-03', 80.75),
    (6, 103, '2024-04-06', 150.00),
    (7, 102, '2024-01-04', 300.50),
    (8, 108, '2024-01-01', 60.25),
    (9, 109, '2024-01-03', 200.75),
    (10, 110, '2024-03-03', 90.00);

select * from HR.sales

--dense rank: Assign a rank  to sales representatives based on their total sales amount on table having 

select * from (
select transiton_id, sales_rp_id, transtion_date, sum(ammount) as 'total_salary', DENSE_RANK() over(
partition by sales_rp_id
order by transtion_date
) as sales_rp_rank
from HR.sales
) t

select 
from [HR]

--01/02/2024


use Exam_DB
select name from sysobjects 
where xtype='U'

use BikeStores

select count(order_id) from sales.orders
where order_status=1 and YEAR(order_date)=201

SELECT order_status,COUNT(order_id) as order_count
FROM sales.orders
WHERE YEAR(order_date) = 2018
GROUP BY order_status;

select * from sales.orders

insert into sales.orders(customer_id,order_status,order_date,required_date,store_id,staff_id) values
(259,5,'2018-01-01','2018-01-03',2,6)
insert into sales.orders(customer_id,order_status,order_date,required_date,store_id,staff_id) values
(324,5,'2018-01-01','2018-01-03',2,6)

SELECT
CASE order_status
	WHEN 1 THEN 'Pending'
	WHEN 2 THEN 'Processing'
	WHEN 3 THEN 'Rejected'
	WHEN 4 THEN 'Completed'
	
END AS order_status,
COUNT(order_id) order_count
FROM sales.orders
WHERE YEAR(order_date) = 2018
GROUP BY order_status;

SELECT 
			SUM(CASE WHEN order_status = 1 THEN 1 ELSE 0 END) AS 'Pending',
			SUM(CASE WHEN order_status = 2 THEN 1 ELSE 0 END) AS 'Processing',
			SUM(CASE WHEN order_status = 3 THEN 1 ELSE 0 END) AS 'Rejected',
			SUM(CASE WHEN order_status = 4 THEN 1 ELSE 0 END) AS 'Completed',
		COUNT(*) AS Total
FROM sales.orders
WHERE YEAR(order_date) = 2018;



declare @id int
set @id=0
while @id<10
begin

	/*if @id=3
	begin
		continue
	end*/

	print @id
	set @id=@id+1
end


CREATE TABLE SampleTable(
						Id INT, 
						CountryName NVARCHAR(100), 
						ReadStatus TINYINT
						)

INSERT INTO SampleTable ( Id, CountryName, ReadStatus) Values 
(1, 'Germany', 0),
(2, 'France', 0),
(3, 'Italy', 0),
(4, 'Netherlands', 0) ,
(5, 'Poland', 0)

SELECT * FROM SampleTable


declare @counter int,@maxId int, @countryName nvarchar(100)
select @counter=min(id),@maxId=max(id)
from SampleTable
WHILE(@Counter IS NOT NULL AND @Counter <= @MaxId)
BEGIN
	SELECT @CountryName = @CountryName
	FROM SampleTable 
	WHERE id = @Counter
	PRINT CONVERT(VARCHAR,@Counter) + '. country name is ' + @CountryName
	SET @Counter = @Counter + 1
END

DECLARE @Counter INT , @MaxId INT,@CountryName NVARCHAR(100)
SELECT @Counter = min(Id) , @MaxId = max(Id)
FROM SampleTable
WHILE(@Counter IS NOT NULL
AND @Counter <= @MaxId)
BEGIN
SELECT @CountryName = CountryName
FROM SampleTable WHERE Id = @Counter
PRINT CONVERT(VARCHAR,@Counter) + '. country name is ' + @CountryName
SET @Counter = @Counter + 1
END


declare @i int= 1
while @i<5 
begin 
	print replicate('*',@i)
	set @i=@i+1
end

declare @i int= 1
while @i<5 
begin 
	print replicate(' ',5-@i)+replicate('*',@i)
	set @i=@i+1
end

declare @i int= 5
while @i>0 
begin 
	print replicate('*',@i)
	set @i=@i-1
end

declare @i int= 1
while @i<5
begin 
	print replicate(0+@i,@i)
	set @i=@i+1
end


create table bikeshop(
						id int primary key identity,
						bike_name varchar(50) not null,
						price float
						);

declare @countId int=1
while @countId<=10
begin
	insert into bikeshop values('Bike-'+CAST(@countid as varchar),@countId*500)
	set @countId=@countId+1
end

select * from bikeshop



declare @start_date date ='2023/01/17'
declare @end_date date='2024/01/26'

declare @loop_date date=@start_date

while @loop_date<=@end_date
begin
		select @loop_date
		set @loop_date=dateadd(day,1,@loop_date)
end



declare @i int =0
while @i<9
begin
	set @i=@i+1
	if @i=5
		continue
	print @i
	
end

alter function fn_getAge(@dob date)
returns int 
as
begin
	declare @age int
	if (month(@dob)>6)
	begin
		set @age=datediff(year,@dob,getdate())+1
	end
	else  
	begin
		set @age=datediff(year,@dob,getdate())
	end
	return @age
end

select dbo.fn_getAge('1982/12/10') as age

use bikestores
--Multi-Statement Table-Valued Function
alter function fn_udfGetEmploye()
returns @Employee table(
	first_name varchar(50),
	last_name varchar(40),
	phone varchar(20),
	employee_type varchar(20)
	)
	as
	begin
		insert into @Employee 
		select first_name,last_name,phone,'Manager'
		from sales.customers

		insert into @Employee 
		select first_name,last_name,phone,'staff'
		from sales.customers
	return
	end;

select * from fn_udfGetEmploye();


--one inline table valued function
use 

use Exam_DB
select name from sysobjects 
where xtype='U'

create table mcc.customer_tbl(
								cust_id int primary key,
								cust_name varchar(50),
								city varchar(50),
								salary money,
								gender char(4)
								)

								
insert into mcc.customer_tbl (cust_id, cust_name, city, salary, gender)values
(1, 'Subrata', 'Kolkata', 50000.00, 'Male'),
(2, 'Subhasis', 'salt lake', 60000.00, 'Fema'),
(3, 'Avik', 'Chicago', 55000.00, 'Male'),
(4, 'Krishna', 'Kolkata', 52000.00, 'Fema'),
(5, 'Durga', 'Behala', 70000.00, 'Male'),
(6, 'Puja', 'Kerala', 48000.00, 'Fema'),
(7, 'Mousami', 'Delhi', 65000.00, 'Male'),
(8, 'Ankita', 'Krishnanagr', 58000.00, 'Fema'),
(9, 'Sumaya', 'Amtala', 51000.00, 'Male'),
(10, 'Sophia White', 'Denver', 59000.00, 'Fema');

alter function fn_getCustomerbyId(@gender char(4))
returns table
as 
return
(
	select cust_id, cust_name, city, salary, gender
	from mcc.customer_tbl
	where gender=@gender
) 
select * from fn_getCustomerbyId('Male')



create table mcc.dept_tbl(
							dept_id int primary key,
							dept_name varchar(30),
							cust_id int,
							foreign key (cust_id) references mcc.customer_tbl(cust_id)
							)

INSERT INTO mcc.dept_tbl (dept_id, dept_name, cust_id)
VALUES 
    (1, 'Sales', 1),
    (2, 'Marketing', 1),
    (3, 'Finance', 3),
    (4, 'Human Resources', 3),
    (5, 'Engineering', 3),
    (6, 'Customer Support', 2),
    (7, 'IT', 7);

create function fn_getDeptDetailsByCust(@cust_id int)
returns table
as
return
(
	select dept_id,dept_name,cust_id
	from mcc.dept_tbl
	where cust_id=@cust_id
)

select * from fn_getDeptDetailsByCust(1)

select   c.cust_name, c.city, c.salary, c.gender,d.dept_id,d.dept_name
from  mcc.customer_tbl as c
cross apply fn_getDeptDetailsByCust(c.cust_id) as d 


---create to scaler function
select * from mcc.customer_tbl

create function mcc.fn_addtwonumber(
@x int,
@y int
)
returns int
as
begin
		return @x + @y ;
end;

select mcc.fn_addtwonumber(5,5) 'Total value';


create function mcc.fn_getsalary(
	@salary dec(10,2)
)
returns int
as
begin
		return @salary * 5 ;
end;

select cust_name,mcc.fn_getsalary(salary) 'Total value'
from mcc.customer_tbl;

declare @i int =0,@j int=65,@s varchar(100)=''
while @i<10
begin 
	while @j<=(65+@i)
	begin
		set @s+=char(@j)
		set @j+=1
	end
	print @s
	set @s=''
	set @j=65
	set @i+=1
end
-------------------------------------------------------------------	
--02/02/2024 pivot lecture
use studentDB

CREATE TABLE Customers
(
CustomerName VARCHAR(50),
ProductName VARCHAR(50),
Amount INT,
Laptop_date date
)INSERT INTO Customers VALUES('James', 'Laptop', 30000,'2023/02/03')
INSERT INTO Customers VALUES('James', 'Desktop', 25000,'2023/09/03')
INSERT INTO Customers VALUES('David', 'Laptop', 25000,'2022/02/03')
INSERT INTO Customers VALUES('Smith', 'Desktop', 30000,'2024/02/03')
INSERT INTO Customers VALUES('Pam', 'Laptop', 45000,'2023/04/03')
INSERT INTO Customers VALUES('Pam', 'Laptop', 30000,'2023/06/06')
INSERT INTO Customers VALUES('John', 'Desktop', 30000,'2023/07/06')
INSERT INTO Customers VALUES('John', 'Desktop', 30000,'2023/04/04')
INSERT INTO Customers VALUES('John', 'Laptop', 30000,'2023/08/03')INSERT INTO Customers VALUES('John', 'Mobile', 30000,'2023/08/03')INSERT INTO Customers VALUES('John', 'Mobile', 30000,'2023/08/03')select * from Customersselect customerName,		Laptop,		Desktop,		Mobilefrom (select customerName,		productname,		amount	from		Customers)as piviotdatapivot( sum(amount) for productname	in (laptop,desktop,mobile)) as privottable-----------------------------------------------------------------------use BikeStoresSELECT
	category_name,
	COUNT(product_id) product_count
FROM
	production.products p
	INNER JOIN production.categories c
	ON c.category_id = p.category_id
GROUP BY category_name;select [Children Bicycles],		[Comfort Bicycles],		[Cruisers Bicycles],		[Cyclocross Bicycles],		[Electric Bikes],		[Mountain Bikes],		[Road Bikes]from(	select c.category_name,p.product_id	from production.products as p	join production.categories as c	on c.category_id=p.category_id) as pivotdatapivot( count(product_id) for category_name	in ([Children Bicycles],		[Comfort Bicycles],		[Cruisers Bicycles],		[Cyclocross Bicycles],		[Electric Bikes],		[Mountain Bikes],		[Road Bikes]))as pivottable-------------------------------------------------------------------------------------------------------declare @columnnames nvarchar(max)='';select @columnnames +=QUOTENAME(category_name)+','from production.categoriesset @columnnames=left(@columnnames,len(@columnnames)-1);create function hr.fn_xyz()returns nvarchar(max)asbegindeclare @columnnames nvarchar(max)='';select @columnnames +=QUOTENAME(category_name)+','from production.categoriesset @columnnames=left(@columnnames,len(@columnnames)-1)return @columnnamesendselect  hr.fn_xyz() 	select @columnnamesfrom(	select c.category_name,p.product_id	from production.products as p	join production.categories as c	on c.category_id=p.category_id) as pivotdatapivot( count(product_id) for category_name	in (@columnnames))as pivottable-----------------------------------------------------------------unpivotCreate Table ProductSales
(
	AgentName VARCHAR(50),
	India int,
	US int,
	UK int,
	phone_number char(10)
)INSERT INTO ProductSales VALUES ('Smith', 9160, 5220, 3360,'7098375')
INSERT INTO ProductSales VALUES ('David', 9770, 5440, 8800,'8764356')
INSERT INTO ProductSales VALUES ('James', 9870, 5480, 8900,'6738290')INSERT INTO ProductSales VALUES ('David', 8759, 8873, 8800,'8764356')
INSERT INTO ProductSales VALUES ('James', 9889, 5445, 8900,'6738290')select * from ProductSalesselect agentname,		country,		salesamount,		phone_numberfrom ( select agentname,india,us,uk,phone_number		from ProductSales		) as actualdataunpivot(	salesamount for country	in(india,us,uk))as unpvtdata--------------------------------------------------------------------------------WAQ to display total sales amount for each employee in wach product type from each month--table description- emp_id,emp_name,product_type,sales_amount,sales_dateuse studentDBcreate schema [pio];drop table [pio].[employee_tbl]create table [pio].[employee_tbl](									[emp_id] int,									[emp_name] varchar(30),									[pro_type] varchar(40),									[sales_amount] dec(10,2),									[sales_date] date									)insert into [pio].[employee_tbl] ([emp_id], [emp_name], [pro_type], [sales_amount], [sales_date])values
    (1, 'Subrata', 'Electronic', 1000.50, '2024-01-01'),
    (2, 'Rahul', 'sports', 750.25, '2024-03-02'),
    (1, 'Subrata', 'Electronic', 1200.75, '2024-01-03'),
    (4, 'Krishna', 'The Think Tank', 900.30, '2024-02-04'),
    (5, 'Swapnasish', 'clothing', 1100.60, '2024-03-05'),
    (6, 'pupai', 'Hi-Tech Haven', 850.45, '2024-01-06'),
    (7, 'sayan', 'Glamour', 950.20, '2023-01-07'),
    (8, 'Pranav', 'Hi-Tech Haven', 1150.70, '2022-01-08'),
    (9, 'Rahul', 'Makeup Masters', 800.35, '2024-02-09'),
    (10, 'Pyush', 'Cosmetic Cosmetic', 1050.40, '2024-01-10');


select * from pio.employee_tbl

select	*
from (select emp_id,emp_name,pro_type,sales_amount,format(sales_date,'MMMM') as m
		from pio.employee_tbl
		) as pivotdata
pivot(
	sum(sales_amount) for m
	in(january,february,march)
	)as pivottable
-----------------------------------------------------------------
create table [pio].[employee_tbl_2](									[emp_id] int primary key,									[emp_name] varchar(30),									[pro_type] varchar(40),									[sales_amount] dec(10,2),									[sales_date] varchar(10)									)insert into [pio].[employee_tbl_2] ([emp_id], [emp_name], [pro_type], [sales_amount], [sales_date])values
    (1, 'Subrata', 'Electornic', 1000.50, 'january'),
    (2, 'Rahul', 'sports', 750.25, 'march'),
    (3, 'Sumyana', 'Electronic', 1200.75, 'january'),
    (4, 'Krishna', 'The Think Tank', 900.30, 'february'),
    (5, 'Swapnasish', 'clothing', 1100.60, 'january'),
    (6, 'pupai', 'Hi-Tech Haven', 850.45, 'march'),
    (7, 'sayan', 'Glamour', 950.20, 'february'),
    (8, 'Pranav', 'Hi-Tech Haven', 1150.70, 'march'),
    (9, 'Rahul', 'Makeup Masters', 800.35, 'february'),
    (10, 'Pyush', 'Cosmetic Cosmetic', 1050.40, 'january');


select * from pio.employee_tbl_2

select	emp_name,
		january,
		february,
		march
from (select emp_id,emp_name,pro_type,sales_amount,sales_date 
		from pio.employee_tbl_2
		) as pivotdata
pivot(
	sum(sales_amount) for sales_date
	in(january,february,march)
	)as pivottable

-----------------------------------------------------------------------------------
--WAQ to display total quantity of products ordered for each product category over quantitys 
--table like- order_id, category, producttype,order_date
create table [pio].[order_tbl](
								[order_id] int,
								[category_type] varchar(30),
								[quantity] int,
								[order_date] date
								)
drop table [pio].[order_tbl]

INSERT INTO [pio].[order_tbl] ([order_id], [category_type], [quantity], [order_date])
VALUES
    (101, 'Electronics', 50, '2024-01-01'),
    (102, 'Toys', 30, '2024-03-02'),
    (101, 'Electronics', 20, '2024-01-03'),
    (104, 'Furniture', 40, '2024-09-04'),
    (102, 'Toys', 25, '2024-12-05');

select * from pio.order_tbl

select	*
from 
	(
		select order_id,category_type,quantity,concat('Q',datepart(QUARTER,[order_date]),'-',YEAR([order_date])) as odr_date
		from pio.order_tbl
	 ) as pivotdata
pivot
(
	COUNT(quantity) for odr_date in ([Q1-2024],[Q2-2024],[Q3-2024],[Q4-2024])
)as pivottable

------------------------------------------------------------------------------------------
--o6/02/2024
-- if else  and try catch
 
declare @n int =5
declare @temp int
begin try
	set @temp=@n/0
end try
begin catch
	
end catch

drop proc spdivide

CREATE PROC spdivide(
@a decimal,
@b decimal,
@c decimal output
) AS
BEGIN
BEGIN TRY
	--declare @message varchar(40)='Division'
	SET @c = @a / @b;
	--print concat(@message,@c)
END TRY
BEGIN CATCH
SELECT
	ERROR_NUMBER() AS ErrorNumber,	
	ERROR_SEVERITY() AS ErrorSeverity,
	ERROR_STATE() AS ErrorState,
	ERROR_PROCEDURE() AS ErrorProcedure,
	ERROR_LINE() AS ErrorLine,
	ERROR_MESSAGE() AS ErrorMessage;
END CATCH
END; 

declare @a decimal=10,@b decimal =3,@c decimal
exec spdivide @a,@b,@c output
print concat('Div=', @c)

----suppose i wnat to show the message inside the spdivide


use studentDB

CREATE TABLE sales.persons (
							person_id INT PRIMARY KEY IDENTITY, 
							first_name NVARCHAR(100) NOT NULL, 
							last_nam NVARCHAR(100) NOT NULL							);INSERT INTO sales.persons (first_name, last_nam) VALUES 
('John', 'Doe'),
('Jane', 'Smith'),
('Michael', 'Johnson'),
('Emily', 'Brown'),
('Christopher', 'Davis');CREATE TABLE sales.deals(
						deal_id INT PRIMARY KEY IDENTITY, 
						person_id INT NOT NULL, 
						deal_note NVARCHAR(100), 						FOREIGN KEY(person_id) REFERENCES sales.persons( person_id)						);INSERT INTO sales.deals (person_id, deal_note) VALUES 
(1, 'Deal for john doe'),
(2, 'Deal Jane'),
(3, 'Michael'),
(4, 'Deal for Emily');select * from sales.personsselect * from sales.dealsdrop proc sp_delect_persondrop proc sp_reportcreate proc sp_reportas	select ERROR_NUMBER() as errorNumber,		   ERROR_LINE() as errorLine,		   ERROR_MESSAGE() as errorMessage,		   ERROR_SEVERITY() as errorServerity,		   ERROR_PROCEDURE() as errorProcedure,		   ERROR_STATE() as errorStatealter proc sp_delect_person(@person_id int,@message varchar(40)out)asbegin	begin try		begin transaction 				delete from sales.persons where person_id=@person_id				set @message='Transaction successfull'				commit transaction				end try				begin catch							exec sp_report;							if(XACT_STATE())=-1							begin								print N'The transactions is an uncommitable state.' + 'Rollback the transaction'								commit transaction								set @message='Transaction fail for uncommitable state'							end							if(XACT_STATE())=1							begin								print N'The transactions is a commitable state.' + 'commiting transaction'								rollback transaction								set @message='Transaction fail'							end				end catch			enddeclare @message varchar(100)exec sp_delect_person 2,@message outprint @messagedeclare 		@errorMessage nvarchar(100),		@errorSeverity int,		@errorState int		begin try				raiserror('whoops an error ocoure',17,2);		end try		begin catch			select 				@errorMessage=error_message(),				@errorSeverity=error_severity(),				@errorState=error_state();				raiserror(@errorMessage,@errorSeverity,@errorState);		end catch--Transactioncreate table Bank_account_tbl(							acc_no int primary key,							balance money							)--insert initial datainsert into Bank_account_tbl(acc_no,balance) values(1,500),(2,600),(3,700)--read uncommited data--Transaction t1: Fund transfer from account A to account Bbegin transaction--deduct 100 from account Aupdate Bank_account_tbl set balance=balance-100where acc_no=1;--simulate a delay or some processingwaitfor delay '00:00:05';    --simulating some processsing time--transaction T2: Quary balance of account B with read uncommitedset transaction isolation level read uncommitted--read the balance of account B ( may read uncommitted data)select balancefrom Bank_account_tblwhere acc_no=1--commit or rollback transction T1rollback--read uncommited data--Transaction t1: Fund transfer from account A to account Bbegin transaction--deduct 100 from account Aupdate Bank_account_tbl set balance=balance-100where acc_no=1;--simulate a delay or some processingwaitfor delay '00:00:05';    --simulating some processsing time--transaction T2: Quary balance of account B with read uncommitedset transaction isolation level read uncommitted--read the balance of account B ( may read uncommitted data)update Bank_account_tblset balance=balance+100where acc_no=2--commit or rollback transction T1commitselect * from Bank_account_tbl--comitted--read uncommited data--Transaction t1: Fund transfer from account A to account Bbegin transaction--deduct 100 from account Aupdate Bank_account_tbl set balance=balance-100where acc_no=2;--simulate a delay or some processingwaitfor delay '00:00:05';    --simulating some processsing time--transaction T2: Quary balance of account B with read uncommitedset transaction isolation level read committedselect * from Bank_account_tblupdate Bank_account_tblset balance=balance+100where acc_no=1--read the balance of account B ( may read uncommitted data)--commit or rollback transction T1commitselect * from Bank_account_tbl