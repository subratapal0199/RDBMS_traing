--													Subrata Pal-S199
--												Assignment-IV 19/02/2024

create database Assignment_DB
use Assignment_DB
----------------------------------------------------------------------------------------------------------------------------
--1.How to display the students from a student table having same name and father's name from below table:   

create table Student_tbl(
							[std_id] int primary key,
							[std_name] varchar(100),
							[std_father] varchar(100)
						)

insert into [Student_tbl] values(1,'Rajiv Kumar','Arvind Kumar'),(2,'Asish Roy','Ashim Roy'),(3,'Bipin Gupta','Rajiv Gupta'),
(4,'Rajiv Kumar','Arvind Kumar'),(5,'Sourav Patra','Asish Patra'),(6,'Asish Roy','Ashim Roy')

select * from Student_tbl

select std_name, std_father
from Student_tbl
group by std_name, std_father
having count(*) > 1

----------------------------------------------------------------------------------------------------------------
--2.How to display current date time in below format :
--Oct 23 2022 21:38 PM  

select format(getdate(), 'MMM dd yyyy hh:mm tt') AS CurrentDateTime

---------------------------------------------------------------------------------------------------------------------
--3.Write a query to finding all possible paths between two nodes in a graph using recursive CTE.  
create table node_tbl(
					node_id int primary key,
					node_Name varchar(100)
					)

insert into node_tbl(node_id,node_Name)values(1, 'A'),(2, 'B'),(3, 'C'),(4, 'D')

create table graph_tbl (
						start_Node int,
						end_Node int,
						primary key (start_Node, end_Node),
						foreign key (start_Node) references node_tbl(node_id),
						foreign key (end_Node) references node_tbl(node_id)
						)

insert into graph_tbl(start_Node, end_Node) values(1, 2),(1, 3),(2, 3),(2, 4),(3, 4)

select * FROM node_tbl
SELECT * FROM graph_tbl

with cte_Paths as (
    select Start_Node, End_Node, cast(node_id AS varchar(max)) AS Path
    from graph_tbl
    inner join  node_tbl 
	on graph_tbl.Start_Node = node_tbl.Node_id
    where start_Node=1

    union all

    select g.Start_Node,  g.End_Node, rp.Path + ' -> ' + cast(n.node_id as varchar(max))
    from cte_Paths  as rp
    join graph_tbl as g 
	on rp.End_Node = g.Start_Node
    join node_tbl as n 
	on g.End_Node = n.Node_id
)
select  start_Node, end_Node,  Path
from cte_Paths

-----------------------------------------------------------------------------------------------------
--4.Write a query to generate a Bill of Materials for mobile
create table producttbl (
						p_id int primary key,
						p_name varchar(60)
						)
						
create table component_product (
								cp_id int foreign key references producttbl(p_id),
								[p_id] int foreign key references producttbl(p_id),
								quantity int,
								primary key ([cp_id],[p_id])
								)

insert into producttbl(p_id, p_name)values(1, 'Laptop'),(2, 'Mobile'),(3, 'Desktop'),(4, 'Processor'),(5, 'Camera')

insert into component_product (cp_id, p_id, quantity)values(1, 2, 1), (1, 3, 1), (1, 4, 1), (1, 5, 2)


select * from producttbl
select * from component_product 

with cte_report as (
    select p.p_name,cp.cp_id,cp.p_id,cp.quantity,1 as Level
    from component_product as cp
	inner join producttbl as p on p.p_id=cp.p_id
    where p.p_name = 'Mobile'

    union all
    
    select p.p_name,cp.cp_id,cp.p_id,cp.quantity * ct.quantity as quantity,ct.Level + 1 as Level
    from cte_report as ct
    inner join component_product as cp ON ct.p_id = cp.cp_id
	inner join producttbl as p on p.p_id=cp.p_id
	

)
select  cte.Level,p.p_id,p.p_name,cte.quantity
from cte_report as cte
JOIN producttbl p on cte.p_id = p.p_id
ORDER BY cte.Level

--------------------------------------------------------------------------------------------------------
--5.Write a trigger to ensure that any modifications to the Employees table are recorded in the AuditLog table providing 
--an audit trail for tracking changes over time.   

create table employee_tbl(
							emp_id int primary key,
							emp_name varchar(100),
							salary money
							)
insert into employee_tbl (emp_id, emp_name,salary) values(1, 'Subrata',50000.00),(2, 'Sreya',55000.00),
(3, 'Poltu',60000.00),(4, 'Susmita',52000.00),(5, 'Amit',70000.00)


create table AuditLog(
						auidt_id int identity primary key,
						auidtdata varchar(max),
						auidtDate datetime
					)

create trigger tr_Emp_log_history on employee_tbl
for insert,delete,update
as 
	begin
			declare @id int
			declare @name varchar(100)
			declare @salary money
			declare @auidtData varchar(max)
			if exists (select * from inserted)
				begin
					select @id = emp_id, @name = emp_name, @salary = salary from inserted
					set @auidtData='Hey! New Employee added with id= '+CAST(@id as varchar) + ' and' + ' name= '+@name
					insert into AuditLog values(@auidtData,GETDATE())
				end

				if exists (select * from deleted)
					begin
						select @id = emp_id, @name = emp_name, @salary = salary from deleted
						set @auidtData='OPPs! An Employee deleted with id= '+CAST(@id as varchar) + ' and' + ' name= '+@name
						insert into AuditLog values(@auidtData,GETDATE())
					end
				if exists(select * from inserted as i inner join deleted as d on i.emp_id=d.emp_id )
					begin
						select @id = i.emp_id, @name = i.emp_name, @salary = i.salary 
						from deleted as d
						join inserted as i
						on d.emp_id=i.emp_id

						 set @auidtData = 'Employee details updated: id= ' + CAST(@id as varchar) + ', name= ' + @name + ', Salary= ' + CAST(@salary AS VARCHAR)
						 insert into AuditLog(auidtData, auidtdate) values (@auidtData ,getdate())


					end
	end

select * from employee_tbl
select * from AuditLog

insert into employee_tbl values (6,'Subhasis',48000)
delete from employee_tbl where emp_id=6
update employee_tbl set emp_name='Pranab' where emp_id=5

-------------------------------------------------------------------------------------------------
--6.Create a stored procedure that uses a cursor to iterate over the transactions table 
--(transaction id,product id,transaction type,quantity,transaction date)and 
--update the stock quantity in the products table (product id,product name,stock quantity)				6



create table product_tbl(
							product_id int identity primary key,
							product_name varchar(max),
							stock_quantity int
						)

create table transaction_tbl(
							transaction_id int identity primary key,
							product_id int foreign key references  product_tbl(product_id),
							transaction_type varchar(20),
							quantity int,
							transaction_date date
							)
drop table transaction_tbl
drop table product_tbl

insert into product_tbl (product_name, stock_quantity) values('Face Wash', 100),('Creame', 200),('Powder', 150),
('Oil', 300)

insert into transaction_tbl (product_id, transaction_type, quantity, transaction_date) values
(1, 'In', 50, '2023-01-01'),
(2, 'Out', 30, '2023-01-02'),
(3, 'In', 80, '2023-01-03'),
(4, 'Out', 100, '2023-01-04')

select * from product_tbl
select * from transaction_tbl


alter proc usp_transDetails
as
begin
	declare @trans_id int
	declare @product_id int
	declare @transaction_type varchar(10)
	declare @quantity int 
	declare @stock_quantity int

	declare cr_for_transaction cursor 
	for select transaction_id,transaction_tbl.product_id,transaction_type,quantity,product_tbl.stock_quantity
	from transaction_tbl
	join product_tbl on product_tbl.product_id=transaction_tbl.product_id

	open cr_for_transaction 

	fetch next from cr_for_transaction into @trans_id,@product_id,@transaction_type,@quantity,@stock_quantity
	while @@FETCH_STATUS=0
		begin
		begin transaction
			if @transaction_type = 'In'
				begin 
					update product_tbl set stock_quantity = @stock_quantity + @quantity where product_id = @product_id
					commit tran
				end
			else if @transaction_type = 'Out' and @stock_quantity>=@quantity
				begin
					update product_tbl set stock_quantity = stock_quantity - @quantity where product_id = @product_id
					commit tran
				end
			else if @transaction_type = 'Out' and @stock_quantity<@quantity
				begin
					raiserror ('Stock not availabe',16,1)
					rollback 
				end
		fetch next from cr_for_transaction into @trans_id,@product_id,@transaction_type,@quantity,@stock_quantity
	end
	close cr_for_transaction 
	deallocate cr_for_transaction 
end


exec usp_transDetails


select * from product_tbl
select * from transaction_tbl
-----------------------------------------------------------------------------------
--7.Create stored procedure that accept table variable as parameter using the BusBooking. 
create type ut_booking_type as table(
									booking_id int primary key,
									bus_name varchar(100),
									pass_name varchar(100),
									booking_date datetime
									)
create table Bus_booking(
							booking_id int primary key,
							bus_name varchar(100),
							pass_name varchar(100),
							booking_date datetime
							)
create proc usp_ut_BusBooking(@booking_details ut_booking_type readonly)
as
	begin
		insert into Bus_booking(booking_id,bus_name,pass_name,booking_date)
		select * from @booking_details
	end

declare @busBookingtable ut_booking_type
insert into @busBookingtable 
select 2,'M14','Pranab','2024-02-20 09:30:00'
exec usp_ut_BusBooking @busBookingtable

select * from Bus_booking
-----------------------------------------------------------------------------------------------













