drop table if exists #test
--
create table #test ( 
					id int identity(1,1) primary key
					,num bigint
					)
--
declare @i int = 0, @stime datetime, @etime datetime
--
while @i < 10000000
begin
	insert into #test (num) values (@i)
	set @i += 1
end
--
set @stime = GETDATE()
--
select num
from #test
where num %5 = 1
--
set @etime = GETDATE()
--
select datediff(SS,@stime,@etime)
--
create index i_num on #test (num)
--
set @stime = GETDATE()
--
select num
from #test
where num %5 = 1
set @etime = GETDATE()
--
select datediff(ss,@stime,@etime)
