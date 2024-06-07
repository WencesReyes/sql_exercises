use Practice
go

with RowNumbers as
(
	select
		ROW_NUMBER() over(order by (select null)) RowNumber
	from
		sys.columns
)

insert into 
	Game
select 
	RowNumber,
	CEILING(RAND(CHECKSUM(NEWID())) * 6)
from 
	RowNumbers
where 
	RowNumber <= 120 

select
	*
from 
	Game


