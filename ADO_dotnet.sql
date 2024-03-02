alter proc [hr].usp_getDevoler(@dev_id int,@mess varchar(100) out)
as
begin
	if exists(select dev_id from HR.developer_tbl where dev_id=@dev_id )
	begin
		select dev_id,dev_name,dev_salary,[location]
		from HR.developer_tbl where dev_id=@dev_id
			set @mess='OMG! Finaly we got the record'
	end
	else
		set @mess='OPPs! record not exits'
end

alter proc [hr].usp_insertDeveloper(
									@dev_id int,
									@dev_name varchar(100),
									@dev_salary int,
									@location varchar(100),
									@message varchar(100) out
									)
as 
	begin
		if not exists(select dev_id from HR.developer_tbl where dev_id=@dev_id)
			begin
				insert into [HR].developer_tbl(dev_id,dev_name,dev_salary,[location]) values
				(@dev_id,@dev_name,@dev_salary,@location);
					set @message='Congratulation!! Record inserted Successfully!'
			end
		else
			begin
				set @message='OPPs!! Record already present. Try with another id'
			end
	end


declare @mess varchar(100)
exec [hr].usp_insertDeveloper 4,'Pallabi',30000,'Kolkata',@mess out
print @mess
-----------------------------------------------------------------------------------------------------------------

create database ADO_Dot_net
use ADO_Dot_net

create table developer(
						dev_id int identity primary key,
						dev_name varchar(100),
						dev_salary int
						)

INSERT INTO developer (dev_name, dev_salary) VALUES ('Subrata', 50000);
INSERT INTO developer (dev_name, dev_salary) VALUES ('Rahul', 55000);
INSERT INTO developer (dev_name, dev_salary) VALUES ('Pranav', 60000);
INSERT INTO developer (dev_name, dev_salary) VALUES ('Susmita', 62000);
INSERT INTO developer (dev_name, dev_salary) VALUES ('Subhrajit', 58000);


alter proc usp_insertDeveloper(
									@dev_name varchar(100),
									@dev_salary int,
									@identity int out,
									@message varchar(100) out
									)
as 
	begin
			
		insert into developer(dev_name,dev_salary) values
		(@dev_name,@dev_salary);
		set @identity=SCOPE_IDENTITY()
		if @@ROWCOUNT>0
			set @message='Record inserted successfully having id: '+cast(@identity as varchar(100))
	end

declare @mess varchar(100),@id int
exec usp_insertDeveloper 'Pallabi',30000,@id out,@mess out
print @mess
print @id

select * from developer

---------------------------------------------------------------------------------------------------
alter proc [hr].[usp_CrudApplication](
									@dev_id int=null,
									@dev_name varchar(100)=null,
									@dev_salary int=null,
									@location varchar(100)=null,
									@message varchar(100) out
									)
as
	begin
		if not exists(select dev_id from HR.developer_tbl where dev_id=@dev_id)
		begin
			insert into [HR].[developer_tbl]([dev_id],[dev_name],[dev_salary],[location])values
			(@dev_id,@dev_name,@dev_salary,@location)
			if @@ROWCOUNT>0
				set @message='Record inserted Successfully'
			else
				set @message='Record not inserted'
			select dev_id,dev_name,dev_salary,[location]
			from HR.developer_tbl
		end
	end

alter proc [hr].[usp_CrudApplication](
									@dev_id int,
									@dev_name varchar(100),
									@message varchar(100) out
								)
as
begin
		
			select dev_id,dev_name,dev_salary,[location]
			from HR.developer_tbl
			where dev_id=@dev_id or dev_name=@dev_name
			if @@ROWCOUNT>0
				set @message='Here is your result'
			else
				set @message='No record found'
end



declare @mess varchar(100)
exec [hr].[usp_CrudApplication] 1,'Avik',@mess out 
print @mess






