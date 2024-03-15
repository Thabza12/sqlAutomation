select RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'Profiles with No ID\Passport' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select [ProfileID], 1 TargetVal from [ds].[tblProfile]) Targ
		Left join
		(select [ProfileID], [IDNo], [PassportNo],
					case when [IDNo] is null
					and [PassportNo] is null
					then 1
					else 0
					end as Actual

		from [ds].[tblProfile]
		group by [ProfileID], [IDNo], [PassportNo]) Act
		on targ.[ProfileID] = act.[ProfileID]
	) tbl
group by RuleName






