--												Subrata Pal - 12/02/2024
--													Assignment-III 

create database Exam_DB
use Exam_DB

-----------------------------------------------------------------------------------------------------------
/*1. What will be the output of the below query, given an Employee table having 10 records?        2
            BEGIN TRAN
                TRUNCATE TABLE Employees
                ROLLBACK
            END TRAN
                SELECT * FROM Employees
*/
create table [employee_tbl](
							[emp_id] int primary key,
							[emp_name] varchar(10)
						)
insert into [employee_tbl] ([emp_id],[emp_name])
values(1, 'Subrata'),(2, 'Pranab'),(3, 'rahul'),(4, 'Annesha'),(5, 'Susmita'),(6, 'Vikram'),(7, 'Sunita'),(8, 'Rajesh'),(9, 'Pooja'),(10, 'Ravi');

  BEGIN TRAN
             TRUNCATE TABLE [employee_tbl]
              ROLLBACK
   END TRAN
                SELECT * FROM [employee_tbl]

--bellow code give me syntax error because when we write begin transaction then we have to do rollback/commit so that means when rollback/commit
--found then autometically transaction is close . dont need to declare end tran

--correct code is 
begin transaction
     TRUNCATE TABLE [employee_tbl]
     ROLLBACK tran

SELECT * FROM [employee_tbl]
--in the bellow code the output wull be 10 employee record because when we truncate the table and after that we declare rollback so it means 
--what ever we done before the rollback it will caome back again 

-------------------------------------------------------------------------------------------------------------------
/*2.Write an SQL query to display the text CAPONE as following:                                                           2
                    C
                    A
                    P
                    O
                    N
                    E
*/
/*select SUBSTRING('CAPONE',1,1), 
	   SUBSTRING('CAPONE',2,1),
	   SUBSTRING('CAPONE',3,1),
	   SUBSTRING('CAPONE',4,1),
	   SUBSTRING('CAPONE',5,1),
	   SUBSTRING('CAPONE',6,1)*/

declare @string varchar(100)='CAPONE'
declare @String_lenth int=len(@string)
declare @i int=1
while @i<=@String_lenth
	begin
		print SUBSTRING(@string,@i,1)
		set @i=@i+1
	end
---------------------------------------------------------------------------------------------------------
--3. Explain the difference between ROW_NUMBER (), RANK () & DENSE_RANK () by giving an example.		2
create table [teacher_tbl](
							[teache_name] varchar(50),
							[age] tinyint,
							[dept_name] varchar(100),
							[dept_id] int
						)
INSERT INTO [teacher_tbl] ([teache_name], [age], [dept_name], [dept_id])
VALUES 
    ('Teacher1', 35, 'Mathematics', 101),
    ('Teacher2', 40, 'Physics', 105),
    ('Teacher3', 38, 'Chemistry', 101),
    ('Teacher4', 32, 'Biology', 101),
    ('Teacher5', 45, 'History', 105),
    ('Teacher6', 37, 'Geography', 106),
    ('Teacher7', 42, 'English', 107),
    ('Teacher8', 33, 'Computer Science', 108);

--rank()--It is a window function.In the rank function we assign a rank to each row within a partiton of result set. it assign rank to each row and also count the row
-- when another pratiton is come then assgn the rank of that row value. it not started from first 
select [teache_name], [age], [dept_name], [dept_id],rank() over (order by [dept_id] desc) as ranking
from [teacher_tbl] 
order by ranking

--dense_rank()--it is a window function. In the dense_rank function assign a rank to each row within a partiton of result set.
--it assign rank to each row when another pratiton is come then assgn a new rank of that row value. it will started from first.
select [teache_name],[age], [dept_name], [dept_id],dense_rank() over (order by [dept_id] desc) as ranking
from [teacher_tbl] 
order by ranking

--row_number()-it is also window function. In the row_number() function assign a sequential integer to each row within a partiton of result set.
--it start with 1 fro the first row in each partition.
select [teache_name], [age], [dept_name], [dept_id],row_number() over (partition by [dept_id] order by [age] desc) as ranking
from [teacher_tbl] 
order by [dept_id] desc
---------------------------------------------------------------------------------------------------------
--4. What are Scope_identity () and @@rowcount, explain with example.								1+1  
--Scope_identity ()--Scope_identity function returns the last identity value form a table which table is previouslly created in
-- current session.
create table [employee](
					[e_id] int identity(101,1) constraint emp_tbl_pk primary key,
					[e_name] varchar(100)
					)
insert into [employee] ([e_name]) values('rahul'),('pranab'),('Subrata')

select Scope_identity () as 'Scope_identity'

--@@rowcount--@@rowcount function returns the number of rows affected by the previous statement. it can can be insert, update, delete statement
select * from [teacher_tbl]
select @@ROWCOUNT as 'r_count'
--------------------------------------------------------------------------------------------------------
/*5. Let us have a table with the following data:                                                                                             2

					CourseID    Course Name
					1                 .Net
					2                 SQL Server
					3                 SSRS
					4                 SharePoint
					5                 WCF
We need to concatenate the Course Name column like the following:.Net, SQL Server, SSRS, SharePoint, WCF*/
create table [course_table](
							[course_id] int primary key,
							[course_name] varchar(100)
						)
INSERT INTO [course_table] ([course_id], [course_name])
VALUES 
    (1, '.Net'),
    (2, 'SQL Server'),
    (3, 'SSRS'),
    (4, 'SharePoint'),
    (5, 'WCF');

select * from [course_table]

declare @columnnames nvarchar(max)='';select @columnnames +=QUOTENAME([Course_Name])+','from [course_table]set @columnnames=left(@columnnames,len(@columnnames)-1);

create function fn_course_name()returns nvarchar(max)asbegindeclare @columnnames nvarchar(max)='';select @columnnames +=QUOTENAME([Course_Name])+','from [course_table]set @columnnames=left(@columnnames,len(@columnnames)-1);return @columnnamesend

select dbo.fn_course_name() as ConcatenatedCourses

SELECT STRING_AGG(Course_Name, ', ') AS ConcatenatedCourses
FROM course_table;

---------------------------------------------------------------------------------------------------------
--6. Create a stored procedure to print total number of patients and their average age to a specific doctor. 
--The procedure should return total number of patients and their average age. 
CREATE TABLE [Doctors] (
						[DoctorID] INT PRIMARY KEY,
						[DoctorName] VARCHAR(100) NOT NULL,
						[Specialization] VARCHAR(100),
						[PhoneNumber] VARCHAR(20)
					);

INSERT INTO [Doctors] ([DoctorID], [DoctorName],[Specialization], [PhoneNumber])
VALUES
    (1, 'Dr. Rajesh Sharma', 'Cardiologist', '+91-XXXXXXXXXX'),
    (2, 'Dr. Priya Singh', 'Pediatrician', '+91-XXXXXXXXXX'),
    (3, 'Dr. Ananya Patel', 'Dermatologist', '+91-XXXXXXXXXX'),
    (4, 'Dr. Sanjay Gupta', 'Orthopedic Surgeon', '+91-XXXXXXXXXX'),
    (5, 'Dr. Neha Verma', 'Psychiatrist', '+91-XXXXXXXXXX');

select * from [Doctors]

CREATE TABLE [Patients] (
						[PatientID] INT PRIMARY KEY,
						[PatientName] VARCHAR(100) NOT NULL,
						[Age] INT,
						[Gender] VARCHAR(10),
						[DoctorID] INT, -- Foreign Key referencing Doctors table
						CONSTRAINT [FK_Doctor] FOREIGN KEY ([DoctorID]) REFERENCES [Doctors]([DoctorID])
					);



INSERT INTO [Patients] ([PatientID],[PatientName],[Age], [Gender], [DoctorID])
VALUES
    (1, 'Ramesh Kumar', 35, 'Male', 1),
    (2, 'Sunita Devi', 45, 'Female', 2),
    (3, 'Amit Singh', 28, 'Male', 3),
    (4, 'Kavita Sharma', 50, 'Female', 4),
    (5, 'Deepak Verma', 22, 'Male', 5),
    (6, 'Anjali Patel', 38, 'Female', 1);

select * from [Patients]

CREATE TABLE [Medicines](
						[MedicineID] INT PRIMARY KEY,
						[MedicineName] VARCHAR(100) NOT NULL,
						[Quantity] INT
					);	
INSERT INTO [Medicines] ([MedicineID],[MedicineName],[Quantity])
VALUES
    (1, 'Paracetamol', 100),
    (2, 'Amoxicillin', 50),
    (3, 'Omeprazole', 75),
    (4, 'Aspirin', 200),
    (5, 'Atorvastatin', 80),
    (6, 'Metformin', 60),
    (7, 'Levothyroxine', 40),
    (8, 'Lisinopril', 90)

select * from [Medicines]

CREATE TABLE [Prescriptions] (
							[PrescriptionID] INT PRIMARY KEY,
							[PatientID] INT, -- Foreign Key referencing Patients table
							[MedicineID] INT, -- Foreign Key referencing Medicines table
							[PrescriptionDate] DATE,
							[Dosage] VARCHAR(50),
							CONSTRAINT [FK_Patient] FOREIGN KEY ([PatientID]) REFERENCES [Patients]([PatientID]),
							CONSTRAINT [FK_Medicine] FOREIGN KEY ([MedicineID]) REFERENCES [Medicines]([MedicineID])
						);

INSERT INTO [Prescriptions] (PrescriptionID, PatientID, MedicineID, PrescriptionDate, Dosage)
VALUES
    (1, 1, 1, '2024-02-10', '1 tablet three times a day'),
    (2, 2, 2, '2024-02-11', '500mg twice a day'),
    (3, 3, 3, '2024-02-12', '20mg once a day'),
    (4, 4, 4, '2024-02-10', '325mg every four hours as needed'),
    (5, 5, 5, '2024-02-11', '40mg once daily'),
    (6, 6, 6, '2024-02-12', '500mg twice daily with meals'),
    (7, 1, 7, '2024-02-10', '50mcg once daily'),
    (8, 2, 8, '2024-02-11', '10mg once daily');

alter proc usp_getPatient(
							@doct_id int,
							@p_age int out,
							@total_Pat int out
							)
as 
begin
		
		select @p_age=AVG(p.age),@total_Pat=COUNT(p.DoctorID)
		from Patients as p
		join Doctors as d on d.DoctorID=p.DoctorID
		where d.DoctorID=@doct_id
end

declare @avgAge int 
declare @tot_pat int
declare @doc_id int=1
exec usp_getPatient @doct_id=@doc_id,@p_age=@avgAge out ,@total_Pat= @tot_pat out

select  @doc_id as 'doctor_id',@avgAge as 'avarage_age',@tot_pat as 'total_Patients'
------------------------------------------------------------------------------------------------------------
--7. Create a stored procedure with input student ID, course ID and enrolment date to enrol 
--a student in multiple courses simultaneously while ensuring that all enrollments are successful or rolled back in case of any failure.

create table [stduent](
					[std_id] int primary key,
					[std_name] varchar(100)
					)

INSERT INTO [stduent] ([std_id],[std_name]) VALUES
(1, 'Ramesh Kumar'),
(2, 'Priya Patel'),
(3, 'Amit Singh'),
(4, 'Neha Sharma'),
(5, 'Rajesh Gupta'),
(6, 'Sneha Joshi');

create table [course](
					[cour_id] int primary key,
					[cour_name] varchar(100)
					)
INSERT INTO [course] ([cour_id],[cour_name]) VALUES
(1, 'Mathematics'),
(2, 'Physics'),
(3, 'Computer Science'),
(4, 'Literature'),
(5, 'History'),
(6, 'Biology');

create table [Enrollment](
						[e_id] int primary key,
						[e_date] date,
						[s_id] int foreign key references [stduent]([std_id]),
						[c_id] int foreign key references [course]([cour_id])
						)

INSERT INTO [Enrollment] ([e_id],[e_date],[s_id],[c_id]) VALUES
(1, '2024-02-12', 1, 1),
(2, '2024-02-12', 2, 2),
(3, '2024-02-12', 3, 3),
(4, '2024-02-12', 4, 4),
(5, '2024-02-12', 5, 5),
(6, '2024-02-12', 6, 6),
(7, '2024-02-12', 1, 2),
(8, '2024-02-12', 2, 3);

select * from [stduent]
select * from [course]
select * from [Enrollment]

create proc usp_Enrolment(
						@e_id int,
						@std_id int,
						@cour_id int,
						@en_date date,
						@mess varchar(100) out
						)
as 
begin
				begin transaction
						if not exists ( select * from Enrollment where s_id=@std_id and c_id=@cour_id)
							begin
								insert into Enrollment(e_id,e_date,s_id,c_id) values(@e_id,@en_date,@std_id,@cour_id)
								if(@@ROWCOUNT>0)
										set @mess='Inserted'
								commit tran
							end
						else
							begin
								rollback tran
								if(@@ROWCOUNT<=0)
										set @mess='Dublicate data present'
							end

end

declare @message varchar(100) 
exec usp_Enrolment 10,1,3,'2024-01-01',@message out
print @message

select * from [Enrollment]
----------------------------------------------------------------------------------------------
--8.Create stored procedure to place an order and corresponding entry should be done in all tables like order, order_items, stock. 4

create table [order_tbl](
						[order_id] int primary key,
						[customer_id] int,
						[order_date] date
						)
INSERT INTO order_tbl (order_id,customer_id, order_date) VALUES (1,1, '2024-02-01');
INSERT INTO order_tbl (order_id,customer_id, order_date) VALUES (2,2, '2024-02-02');
INSERT INTO order_tbl (order_id,customer_id, order_date)VALUES (3,3, '2024-02-03');
INSERT INTO order_tbl (order_id,customer_id, order_date) VALUES (4,4, '2024-02-04');
INSERT INTO order_tbl (order_id,customer_id, order_date) VALUES (5,5, '2024-02-05');

create table stock_tble(
						product_id int primary key,
						quantity int,
						ordr_id int constraint st_tbl_fk foreign key references order_tbl(order_id)
						)

INSERT INTO stock_tble (product_id,quantity, ordr_id ) VALUES (1,10, 1);
INSERT INTO stock_tble (product_id,quantity, ordr_id ) VALUES (2,20, 2);
INSERT INTO stock_tble (product_id,quantity, ordr_id ) VALUES (3,15, 3);
INSERT INTO stock_tble (product_id,quantity, ordr_id ) VALUES (4,25, 4);
INSERT INTO stock_tble (product_id,quantity, ordr_id ) VALUES (5,30, 5);


select * from order_tbl
select * from stock_tble


create proc usp_PlaceOder(
							@order_id int,
							@product_id int,
							@quantity int,
							@customer_id int,
							@order_date date
						)
as 
begin
		begin try 
				begin transaction
						insert into order_tbl(order_id,customer_id,order_date) values(@order_id,@customer_id,@order_date)

						update stock_tble set quantity=quantity-@quantity
						where product_id=@product_id

						commit tran
		end try
		begin catch
					if @@TRANCOUNT>0
							rollback tran
		end catch
end

select * from order_tbl
select * from stock_tble


exec usp_PlaceOder 7,2,4,2,'2024-02-01'


--------------------------------------------------------------------------------------------------
--9.Create stored procedure to take input parameter passenger id to retrieve booking details for a specific passenger and 
--returns output parameters to provide information about the number of bookings and the total amount spent by the passenger.
--create database Exam_db_2
use Exam_db_2

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

alter proc usp_bookdetails(
								@P_ID int,
								@Tot_Booking int out,
								@Total_amount dec(10,2) out
							)
as
begin
    
    
    select @Tot_Booking = COUNT(*),@Total_amount = SUM(f.Amount)
    from Reservations as r
    join Flights as f on r.FlightID = f.FlightID
	where r.PassengerID = @P_ID 

end

declare @pass varchar(100)=1
declare @total_book int 
declare @total_ammout dec(10,2)
exec usp_bookdetails @P_ID=@pass,@Tot_Booking =@total_book out,@Total_amount=@total_ammout out
select  @pass as 'Pasenger_id',@total_book as 'Total_book',@total_ammout as 'total_Amount'

--------------------------------------------------------------------------------------------------------------
--10. Suppose there is table named sales that stores information about sales transactions, including the sales ID, 
--sales date, customer ID, product ID, and the total amount. Create indexes on the columns frequently used in the 
--WHERE clause or JOIN conditions like sales date, customer id, product id using covering index.       4 
create table sales(
					sales_id int primary key,
					sales_date date,
					customer_id int,
					product_id int,
					total_amount dec(10,2)
					)
DECLARE @counter INT = 1;
WHILE @counter <= 30000
BEGIN
    INSERT INTO sales ([sales_id], [sales_date], [customer_id], [product_id], [total_amount])
    VALUES 
        (@counter, DATEADD(DAY, -(@counter % 365), GETDATE()), ABS(CHECKSUM(NEWID()) % 1000) + 1, ABS(CHECKSUM(NEWID()) % 100) + 1, ABS(CHECKSUM(NEWID()) % 1000) + 1);
    SET @counter = @counter + 1;
END;

select * from sales

create nonclustered index ix_sales on sales( [sales_date],[customer_id],[product_id])include([total_amount])

select * from sales where sales_id=13869 and sales_date='2023-02-13'

select * from sales where sales_id=18248 and product_id=19

select * from sales where customer_id=267 and product_id=96
---------------------------------------------------------------------------------------------------------------


