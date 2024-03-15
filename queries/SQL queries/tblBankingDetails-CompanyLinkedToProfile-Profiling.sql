select RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'Company Details Must Link To a Profile' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select [CompanyID], 1 TargetVal from [ds].[tblCompanyDetails]) Targ
		Left join
		(select [CompanyID], [ProfileID],
					case when [ProfileID] is null
					then 0
					else 1
					end as Actual

		from [ds].[tblCompanyDetails]
		group by [CompanyID], [ProfileID]) Act
		on targ.[CompanyID] = act.[CompanyID]
	) tbl
group by RuleName






