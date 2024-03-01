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
		set @mess='OPPs! record not exits record'
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



