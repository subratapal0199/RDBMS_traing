create table student(
					 std_id int primary key identity,
					 std_name varchar(50) not null,
					 age tinyint,
					 gender char(10) not null,
					 )
insert into student(std_name,age,gender)values('Subrata',25,'Male')
insert into student(std_name,age,gender)values('Rahul',24,'Male')
select * from student

create proc usp_getStudent(
							@stdID int= null,
							@stdName varchar(50)=null,
							@age tinyint=null,
							@gender char(10)=null
						)
as
begin
		if exists(select std_id from student where std_id=@stdID)
		begin
			select std_id,std_name,age,gender from student where std_id=@stdID
		end
		if @stdID is null
		begin
			select std_id,std_name,age,gender from student
		end
end

exec usp_getStudent 1
------------------------------------------------------------------------------
alter proc usp_InsertStd(
							@stdName varchar(50),
							@age tinyint,
							@gender char(10)
						)
as 
begin
		
		insert into student(std_name,age,gender) values(@stdName,@age,@gender)
		
end

select * from student
delete from student where std_id=3

exec usp_InsertStd 'Rahul',24,'Male'

truncate table student
-----------------------------------------------------------------------------------------------
create proc usp_DeleteStd(
						@std_id int
					)
as 
begin
	delete from student where std_id=@std_id
end

exec usp_DeleteStd 3
-------------------------------------------------------------------
create proc usp_updateStd(
							@std_id int,
							@stdName varchar(50),
							@age tinyint,
							@gender char(10)
						)
as
begin
		update student set std_name=@stdName,age=@age,gender=@gender
		where std_id=@std_id
end

exec usp_updateStd 
---------------------------------------------------------------------
create table Users (
    user_id int primary key identity,
    user_name varchar(50) not null unique,
    [password] varchar(50) not null unique, 
    email varchar(50) not null unique,
	
);



insert into Users (user_name, [password], email) VALUES
('subratapal0199', 'Sub@123', 'subrata@pal.com'),
('Pranav123', 'Pranav@123', 'Pranav@123.com')

select * from Users

create table userRole(
						id int primary key identity,
						userID int foreign key references Users(user_id),
						role varchar(50) not null
						)


insert into userRole(userID,role) values(1,'Admin'),(1,'User'),(2,'Manager'),(3,'Admin'),(4,'User')

select * from Users
select * from userRole

alter proc usp_getUserRole(
							@username varchar(50)
							)
as
begin
		select [role] from userRole
		join Users on user_id=userID
		where user_name=@username
end

exec usp_getUserRole 'subratapal0199'



create proc usp_login(
						@user_name varchar(50),
						@password varchar(50)
					)
as
begin
		select user_name,[password] from dbo.Users where user_name=@user_name and password=@password
end

exec usp_login 'subratapal0199','Sub@123'
----------------------------------------------------------

alter proc usp_RegisterUser(
							 @user_name varchar(50),
							 @password varchar(50),
							 @email varchar(50)
							 )
as 
begin
	insert into Users(user_name, [password], email)values(@user_name,@password,@email)
end
------------------------------------------------------------------------------------------
create proc usp_StudentCRUD(
						@stdID int= null,
						@stdName varchar(50)=null,
						@age tinyint=null,
						@gender char(10)=null,
						@status varchar(50)
						)
as 
begin
		if @status='GET'
		begin
			if exists(select std_id from student where std_id=@stdID)
			begin
				select std_id,std_name,age,gender from student where std_id=@stdID
			end
			if @stdID is null
			begin
				select std_id,std_name,age,gender from student
			end
		end
		if @status='INSERT'
		begin
			IF @stdName IS NOT NULL AND @age IS NOT NULL AND @gender IS NOT NULL
			begin
				insert into student(std_name,age,gender) values(@stdName,@age,@gender)
			end
			else
			begin
				RAISERROR('Cannot insert NULL values.', 16, 1)
				return;
			end
		end
		if @status='DELETE'
		begin
			IF @stdID IS NOT NULL
			begin
				delete from student where std_id=@stdID
			end
			else
			begin
				RAISERROR('stdID cannot be NULL for DELETE operation.', 16, 1)
				return;
			end
		end
		if @status='UPDATE'
		begin
			if @stdID is not null
			begin
				update student set std_name=@stdName,age=@age,gender=@gender 
				where std_id=@stdID
			end
			else
			begin
				RAISERROR('stdID cannot be NULL for UPDATE operation.', 16, 1)
				return;
			end
		end

end

select * from student

exec usp_StudentCRUD @status='DELETE',@stdID=1011
--------------------------------------------------------------------------
create table Employee(
					Emp_id int identity primary key,
					Emp_name nvarchar(50) not null,
					Salary int,
					emp_group varchar(20)
					)
select * from Employee

insert into Employee values('Subrata',20000,'Admin')
select * from Employee where Emp_name like 'x%'
select Emp_id,Emp_name,Salary,emp_group from Employee where Emp_id=1
insert into Employee(Emp_id,Emp_name,Salary,emp_group)values();
update Employee set Emp_name='Pallabi',Salary=5000,emp_group='Developer' where Emp_id=10
delete from Employee where Emp_id=11
--------------------------------------------------------------------------------
--cascading DropDownList
create table Country(
						Id int primary key,
						[Name] nvarchar(100)
					)
insert into Country values(1,'India'),(2,'USA'),(3,'Canada'),(4,'Bangadesh'),(5,'Pakistan')
select * from Country

select Id,Name from Country 


create table [State]
(
	[state_id] int primary key,
	[state_name] varchar(60),
	[cou_id] int foreign key references Country([Id])
)
INSERT INTO [State] ([state_id],[state_name], [cou_id])
VALUES 
    (1,'Delhi', 1), -- Indian state belongs to India (ID: 1)
	(2,'West Bengal',1),
	(3,'Maharastra',1),
    (4,'California', 2),-- USA state belongs to USA (ID: 2)
	(5,'New York',2),
	(6,'Maxico',2),
    (7,'Ontario', 3), -- Canada state belongs to Canada (ID: 3)
	(8,'British columbia',3),
    (9,'Dhaka', 4), -- Bangladesh state belongs to Bangladesh (ID: 4)
	(10,'Barisal',4),
    (11,'Karachi', 5); -- Pakistan belongs to Pakistan (ID: 5)
select * from [State]

select [state_name] from [State] where cou_id=1

create table City
(
	[city_id] int primary key,
	[city_name] varchar(60),
	[state_id] int foreign key references [State]([state_id])
)
INSERT INTO City ([city_id], [city_name], [state_id])
VALUES (1,'Lal kote',1),(2,'Siri',1),(3,'Jahanpanah',1),
		(4,'Kolkata',2),(5,'Mednipur',2),(6,'Bankura',2),
		(7,'Mumbai',3),(8,'Pune',3),(9,'Nagpur',3),
		(10,'Los Angels',4),(11,'San francisco',4),(12,'San diego',4),
		(13,'Albany',5),(14,'Mount vernon',5),(15,'Rochester',5),
		(16,'Leon',6),(17,'Pueble',6),(18,'Tijuann',6),
		(19,'Toronto',7),(20,'North Bay',7),(21,'Sarnia',7),
		(22,'Victoria',8),(23,'Prince George',8),(24,'Vernon',8),
		(25,'Gazipur',9),(26,'Rajbari',9),(27,'Faridpur',9),
		(28,'Hijla',10),(29,'Babiganj',10),(30,'Muladi',10),
		(31,'Malir',11),(32,'Sarddar Town',11),(33,'Koranji',11)

select city_name from City where state_id=1
---------------------------------------------------------------------------------------
use MCC_DB
create table [dbo].[tbl_file]
							(
								[file_id] int IDENTITY(1,1) primary key,  
								[file_name] nvarchar(max) NOT NULL,  
								[file_ext] nvarchar(max) NOT NULL,  
								[file_base6] nvarchar(max) NOT NULL, 
							)
--------------------------------------------------------------------------------
create proc [dbo].[sp_get_all_files]
as
begin
		select [file_id],[file_name],[file_ext]
		from [dbo].[tbl_file]
end
---------------------------------------------------------------------------------
create proc [dbo].[sp_get_file_details](@file_id int)									
as
begin
		select [file_id],[file_name],[file_ext],[file_base6]
		from [dbo].[tbl_file]
		where [file_id]=@file_id
end
-----------------------------------------------------------------------------------
create proc [dbo].[sp_insert_file](
									@file_name nvarchar(MAX),  
									@file_ext nvarchar(MAX),  
									@file_base64 nvarchar(MAX)
									)
as
begin
		insert into [dbo].[tbl_file]([file_name],[file_ext],[file_base6])values
		(@file_name,@file_ext,@file_base64)
end
-----------------------------------------------------------------------------------




