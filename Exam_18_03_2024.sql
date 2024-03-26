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
drop table Employee

insert into Employee values('Subrata',20000,'Admin')
select * from Employee where Emp_name like 'x%'







