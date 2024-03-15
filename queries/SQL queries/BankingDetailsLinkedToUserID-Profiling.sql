select RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'All Banking Details Must Link to a UserID' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select [BankDetailsID], 1 TargetVal from [ds].[tblBankingDetails]) Targ
		Left join
		(select [BankDetailsID], [UserID],
					case when [UserID] is null
					then 0
					else 1
					end as Actual

		from [ds].[tblBankingDetails]
		group by [BankDetailsID], [UserID]) Act
		on targ.[BankDetailsID] = act.[BankDetailsID]
	) tbl
group by RuleName






