 --Create Database
 create database SkillWill
 -- Create Table
 use SkillWill
 create table dbo.SkillWillHW1( ID int primary key
                                ,First_Name nvarchar(20)
							    ,LastName nvarchar(50)
							    ,age int)

--Insert Into
insert into dbo.SkillWillHW1
values (1,N'გრიგოლ', N'თანიაშვილი', 30)
		,(2,N'გიორგი', N'თანიაშვილი', 23)
		,(3,N'მარიამ', N'თანიაშვილი', 55)
		,(4,N'ანა', N'თანიაშვილი', 21)

-- Select
select *
from dbo.SkillWillHW1
where ID in (2,4)
-- Update
update a
set a.age = 100
from dbo.SkillWillHW1 a 
where ID = 1
--Delete
delete from dbo.SkillWillHW1
where ID not in (2,4)