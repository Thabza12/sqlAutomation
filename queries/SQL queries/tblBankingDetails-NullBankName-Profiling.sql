select RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'Banking Particulars Must Be Complete (BankName) from ds.tblBankingDetails' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select [BankDetailsID], 1 TargetVal from [ds].[tblBankingDetails]) Targ
		Left join
		(select [BankDetailsID], [BankName],
					case when [BankName] is null	
					then 0
					else 1
					end as Actual

		from [ds].[tblBankingDetails]
		group by [BankDetailsID], [BankName]) Act
		on targ.[BankDetailsID] = act.[BankDetailsID]
	) tbl
group by RuleName