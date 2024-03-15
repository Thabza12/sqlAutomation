
select RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'The number of null phone numbers from ds.AspNetUser' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select Id, 1 TargetVal from [ds].[AspNetUsers]) Targ
		Left join
		(select Id, PhoneNumber,
					case when PhoneNumber is null	
					then 0
					else 1
					end as Actual

		from [ds].[AspNetUsers]
		group by Id, PhoneNumber) Act
		on targ.Id = act.Id
	) tbl
group by RuleName
