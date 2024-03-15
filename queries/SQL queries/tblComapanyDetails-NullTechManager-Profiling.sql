select RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'Company Technical Manager Must Be Populated' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select [CompanyID], 1 TargetVal from [ds].[tblCompanyDetails]) Targ
		Left join
		(select [CompanyID], [TechManagerID],
					case when [TechManagerID] is null
					then 0
					else 1
					end as Actual

		from [ds].[tblCompanyDetails]
		group by [CompanyID], [TechManagerID]) Act
		on targ.[CompanyID] = act.[CompanyID]
	) tbl
group by RuleName






