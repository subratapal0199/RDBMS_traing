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
    email varchar(50) not null unique
);
insert into Users (user_name, [password], email) VALUES
('subratapal0199', 'Sub@123', 'subrata@pal.com'),
('Pranav123', 'Pranav@123', 'Pranav@123.com')

select * from Users




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

create proc usp_RegisterUser(
							 @user_name varchar(50),
							 @password varchar(50),
							 @email varchar(50)
							 )
as 
begin
	insert into Users(user_name, [password], email)values(@user_name,@password,@email)
end

exec usp_RegisterUser 'Swap123','123','Swp@gamail.com'