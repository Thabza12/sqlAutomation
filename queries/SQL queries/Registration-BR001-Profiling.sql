select RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'The Registration application should be cancelled after two unsuccessful attempts of Technical Assessments tests' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select [CompanyTestResultsID], 1 TargetVal from [ds].[tblCompanyTestResults]) Targ
		Left join
		(select [CompanyTestResultsID], [NoOfAttempts],
					case when [NoOfAttempts] >= 2
					then 1
					else 0
					end as Actual

		from [ds].[tblCompanyTestResults]
		group by [CompanyTestResultsID], [NoOfAttempts]) Act
		on targ.[CompanyTestResultsID] = act.[CompanyTestResultsID]
	) tbl
group by RuleName 