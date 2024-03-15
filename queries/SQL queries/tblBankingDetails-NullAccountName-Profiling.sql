select RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'Banking Particulars Must Be Complete (AccountName) from ds.tblBankingDetails' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select [BankDetailsID], 1 TargetVal from [ds].[tblBankingDetails]) Targ
		Left join
		(select [BankDetailsID], [AccountName],
					case when [AccountName] is null	
					then 0
					else 1
					end as Actual

		from [ds].[tblBankingDetails]
		group by [BankDetailsID], [AccountName]) Act
		on targ.[BankDetailsID] = act.[BankDetailsID]
	) tbl
group by RuleName



