use Practice
go

with GroupGames as
(
select 
	*,
	NTILE(20) OVER(order by Number) GroupNumber
from
	game
)

select 
	SUM(Raquet) as SumRequet,
	GroupNumber
from
	GroupGames
group by
	GroupNumber
order by GroupNumber

