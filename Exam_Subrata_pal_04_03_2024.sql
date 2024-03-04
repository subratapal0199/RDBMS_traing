--===============================================================
--			Author:- Subrata Pal
--			Date :- 04/03/2024
--			Description: create a employee table and Insert the data using store procedure
--================================================================

create table employee_tbl(
							emp_id int primary key,
							emp_name varchar(100),
							salary int
						)

select * from employee_tbl

create proc usp_putEmployee(
							@emp_id int,
							@emp_name varchar(100),
							@salary int,
							@message varchar(100) out 
							)
As
begin
	begin transaction
		if not exists (select emp_id from employee_tbl where emp_id=@emp_id)
		begin
			 insert into employee_tbl (emp_id,emp_name,salary)values(@emp_id,@emp_name,@salary)
				set @message='Employee inserted Successfully with ID: '+CAST(@emp_id as varchar)
				commit tran
		end
		else
		begin
			rollback tran
			set @message='Opps!! Already employee exists with ID: '+CAST(@emp_id as varchar)+'. Try with another ID'
		end	
end

--declare @mess varchar(100)
--exec usp_putEmployee 1,'Subrata Pal',30000,@mess out
--print @mess

--===============================================================
--			Author:- Subrata Pal
--			Date :- 04/03/2024
--			Description: Update the employee record
--================================================================
alter proc usp_updateEmp(
							@emp_id int,
							@emp_name varchar(100)=null,
							@salary int=null,
							@mess varchar(100) out
						)
as
begin
	begin transaction 
		if not exists(select emp_id from employee_tbl where emp_id=@emp_id)
		begin
			rollback tran
			set @mess='Opps!! Employee ID: '+cast(@emp_id as varchar)+' not exists which you are trying to update the data. please try with another ID.'
		end
		else 
		begin
			if  (@salary is not null) and (@emp_name is not null)
			begin
				update employee_tbl set emp_name=@emp_name,salary=@salary where emp_id=@emp_id
				set @mess='Employee Detalis(Emp_name,salary) updated whose ID: '+CAST(@emp_id as varchar)
				commit tran
			end
			else if @salary is not null
			begin
				update employee_tbl set salary=@salary where emp_id=@emp_id
				set @mess='Salary updated for employee whose ID: '+CAST(@emp_id as varchar)
				commit tran
			end
			else if @emp_name is not null
			begin
				update employee_tbl set emp_name=@emp_name where emp_id=@emp_id
				set @mess='Employee Name updated whose ID: '+CAST(@emp_id as varchar)
				commit tran
			end
			
		end 
end




declare @message varchar(100)
EXEC usp_updateEmp @emp_id = 1, @emp_name = 'Arnab', @mess =@message  OUT
print @message;

select * from employee_tbl

-------------------------------------------------------------------------------------------------------------
--===============================================================
--			Author:- Subrata Pal
--			Date :- 04/03/2024
--			Description: delete the employee record using id
--================================================================
create proc  usp_deleteEmployee(
								@emp_id int,
								@message varchar(200) out
								)
as 
begin
		begin transaction 
		if exists (select emp_id from employee_tbl where emp_id=@emp_id)
		begin 
			delete from employee_tbl where emp_id=@emp_id
			set @message='Employee deleted from employee table whose ID: '+CAST(@emp_id as varchar)
			commit tran
		end
		else 
		begin
			rollback tran
			set @message='Employee ID: '+CAST(@emp_id as varchar)+' does not exist whose ID you want to delete. If you want to delete an eployee please try with another ID'
		end
end

declare @mess varchar(500)
exec usp_deleteEmployee 2,@mess out
print @mess
-----------------------------------------------------------------------------------------------------------------
--===============================================================
--			Author:- Subrata Pal
--			Date :- 04/03/2024
--			Description: Get the employee record and get Employee record with specific id
--================================================================
alter proc usp_getEmployee(
							@emp_id int=null,
							@message varchar(500) out 
							)
as
begin
		if exists(select emp_id from employee_tbl where emp_id=@emp_id)
		begin
			select emp_id,emp_name,salary from employee_tbl 
			where emp_id=@emp_id
			set @message='Employee Detalis for: '+CAST(@emp_id as varchar)
		end
		else
		begin
			set @message='Employee ID: '+CAST(@emp_id as varchar)+' does not exists'
		end
		if @emp_id is null
		begin
			select emp_id,emp_name,salary from employee_tbl 
			set @message='Here is your result.'
		end		
end

declare @mess varchar(500)
exec usp_getEmployee  @message=@mess out 
print @mess