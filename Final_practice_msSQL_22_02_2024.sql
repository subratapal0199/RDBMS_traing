create database Final_DB
use Final_DB
create schema mcc


create table [mcc].[student_tbl](
									[std_id] int primary key,
									[std_name] varchar(100) not null,
									[std_phone] char(10),
									unique([std_phone]),
									[city] varchar(100) default 'Kolkata',
									[email] varchar(100),
									unique([email]),
									[age] tinyint check ([age]>=18),
									[marks] int
									)

create table [mcc].[course_tbl](
									[course_id] int primary key,
									[course_name] varchar(100) not null,
								)



create table [mcc].[Enrollment_tbl](
										[enrollmanet_id] int primary key,
										[enrollment_date] datetime,
										[std_id] int foreign key references [mcc].[student_tbl]([std_id]),
										[course_id] int foreign  key references [mcc].[course_tbl]([course_id]),
										unique([std_id],[course_id])
									)


create table [mcc].[grade_tbale](
									[grade] char(2) primary key,
									[min_marks] int ,
									[max_marks] int
								)

create table [mcc].[department_tbl](
									[dept_id] int primary key,
									[dept_name] varchar(100) not null,
									[std_id] int foreign key references [mcc].[student_tbl]([std_id]),
									[course_id] int foreign  key references [mcc].[course_tbl]([course_id]),
									unique([std_id],[course_id])
								)

create table [mcc].[instructor_tbl](
									[instractor_id] int primary key,
									[instractor_name] varchar(100) not null,
									[dept_id] int foreign key references [mcc].[department_tbl]([dept_id]),
									[dept_head] int foreign key references [mcc].[instructor_tbl]([instractor_id])
									)



------------------------------------------------------------------------
create table [mcc].[target_tbl](
								[tar_id] int primary key,
								[tar_name] varchar(50),
								[amount] money
								)

create table [mcc].[source_tbl](
								[sour_id] int primary key,
								[sour_name] varchar(50),
								[amount] money
								)

insert into [mcc].[target_tbl] values (1,'Avik',76000),(2,'pranav',46000),(4,'Subrata',45000),(8,'Rahul',15000)
insert into [mcc].[source_tbl]  values (1,'Sumon',12000),(2,'Ankita',23000),(3,'Sreya',33000),(5,'Misti',98000)


select * from [mcc].[source_tbl]
select * from [mcc].[target_tbl]

merge [mcc].[target_tbl]  as t using [mcc].[source_tbl] as s on (t.[tar_id]=s.[sour_id])
when matched then
			update set t.[tar_name]=s.[sour_name], t.[amount]=s.[amount]
when not matched by target then
			insert (tar_id,tar_name,amount) values(s.[sour_id],[sour_name],[amount])
when not matched by source then
			delete;

select * from [mcc].[target_tbl]

select * from [mcc].[student_tbl]

--bulk insert
bulk insert [mcc].[student_tbl]
from 'E:\Subrata Pal\Student_CSV.csv'
with
(
	fieldterminator=',',
	rowterminator='\n',
	firstrow=2
)


create table [mcc].[identity_tbl](
									[id] int identity primary key,
									[name] varchar(30)
									)

insert into [mcc].[identity_tbl] values('poltu')

set identity_insert [mcc].[identity_tbl] on

insert into [mcc].[identity_tbl](id,name) values(2,'Subrata')

use BikeStores

with cte_Sales_details
as(
select o.order_id,oi.item_id,oi.quantity,o.order_date,ROW_NUMBER() over(partition by o.customer_id order by o.order_date) as rowNumber
from sales.orders as o
inner join sales.order_items as oi 
on o.order_id=oi.order_id
)select *  from cte_Sales_details 

with cte_Sales_details
as(
select o.order_id,oi.item_id,oi.quantity,o.order_date,ROW_NUMBER() over(partition by o.customer_id order by o.order_date) as rowNumber
from sales.orders as o
inner join sales.order_items as oi 
on o.order_id=oi.order_id
)select MAX(rowNumber) as mx_row from cte_Sales_details



create table [mcc].[depat_tbl](
								dept_id int primary key,
								dept_name varchar(100),
								)

create table [mcc].[Employee_tbl](
									emp_id int primary key,
									emp_name varchar(100),
									salary money,
									dept_id int foreign key references [mcc].[depat_tbl](dept_id)
									)

INSERT INTO [mcc].[depat_tbl] (dept_id, dept_name)
VALUES 
    (1, 'Engineering'),
    (2, 'Marketing'),
    (3, 'Finance'),
    (4, 'Human Resources'),
    (5, 'Operations'),
    (6, 'Sales'),
    (7, 'Research and Development'),
    (8, 'Customer Service')

INSERT INTO [mcc].[Employee_tbl] (emp_id, emp_name, salary, dept_id)
VALUES 
    (1, 'John Doe', 50000, 1),
    (2, 'Jane Smith', 60000, 1),
    (3, 'Michael Johnson', 55000, 2),
    (4, 'Emily Davis', 58000, 2),
    (5, 'Robert Brown', 62000, 3),
    (6, 'Emma Wilson', 54000, 3),
    (7, 'William Taylor', 57000, 4),
    (8, 'Olivia Martinez', 59000, 4)

alter function fn_getEmpbyDept(@dept_id int)
returns table 
as 
return
(
		select emp_id,emp_name,salary,dept_id
		from [mcc].[Employee_tbl]
		where dept_id=@dept_id
)

alter function fn_getEmpbyDept()
returns table 
as 
return
(
		select emp_id,emp_name,salary,dept_id
		from [mcc].[Employee_tbl]
)
select * from fn_getEmpbyDept()

select d.dept_id,d.dept_name,e.emp_id,e.emp_name,e.salary
from [mcc].[depat_tbl] as d
cross apply [dbo].fn_getEmpbyDept(d.dept_id) as e 


select d.dept_id,d.dept_name,e.emp_id,e.emp_name,e.salary
from [mcc].[depat_tbl] as d
outer apply [dbo].fn_getEmpbyDept(d.dept_id) as e 


select d.dept_id,d.dept_name,e.emp_id,e.emp_name,e.salary
from [mcc].[depat_tbl] as d
inner join [dbo].fn_getEmpbyDept(1) as e on d.dept_id=e.dept_id

select * from mcc.depat_tbl as d
inner join fn_getEmpbyDept() as e  on e.dept_id=d.dept_id


select salary 
from mcc.Employee_tbl
order by salary desc


---display 6th highest salary from employee table
select salary from 
(select salary,DENSE_RANK() over(order by salary desc)as densRank from mcc.Employee_tbl)  as rank_salary
where densRank=6

INSERT INTO [mcc].[student_tbl] ([std_id], [std_name], [std_phone], [city], [email], [age], [marks])
VALUES
    (4, 'Anjali Gupta', '6543210987', 'Kolkata', 'anjali@example.com', 21, 88),
    (5, 'Vikram Sharma', '5432109876', 'Bangalore', 'vikram@example.com', 20, 79),
    (6, 'Sneha Reddy', '4321098765', 'Chennai', 'sneha@example.com', 23, 92),
    (7, 'Rahul Verma', '3210987654', 'Hyderabad', 'rahul@example.com', 19, 83),
    (8, 'Kavita Nair', '2109876543', 'Pune', 'kavita@example.com', 20, 87),
    (9, 'Sanjay Mehta', '1098765432', 'Jaipur', 'sanjay@example.com', 22, 91),
    (10, 'Pooja Desai', '0987654321', 'Surat', 'pooja@example.com', 21, 84);

INSERT INTO [mcc].[course_tbl] ([course_id], [course_name])
VALUES
    (1, 'Mathematics'),
    (2, 'Physics'),
    (3, 'Chemistry'),
    (4, 'Biology'),
    (5, 'Computer Science'),
    (6, 'History'),
    (7, 'Geography'),
    (8, 'Literature'),
    (9, 'Economics'),
    (10, 'Art')
	
INSERT INTO [mcc].[Enrollment_tbl] ([enrollmanet_id], [enrollment_date], [std_id], [course_id])
VALUES
    (1, '2024-02-22', 1, 1),
    (2, '2024-02-23', 2, 2),
    (3, '2024-02-24', 1, 3),
    (4, '2024-02-25', 4, 4),
    (5, '2024-02-26', 1, 5),
    (6, '2024-02-27', 6, 6),
    (7, '2024-02-28', 2, 7),
    (8, '2024-02-29', 8, 8)

select * from mcc.Student_tbl
select * from [mcc].[course_tbl]
select * from [mcc].[Enrollment_tbl]

select s.std_id,s.std_name,COUNT([enrollmanet_id]) as 'total_count'
from mcc.Student_tbl as s
join [mcc].[Enrollment_tbl] as e on s.std_id=e.[std_id]
group by s.std_id,s.std_name
having COUNT([enrollmanet_id])>1



select s.std_id,s.std_name,c.[course_name]
from mcc.Student_tbl as s
inner join [mcc].[Enrollment_tbl] as e on s.std_id=e.[std_id]
inner join [mcc].[course_tbl] as c on c.[course_id]=e.[course_id]
where s.std_id in (select s.std_id 
					from mcc.Student_tbl as s
					join [mcc].[Enrollment_tbl] as e on s.std_id=e.[std_id]
					group by s.std_id,s.std_name
					having COUNT([enrollmanet_id])>1
					)


with cte_total_count
as
(
	select s.std_id,s.std_name
	from mcc.Student_tbl as s
	where s.std_id in (select s.std_id 
					from mcc.Student_tbl as s
					join [mcc].[Enrollment_tbl] as e on s.std_id=e.[std_id]
					group by s.std_id,s.std_name
					having COUNT([enrollmanet_id])>1
					)

)select s.std_id,s.std_name,COUNT(e.[enrollmanet_id]) as total_count
from mcc.Student_tbl as s
join [mcc].[Enrollment_tbl] as e on s.std_id=e.[std_id]
group by s.std_id,s.std_name
having COUNT([enrollmanet_id])>1


CREATE TABLE Airports (
						AirportCode VARCHAR(3) PRIMARY KEY,
						AirportName VARCHAR(100) NOT NULL,
						City VARCHAR(100) NOT NULL,
						Country VARCHAR(100) NOT NULL
						);
INSERT INTO Airports (AirportCode, AirportName, City, Country)
VALUES 
    ('DEL', 'Indira Gandhi International Airport', 'New Delhi', 'India'),
    ('BOM', 'Chhatrapati Shivaji Maharaj International Airport', 'Mumbai', 'India'),
    ('MAA', 'Chennai International Airport', 'Chennai', 'India'),
    ('BLR', 'Kempegowda International Airport', 'Bengaluru', 'India'),
    ('HYD', 'Rajiv Gandhi International Airport', 'Hyderabad', 'India');

CREATE TABLE Airlines (
					AirlineID INT PRIMARY KEY,
					AirlineName VARCHAR(100) NOT NULL,
					IATA_Code VARCHAR(2) NOT NULL
					);

INSERT INTO Airlines (AirlineID, AirlineName, IATA_Code)
VALUES 
    (1, 'Air India', 'AI'),
    (2, 'IndiGo', '6E'),
    (3, 'SpiceJet', 'SG'),
    (4, 'GoAir', 'G8'),
    (5, 'Vistara', 'UK');


CREATE TABLE Flights (
					FlightID INT PRIMARY KEY,
					AirlineID INT,
					FlightNumber VARCHAR(10) NOT NULL,
					DepartureAirportCode VARCHAR(3),
					ArrivalAirportCode VARCHAR(3),
					DepartureTime DATETIME,
					ArrivalTime DATETIME,
					Amount dec(10,2),
					CONSTRAINT FK_Airline FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID),
					CONSTRAINT FK_DepartureAirport FOREIGN KEY (DepartureAirportCode) REFERENCES Airports(AirportCode),
					CONSTRAINT FK_ArrivalAirport FOREIGN KEY (ArrivalAirportCode) REFERENCES Airports(AirportCode)
				);

INSERT INTO Flights (FlightID, AirlineID, FlightNumber, DepartureAirportCode, ArrivalAirportCode, DepartureTime, ArrivalTime, Amount)
VALUES 
    (1, 1, 'AI101', 'DEL', 'BOM', '2024-02-12 08:00:00', '2024-02-12 10:00:00', 200.00),
    (2, 2, '6E202', 'BOM', 'MAA', '2024-02-12 11:00:00', '2024-02-12 13:00:00', 150.00),
    (3, 3, 'SG303', 'MAA', 'BLR', '2024-02-12 14:00:00', '2024-02-12 15:00:00', 100.00),
    (4, 4, 'G845', 'BLR', 'HYD', '2024-02-12 16:00:00', '2024-02-12 17:00:00', 120.00),
    (5, 5, 'UK707', 'HYD', 'DEL', '2024-02-12 18:00:00', '2024-02-12 20:00:00', 180.00);


CREATE TABLE Passengers (
						PassengerID INT PRIMARY KEY,
						PassengerName VARCHAR(100) NOT NULL,
						Age INT,
						Gender VARCHAR(10),
						Email VARCHAR(100)
						);

INSERT INTO Passengers (PassengerID, PassengerName, Age, Gender, Email)
VALUES 
    (1, 'Amit Patel', 35, 'Male', 'amit@example.com'),
    (2, 'Priya Sharma', 28, 'Female', 'priya@example.com'),
    (3, 'Rahul Singh', 45, 'Male', 'rahul@example.com'),
    (4, 'Neha Gupta', 30, 'Female', 'neha@example.com'),
    (5, 'Sanjay Kumar', 40, 'Male', 'sanjay@example.com');

CREATE TABLE Reservations (
							ReservationID INT PRIMARY KEY,
							FlightID INT,
							PassengerID INT,
							ReservationDate DATE,
							SeatNumber VARCHAR(10),
							CONSTRAINT FK_Flight FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
							CONSTRAINT FK_Passenger FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
						);

INSERT INTO Reservations (ReservationID, FlightID, PassengerID, ReservationDate, SeatNumber)
VALUES 
    (1, 1, 1, '2024-02-12', 'A1'),
    (2, 2, 2, '2024-02-12', 'B3'),
    (3, 3, 3, '2024-02-12', 'C2'),
    (4, 4, 4, '2024-02-12', 'D4'),
    (5, 5, 5, '2024-02-12', 'E5'),
    (6, 1, 2, '2024-02-12', 'F6');

INSERT INTO Reservations (ReservationID, FlightID, PassengerID, ReservationDate, SeatNumber)
VALUES (7, 1, 1, '2024-02-12', 'F6');


select r.ReservationID,r.ReservationDate,f.FlightNumber,f.DepartureAirportCode,a1.AirportName as 'Departure_airport',f.ArrivalAirportCode,a2.AirportName as 'Arival_airport',p.PassengerName,p.Age
from Flights as f
join Reservations as r on f.FlightID=r.FlightID
join Passengers as p on p.PassengerID=r.PassengerID
join Airports as a1 on a1.AirportCode=f.DepartureAirportCode
join Airports as a2 on a2.AirportCode=f.ArrivalAirportCode


select r.ReservationID,r.ReservationDate,f.FlightNumber,f.DepartureAirportCode,a1.AirportName as 'Departure_airport',f.ArrivalAirportCode,a2.AirportName as 'Arival_airport',p.PassengerName,p.Age
from Flights as f
join Reservations as r on f.FlightID=r.FlightID
join Passengers as p on p.PassengerID=r.PassengerID
join Airports as a1 on a1.AirportCode=f.DepartureAirportCode
join Airports as a2 on a2.AirportCode=f.ArrivalAirportCode
where r.ReservationID in (
							select r.ReservationID
							from Flights as f
							join Reservations as r on f.FlightID=r.FlightID
							join Passengers as p on p.PassengerID=r.PassengerID
							join Airports as a1 on a1.AirportCode=f.DepartureAirportCode
							join Airports as a2 on a2.AirportCode=f.ArrivalAirportCode
							)


select r.ReservationID,r.ReservationDate
from Reservations as r
where r.PassengerID in (select PassengerID from Passengers
						where PassengerName in (select PassengerName from Passengers
						where PassengerID in (select PassengerID from Flights)))

--Write a query to anlysis number of patients admitted to each ward for each gender --
 --patient table have (patient_id, patient_name,gender (pivot on gender), age, ward)


 CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    ward VARCHAR(50)
);

INSERT INTO Patient (patient_id, patient_name, gender, age, ward)
VALUES
    (1, 'Ramesh Kumar', 'Male', 45, 'General Ward'),
    (2, 'Sunita Sharma', 'Female', 32, 'Maternity Ward'),
    (3, 'Amit Singh', 'Male', 50, 'ICU'),
    (4, 'Priya Patel', 'Female', 28, 'Pediatric Ward'),
    (5, 'Vijay Gupta', 'Male', 60, 'General Ward'),
    (6, 'Anita Verma', 'Female', 40, 'Maternity Ward'),
    (7, 'Rajesh Tiwari', 'Male', 55, 'ICU'),
    (8, 'Sneha Reddy', 'Female', 35, 'Pediatric Ward'),
    (9, 'Sanjay Singh', 'Male', 25, 'General Ward');

	select patient_id, patient_name, gender, age, ward
	from Patient
	group by patient_id, patient_name,age, ward

select	*
from (select ward,gender, count(gender) as no_of_patient 
		from Patient
		group by ward,gender
	)as pivotData
pivot 
(
	sum(no_of_patient) for gender
	in ([Male],[Female])
)as privottable



----------------------------------------------------------------------------------------------------
select * from Employee_tbl		

select * from mcc.Employee_tbl

alter proc usp_ActionPerforme(
								@emp_id int=null,
								@emp_name varchar(100)=null,
								@salary money=null,
								@dept_id int=null,
								@action_type varchar(100),
								@message varchar(100) out
								)
as
	begin
			if @action_type='Select'
				begin
					select emp_id,emp_name,salary,dept_id
					from mcc.Employee_tbl
					where emp_id=@emp_id

					if @@ROWCOUNT>0
						set @message='Wow! Selection is Successfully'
					else
						set @message='Opps! There is no employee in the employee table'
				end

			if @action_type='Insert'

				begin
					if not exists (select emp_id from mcc.Employee_tbl where emp_id=@emp_id)
						begin
							insert into mcc.Employee_tbl(emp_id,emp_name,salary,dept_id)values
							(@emp_id,@emp_name,@salary,@dept_id)
							if @@ROWCOUNT>0
								set @message='Congs! Employee inserted successfully into employee table'
						end
					else
						if @@ROWCOUNT<=0
							set @message='Opps! Same Employee id is pressent in the employee table'
				end
			
				if @action_type='Delete'
					begin
						if exists (select emp_id from mcc.Employee_tbl where emp_id=@emp_id)
							begin
								delete from mcc.Employee_tbl where emp_id=@emp_id
								if @@ROWCOUNT>0
									set @message='Opps! An Employee deleted from employee table'
							end
						else
							if @@ROWCOUNT<=0
								set @message='Opps! There is no employee in the employee table delete can not possible'
					end
				if @action_type='Update'
					begin
						if exists (select emp_id from mcc.Employee_tbl where emp_id=@emp_id)
							begin
								update mcc.Employee_tbl set emp_name=@emp_name,salary=@salary,dept_id=@dept_id
								where emp_id=@emp_id
								if(@@ROWCOUNT>0)
									set @message='Employee Updated Successfully'
								else
									set @message='Not updated'
							end
				end
	end

declare @mess varchar(Max)
exec usp_ActionPerforme 8,'Subrata',59000.00,4,'select',@mess out
print @mess

declare @mess varchar(Max)
exec usp_ActionPerforme 8,'Subrata',59000.00,4,'select',@mess out
print @mess

declare @mess varchar(Max)
exec usp_ActionPerforme 8,'Subrata',59000.00,4,'select',@mess out
print @mess


----------------------------------------------------------------------------
use BikeStores

--create a store procedure that expects one table variable as parametter fro order, order_id,customer_id,quantity 
--with two output parameters total orders and total amount
create type ut_details as table(
								order_id int,
								product_id int,
								customer_id int,
								quantity int
								)

declare @details_tble ut_details
select * from @details_tble



alter proc usp_orderDetails(@details ut_details readonly,
								@total_orders int out,
								@total_amount int out
								)
as 
	begin
			
			select @total_amount=SUM(d.quantity*oi.list_price),@total_orders = COUNT(o.order_id) 
			from sales.orders as o
			join sales.order_items as oi on o.order_id=oi.order_id
			join @details as d on d.order_id=oi.order_id
			group by o.order_id,o.customer_id
	end


declare @details ut_details,@total_orders int,@total_amount int
insert into @details
select 1,2,34,2
exec usp_orderDetails @details ,@total_orders out,@total_amount out
print @total_orders 
print @total_amount


---------------------------------------------------------------------------
--create a sp to retrive order for a specific customer along with details information about the products those orders 
create function fn_getOrdersByCustid(@cust_id int)
returns table
as
return
(
	select * from sales.orders
	where customer_id=@cust_id
)
select * from fn_getOrdersByCustid(1)


select c.customer_id,c.First_name,p.product_id,p.product_name,p.brand_id,p.model_year,p.list_price
from production.products as p
join sales.order_items as oi on p.product_id=oi.product_id
join fn_getOrdersByCustid(259) as o on oi.order_id=o.order_id
join sales.customers as c on c.customer_id=o.customer_id

alter proc usp_orderDetalisFor(@cust_id int)
as 
	begin
		select c.customer_id,c.First_name,p.product_id,p.product_name,p.brand_id,p.model_year,p.list_price
		from production.products as p
		join sales.order_items as oi on p.product_id=oi.product_id
		join sales.orders as o on oi.order_id=o.order_id
		join sales.customers as c on c.customer_id=o.customer_id
		where c.customer_id=@cust_id
	end

exec usp_orderDetalisFor 259
---------------------------------------------------------------------------------

