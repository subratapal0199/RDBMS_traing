--subrata pal

use studentDB
--create table department
create table [HR].[department](
								[id] int identity(101,1) constraint [dept_tbl_pk]  primary key,
								[depart_name] varchar(30) not null,
								[location] varchar(50),
								);

exec sp_help '[HR].[department]'

create table [HR].[Employee](
								[emp_id] int identity(201,1) constraint [emp_tbl_pk] primary key,
								[emp_name] varchar(30) not null,
								[doj] date,
								[jobrole] varchar(20),
								[salary] money,
								[dept_id] int not null,
								constraint [emp_tbl_fk] foreign key([dept_id]) references [HR].[department]([id])
								);

exec sp_help '[HR].[Employee]'

--question 2
create table [hr].[source_tbl1](
							id int not null primary key,
							name varchar(30) not null
							)
create table [hr].[target_tbl1](
							id int not null primary key,
							name varchar(30) not null
							)
insert into 
			[hr].[target_tbl1]([id],[name])
		values
			(1,'yksi'),(2,'kaksi'),(4,'nelja'),(5,'kussi')
insert into 
			[hr].[source_tbl1]([id],[name])
		values
			(1,'one'),(2,'two'),(4,'three'),(5,'five')

merge [hr].[target_tbl1]  as t using [hr].[source_tbl1] as s on t.[id]=s.[id]
	when not matched by target 
	then
		insert ([id],[name]) values (s.[id],s.[name])
	when matched 
	then
		update set name=s.[name]
	when not matched by source
	then
		delete;

select * from [hr].[source_tbl1]
select * from [hr].[target_tbl1]

--3.write a quary to show update and delete using join
select * from [HR].[Employee]
select * from [HR].[department]

insert into [HR].[department]([depart_name],[location]) values('technical','kolkata')
insert into [HR].[department]([depart_name],[location]) values('manager','salt lake')



insert into [HR].[Employee] ([emp_name],[doj],[jobrole],[salary],[dept_id])
values('sub','2023/11/12','Traniee',46383.54,101)
insert into [HR].[Employee] ([emp_name],[doj],[jobrole],[salary],[dept_id]) 
values('avik','2023/11/12','software',46383.54,102)


delete d
from [HR].[department] as d
left join [HR].[Employee] as e on [d].[id]=[e].[emp_id]
where [d].[id]=102

update	[HR].[Employee] set [e].[dep_id]=[d].[id]
from [HR].[Employee] as e
inner join [HR].[department] as d on e.dept_id=d.id
