
select RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'The number of confirmed emails from ds.AspNetUser' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select [Email], 1 TargetVal from [ds].[AspNetUsers]) Targ
		Left join
		(select [Email], [EmailConfirmed],
					case when [EmailConfirmed] = 1	
					then 1
					else 0
					end as Actual

		from [ds].[AspNetUsers]
		group by [Email], [EmailConfirmed]) Act
		on targ.[Email] = act.[Email]
	) tbl
group by RuleName
