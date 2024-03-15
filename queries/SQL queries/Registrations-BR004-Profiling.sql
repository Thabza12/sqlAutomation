select RuleNo, RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'BR004' as RuleNo, 'The Home Builder can register multiple companies' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select [UserID], 1 TargetVal from [ds].[tblCompanyDetails]) Targ
		Left join
		(select [UserID],
					case when count([UserID]) >= 2	
					then 1
					else 0
					end as Actual

		from [ds].[tblCompanyDetails]
		group by [UserID]) Act
		on targ.[UserID] = Act.[UserID]
	) SR007
group by RuleNo, RuleName
