create table dbo.Phone(
						ID int identity(1,1)
						,Phone varchar(50)
						,Price float
						,Length float
						,Width float
						,Quantity int
						,Color varchar(20)
						)


select *
from dbo.Phone
where Price > 600
--
select *
from dbo.Phone
where Quantity > 2 and Color = 'Blue'
--
select *
		,Price * Quantity as Total_Price
from dbo.Phone
--
select *
from dbo.Phone
where Length * Width > 10