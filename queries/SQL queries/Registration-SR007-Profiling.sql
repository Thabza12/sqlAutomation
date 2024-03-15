select RuleNo, RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'SR007' as RuleNo, 'The system must not display the following information when Sole Trader/Partnership is selected as the entity type:
Company details:
I.	CIPC Reg number
II.	Company name
III.	Trading name
IV.	Trading start date
' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select [CompanyID], 1 TargetVal from [ds].[tblCompanyDetails]) Targ
		Left join
		(select [CompanyID],
					case when [CIPCRegNo] is null	
						and [CompanyName] is null
						and [TradingName] is null
					then 1
					else 0
					end as Actual

		from [ds].[tblCompanyDetails] ) Act
		on targ.[CompanyID] = Act.[CompanyID]
	) SR007
group by RuleNo, RuleName


