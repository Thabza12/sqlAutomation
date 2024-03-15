
select RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'The number of confirmed phone numbers from ds.AspNetUser' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select PhoneNumberConfirmed, 1 TargetVal from [ds].[AspNetUsers]) Targ
		Left join
		(select PhoneNumberConfirmed,
					case when PhoneNumberConfirmed = 1	
					then 1
					else 0
					end as Actual

		from [ds].[AspNetUsers]
		group by PhoneNumberConfirmed) Act
		on targ.PhoneNumberConfirmed = act.PhoneNumberConfirmed
	) tbl
group by RuleName


