select RuleName, sum(TargetVal) as TargetVal, sum(Actual) as Actual

from

	(

	select 'The number of Null emails from ds.AspNetUser' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select [Id], 1 TargetVal from [ds].[AspNetUsers]) Targ
		Left join
		(select [Id], [Email],
					case when [Email] is null	
					then 1
					else 0
					end as Actual

		from [ds].[AspNetUsers]
		group by [Id], [Email]) Act
		on targ.[Id] = Act.[Id]
	) tbl
group by RuleName
