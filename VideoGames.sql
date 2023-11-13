--
create database VideoGames
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VideoGames', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\VideoGames.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'VideoGames_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\VideoGames_log.ldf' , SIZE = 8192KB , MAXSIZE = 102400KB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
--
use videogames
--
create schema Games 
authorization dbo
--
create table Games.Clients(
							 ID int identity(1,1) primary key
							,FirstName varchar(50) not null
							,Surname varchar(50) not null
							,Email varchar(100)
							,BirthDay date not null
							,Nationality tinyint not null
							,City tinyint not null
							,Sex tinyint
							,RegistrationTime date default getdate()
							,CreditCardNumber varchar(20)
							)
--
create table Games.Countries(
								ID tinyint identity(1,1) primary key
							   ,Country varchar(20) not null
							   )
--
create table Games.City(
                         ID tinyint identity(1,1) primary key
						,CountryID tinyint
						,City varchar(20) unique
						)
--
create table Games.Sex(
						Sex tinyint primary key
					   ,SexName varchar(6)
					   )
--
create table Games.Suppliers(
								ID int identity(1,1) primary key
							   ,FirstName varchar(50) not null
							   ,Surname varchar(50) not null
							   ,Phone varchar(20)
							   ,Email varchar(100)
							   )
--
create table Games.Employers(
							   ID int identity(1,1) primary key
							  ,FirstName varchar(50) not null
							  ,Surname varchar(50) not null
							  ,RegistrationDate date default getdate() not null
							  ,Address varchar(100)
							  ,PositionID tinyint
							  ,Salary int check (Salary > 0)
							  )
--
create table Games.Positions(
								ID tinyint identity(1,1) primary key
								,Position varchar(30)
								)
--
create table Games.VideoGames(
								ID int identity(1,1) primary key
							   ,Name varchar(20) not null
							   ,Price int
							   ,Curency tinyint
							   ,SupplierID int
							   ,PublisherID int
							   ,Rank int
					   )
--
create table Games.Publisher(
                             ID int identity(1,1) primary key
							,Publisher varchar(20)
							 )
--
create table Games.Curency(
							ID tinyint identity(1,1) primary key
						   ,Curency char(3)
						   )
--
create table Games.Languages(
								ID tinyint identity(1,1) primary key
							   ,Language char(3) 
							  )
--
create table Games.GameLan(
							 ID int identity(1,1) primary key
							,GameID int not null
							,LanguageID tinyint not null
							)
--
create table Games.SoldGames(
							   ID int identity(1,1) primary key
							  ,ClientID int
							  ,GameID int
							  ,SoldDate date default getdate()
							  ,StatusID char(1)
							  )
--
create table Games.SoldGameStatus(
								    StatusID char(1) primary key
								   ,Status varchar(10)
								   )
--
alter table Games.Clients
add constraint Clients_UK unique  (FirstName,Surname)
--
alter table Games.Suppliers
add constraint Suppliers_UK unique  (FirstName,Surname)
--
alter table Games.Clients
add constraint Clients_FK1 foreign key  (Nationality) references Games.Countries(ID)
--
alter table Games.Clients
add constraint Clients_FK2 foreign key  (Sex) references Games.Sex(Sex)
--
alter table Games.Employers
add constraint Employers_FK1 foreign key  (PositionID) references Games.Positions(ID)
--
alter table Games.GameLan
add constraint GameLan_FK1 foreign key  (GameID) references Games.VideoGames(ID)
--
alter table Games.GameLan
add constraint GameLan_FK2 foreign key  (LanguageID) references Games.Languages(ID)
--
alter table Games.City
add constraint City_FK1 foreign key  (CountryID) references Games.Countries(ID)
--
alter table Games.VideoGames
add constraint VideoGames_FK1 foreign key  (PublisherID) references Games.Publisher(ID)
--
alter table Games.VideoGames
add constraint VideoGames_FK2 foreign key  (SupplierID) references Games.Suppliers(ID)
--
alter table Games.VideoGames
add constraint VideoGames_FK3 foreign key  (Curency) references Games.Curency(ID)
--
alter table games.soldgames
add constraint sold_FK1 foreign key (StatusID) references Games.SoldGameStatus(StatusID)
--
alter table games.soldgames
add constraint sold_FK2 foreign key (ClientID) references Games.Clients(ID)
--
alter table games.soldgames
add constraint sold_FK3 foreign key (GameID) references Games.VideoGames(ID)
--
create schema LogedData
authorization dbo
--
create table LogedData.log_Data(
									 ID int 
									,log_time date
									,log_user nvarchar(100)
									,log_type char(1)
									,TableName varchar(20)
									)
--
CREATE TABLE LogedData.index_logs (
							log_id INT IDENTITY(1,1) PRIMARY KEY,
							event_data XML NOT NULL,
							changed_by SYSNAME NOT NULL
							)
--
create trigger tr_SoldGames
on Games.SoldGames
for update, insert, delete
as
begin
	--
	set nocount on;
	--
	if exists (
				select 1
				from inserted
				)
		and exists (
					select 1
					from deleted
					)
					begin
					    --
						insert into LogedData.log_Data
						select i.id
							  ,getdate()
							  ,SUSER_NAME()
							  ,'U'
							  ,'SoldGames'
						from inserted i
						--
					end
		else if exists (
						select 1
						from deleted
						)
				begin
					--
					insert into LogedData.log_Data
					select d.id
						  ,getdate()
						  ,SUSER_NAME()
						  ,'D'
						  ,'SoldGames'
					from deleted d
					--
				end
		else
				begin
					--
					insert into LogedData.log_Data
					select i.id
						  ,getdate()
						  ,SUSER_NAME()
						  ,'I'
						  ,'SoldGames'
					from inserted i
					--
			end
--
end
--
create trigger tr_Clients
on Games.Clients
for update, insert, delete
as
begin
	--
	set nocount on;
	--
	if exists (
				select 1
				from inserted
				)
		and exists (
					select 1
					from deleted
					)
					begin
					    --
						insert into LogedData.log_Data
						select i.id
							  ,getdate()
							  ,SUSER_NAME()
							  ,'U'
							  ,'Clients'
						from inserted i
						--
					end
		else if exists (
						select 1
						from deleted
						)
				begin
					--
					insert into LogedData.log_Data
					select d.id
						  ,getdate()
						  ,SUSER_NAME()
						  ,'D'
						  ,'Clients'
					from deleted d
					--
				end
		else
				begin
					--
					insert into LogedData.log_Data
					select i.id
						  ,getdate()
						  ,SUSER_NAME()
						  ,'I'
						  ,'Clients'
					from inserted i
					--
			end
--
end
--
create trigger tr_Suppliers
on Games.Suppliers
for update, insert, delete
as
begin
	--
	set nocount on;
	--
	if exists (
				select 1
				from inserted
				)
		and exists (
					select 1
					from deleted
					)
					begin
					    --
						insert into LogedData.log_Data
						select i.id
							  ,getdate()
							  ,SUSER_NAME()
							  ,'U'
							  ,'Suppliers'
						from inserted i
						--
					end
		else if exists (
						select 1
						from deleted
						)
				begin
					--
					insert into LogedData.log_Data
					select d.id
						  ,getdate()
						  ,SUSER_NAME()
						  ,'D'
						  ,'Suppliers'
					from deleted d
					--
				end
		else
				begin
					--
					insert into LogedData.log_Data
					select i.id
						  ,getdate()
						  ,SUSER_NAME()
						  ,'I'
						  ,'Suppliers'
					from inserted i
					--
			end
--
end
--
create trigger tr_Employers
on Games.Employers
for update, insert, delete
as
begin
	--
	set nocount on;
	--
	if exists (
				select 1
				from inserted
				)
		and exists (
					select 1
					from deleted
					)
					begin
					    --
						insert into LogedData.log_Data
						select i.id
							  ,getdate()
							  ,SUSER_NAME()
							  ,'U'
							  ,'Employers'
						from inserted i
						--
					end
		else if exists (
						select 1
						from deleted
						)
				begin
					--
					insert into LogedData.log_Data
					select d.id
						  ,getdate()
						  ,SUSER_NAME()
						  ,'D'
						  ,'Employers'
					from deleted d
					--
				end
		else
				begin
					--
					insert into LogedData.log_Data
					select i.id
						  ,getdate()
						  ,SUSER_NAME()
						  ,'I'
						  ,'Employers'
					from inserted i
					--
			end
--
end
--
create trigger tr_VideoGames
on Games.VideoGames
for update, insert, delete
as
begin
	--
	set nocount on;
	--
	if exists (
				select 1
				from inserted
				)
		and exists (
					select 1
					from deleted
					)
					begin
					    --
						insert into LogedData.log_Data
						select i.id
							  ,getdate()
							  ,SUSER_NAME()
							  ,'U'
							  ,'VideoGames'
						from inserted i
						--
					end
		else if exists (
						select 1
						from deleted
						)
				begin
					--
					insert into LogedData.log_Data
					select d.id
						  ,getdate()
						  ,SUSER_NAME()
						  ,'D'
						  ,'VideoGames'
					from deleted d
					--
				end
		else
				begin
					--
					insert into LogedData.log_Data
					select i.id
						  ,getdate()
						  ,SUSER_NAME()
						  ,'I'
						  ,'VideoGames'
					from inserted i
					--
			end
--
end
--
CREATE TRIGGER trg_index_changes
ON DATABASE
FOR	
    CREATE_INDEX,
    ALTER_INDEX, 
    DROP_INDEX
AS
BEGIN
	--
    SET NOCOUNT ON;
	--
    INSERT INTO LogedData.index_logs (
										event_data,
										changed_by
									)
    VALUES (
				EVENTDATA(),
				SUSER_NAME()
			)
END
--
create or alter proc maintenance
as
begin
	--
	DECLARE @db_id SMALLINT ,
    @MaxCount INT ,
    @Counter INT

	SET @db_id = DB_ID();

	SELECT  dbtables.[name] AS 'Table' ,
			dbindexes.[name] AS 'Index' ,
			indexstats.avg_fragmentation_in_percent ,
			CASE WHEN  indexstats.avg_fragmentation_in_percent <= 30 THEN 'REORGANIZE'
				 WHEN indexstats.avg_fragmentation_in_percent > 30 THEN 'REBUILD'
			END AS IndexStatus
		--,indexstats.page_count
	INTO    #IndexFragmentation
	FROM    sys.dm_db_index_physical_stats(@db_id, NULL, NULL, NULL, NULL) AS indexstats
	INNER JOIN sys.tables dbtables
			ON dbtables.[object_id] = indexstats.[object_id]
	INNER JOIN sys.schemas dbschemas
			ON dbtables.[schema_id] = dbschemas.[schema_id]
	INNER JOIN sys.indexes AS dbindexes
			ON dbindexes.[object_id] = indexstats.[object_id]
			   AND indexstats.index_id = dbindexes.index_id
	WHERE   indexstats.database_id = @db_id
			AND page_count > 1000
			AND dbindexes.name IS NOT NULL
	ORDER BY indexstats.avg_fragmentation_in_percent DESC;

	--SELECT * FROM #IndexFragmentation AS IFR
	CREATE TABLE #execScript
		(
		  ID INT IDENTITY(1, 1) ,
		  Script NVARCHAR(2000)
		);
	INSERT  INTO #execScript
			(
			  Script
			)

        SELECT  'ALTER INDEX ' + [Index] + ' ON ' + [Table] + ' ' + IndexStatus AS Script
        FROM    #IndexFragmentation AS IFR
        WHERE   IndexStatus IN ( 'REORGANIZE', 'REBUILD' )
        UNION
        SELECT  'UPDATE STATISTICS ' + [Table] + ' WITH ALL, FULLSCAN'
        FROM    #IndexFragmentation AS IFR
        WHERE   IndexStatus IN ( 'REORGANIZE', 'REBUILD' );

	SET @Counter = 1;
	SELECT  @MaxCount = MAX(ID)
	FROM    #execScript AS ES;

	DECLARE @SqlCommand NVARCHAR(MAX);

	WHILE @Counter <= @MaxCount
		BEGIN
			SET @SqlCommand = 'SELECT ES.Script
	FROM    #execScript AS ES
	WHERE   ID = ' + CONVERT(VARCHAR(4), @Counter) + '';
			EXEC sp_executesql
				@SqlCommand;
			SET @Counter = @Counter + 1;
		END;

	DROP TABLE #execScript;
	DROP TABLE #IndexFragmentation;
	--
	exec sys.sp_updatestats
	--
end
--

--- insert data
--
insert into games.Positions(Position)
values('IT'),('Manager'),('Guard'),('HR')
--
insert into Games.Publisher(Publisher)
values ('2k Sports'),('11 Bit Studios'),('1c Company')
--
insert into Games.Sex
values(1,'Male'),(0,'Female')
--
insert into Games.Countries(Country)
values ('Georgia'),('UK'),('France'),('Switzerland'),('USA')
--
insert into Games.Curency(Curency)
values ('GEL'),('USD'),('GPB')
--
insert into Games.City(CountryID,City)
values(1,'Tbilisi'),(1,'Dusheti'),(2,'London'),(3,'Paris'),(4,'Zurih'),(5,'NYC')
--
insert into Games.Languages(language)
values('GEO'),('ENG'),('RUS'),('FRA')
--
insert into games.Clients(
							 FirstName
							,Surname 
							,Email
							,BirthDay
							,Nationality
							,City 
							,Sex 
					  		,CreditCardNumber 
					      )
values(
		'Grigol'
	   ,'Taniashvili'
	   ,'gr.taniashvili@gmail.com'
	   ,'07.09.1993'
	   ,1
	   ,1
	   ,1
	   ,'2342423424'
	   )
	   ,
	   (
		'Teo'
	   ,'Giguari'
	   ,'gr.tansdfsdshvili@gmail.com'
	   ,'07.09.1983'
	   ,2
	   ,3
	   ,0
	   ,'2342423424'
	   )
	   ,(
		'Gia'
	   ,'Taniashvili'
	   ,'gr.tassfsfvili@gmail.com'
	   ,'07.09.1993'
	   ,1
	   ,1
	   ,1
	   ,'234232423424'
	   )
	   ,
	   (
		'Nino'
	   ,'Papava'
	   ,'n.Papava@gmail.com'
	   ,'02.12.2000'
	   ,1
	   ,1
	   ,1
	   ,'234567424'
	   ),
	   (
		'Ana'
	   ,'aniashvili'
	   ,'Ana.aniashvili@gmail.com'
	   ,'07.09.1993'
	   ,1
	   ,1
	   ,0
	   ,'23456784'
	   )
--
insert into games.Suppliers(
							 FirstName
							,Surname 
							,Phone
							,Email
						   )
values(
		'Grigol'
	   ,'Taniashvili'
	   ,'8768'
	   ,'sdfsdfsdf@zdfsdf'
	   )
	   ,
	   (
		'Teo'
	   ,'Giguari'
	   ,'897686'
	   ,'s34w4df@zdfsdf'
	   )
	   ,(
		'Gia'
	   ,'Taniashvili'
	   ,'5645645646'
	   ,'ghghgh@zdfsdf'
	   )
	   ,
	   (
		'Nino'
	   ,'Papava'
	   ,'43656'
	   ,'sdfsereref@zdfsdf'
	   ),
	   (
		'Ana'
	   ,'aniashvili'
	   ,'0987654'
	   ,'sdsdgbsdf@zdfsdf'
	   )
--
insert into games.Employers(
							   FirstName 
							  ,Surname
							  ,PositionID
							  ,Salary 
					        )
values(
		'Vaza'
	   ,'Rurua'
	   ,1
	   ,2000
	   )
	   ,
	   (
		'Teo'
	   ,'Papava'
	   ,2
	   ,2000
	   )
	   ,(
		'Gia'
	   ,'Gigauri'
	   ,3
	   ,2000
	   )
	   ,
	   (
		'Nino'
	   ,'Papava'
	   ,3
	   ,2000
	   ),
	   (
		'Ana'
	   ,'Xubua'
	   ,2
	   ,2000
	   )
 --
insert into Games.VideoGames(Name,Price,Curency,SupplierID,PublisherID,Rank)
values('GTA5',100,1,1,3,1),('FIFA',200,2,2,2,2),('NBA',200,3,4,2,3)
--
insert into Games.GameLan(GameID,LanguageID)
values(2,1),(1,2),(2,3)
--
insert into Games.SoldGameStatus
values ('S','Sold'),('R','Returned')
--selects
select * 
from games.Clients
--
select * 
from games.Employers
--
select * 
from games.Countries
--
select * 
from games.City
--
select * 
from games.VideoGames
--
select * 
from games.Languages
--
select * 
from games.GameLan
--
select * 
from games.sex
--
select * 
from games.SoldGameStatus
--
select * 
from games.SoldGames
--
select * 
from games.Suppliers
--
select *
from LogedData.log_Data
--
select *
from LogedData.index_logs
--
-- Procedures
--
create or alter function games.FnSplitParameterVals(
														@List varchar(20)
							     						,@SplitOn nvarchar(5)
														)  
returns @RtnValue table 
				(

					Id int identity(1,1),
					Value char(1)
				) 
		as  
begin
	--
	while (Charindex(@SplitOn,@List)>0)
		begin 
			--
			insert Into @RtnValue (value)
			select
			value = ltrim(rtrim(substring(@List,1,charindex(@SplitOn,@List)-1))) 
			set @List = Substring(@List,charindex(@SplitOn,@List)+len(@SplitOn),len(@List))
			--
		end 
	--
	insert into @RtnValue (Value)
	select value = ltrim(rtrim(@List))
	return
	--
end
--
create or alter procedure games.SoldGame(
										 @ClientID int
										,@GameID varchar(20)
										 )
  as
begin 
	--
	insert into games.SoldGames(ClientID,GameID,SoldDate,StatusID)
	select @ClientID
		  ,t.Value
		  ,GETDATE()
		  ,'S'
	from games.FnSplitParameterVals(@GameID,',') t
	--
end
--
create or alter procedure games.ReturnGame(
											 @ID int
										 )
  as
begin 
    --
	update games.SoldGames 
	set StatusID = 'R'
	where ID = @ID
	--
end
--
create or alter proc Games.GameInfo(
						 			@StartDate date
							       ,@EndDate date
								   )
   as
begin 
	--
	select c.FirstName ClientName
		  ,c.Surname ClientSurname
		  ,c.ID ClientID
		  ,s.Phone SupplierPhone
		  ,vg.ID VideoGameID
		  ,vg.Name VideoGame
		  ,vg.Price 
		  ,cu.Curency curency
		  ,s.FirstName SupplierName
		  ,s.Surname SupplierSurname
		  ,sgs.Status
	from games.SoldGames sg
	join games.Clients c
	on c.ID = sg.ClientID
	join games.VideoGames vg
	on vg.ID=sg.GameID
	join games.Suppliers s
	on vg.SupplierID = s.ID
	join games.SoldGameStatus sgs
	on sg.StatusID = sgs.StatusID
	join games.Curency cu
	on vg.Curency = cu.ID
	where sg.SoldDate between @StartDate and @EndDate
	--
end
--
exec games.SoldGame 4,'1,2,3'
exec games.ReturnGame 4
exec games.GameInfo '2021-12-10','2021-12-22'

update games.Clients
set Surname = 'Papalashvili'
where id=3
--
create or alter view games.EmpFullInfo
  as
select emp.[ID]
      ,[FirstName]
      ,[Surname]
      ,[RegistrationDate]
      ,[Address]
      ,p.Position
      ,[Salary]
from Games.Employers emp
join Games.Positions p
on p.ID = emp.PositionID
--
create or alter view games.ClientFullInfo
  as
select cl.[ID]
      ,cl.[FirstName]
      ,cl.[Surname]
      ,cl.[Email]
      ,cl.[BirthDay]
      ,co.[Country] Nationality
      ,ci.[City]
      ,s.[SexName] Gender
      ,cl.[RegistrationTime]
      ,cl.[CreditCardNumber]
from Games.clients cl
join games.Countries co
on co.ID = cl.Nationality
join games.City ci
on ci.ID = cl.City
join games.Sex s
on s.Sex = cl.Sex
--
create or alter function Games.GetAge(
										@BD date
										)
returns int
as
begin
	--
	return datediff(DAY,@BD,getdate())/365.242199
	--
end
--
create or alter function games.AgeRange( 
                                         @agerange tinyint
										 )
returns @t table (
					 ClientID int 
					,FirstName varchar(50) 
					,Surname varchar(50) 
					,Email varchar(100)
					,BirthDay date 
					,GameQTY tinyint
					)
		as
begin
	--
	insert into @t
	select distinct c.ID
		  ,c.FirstName
		  ,c.Surname
		  ,c.Email
		  ,c.BirthDay
		  ,(select count(*)
			from games.SoldGames sgg
			where sgg.ClientID = c.ID) QTY
	from games.SoldGames sg
	join games.Clients c
	on c.ID = sg.ClientID
	where games.GetAge(c.BirthDay) = @agerange
	return
	--
end
--
select *
from games.AgeRange(38)