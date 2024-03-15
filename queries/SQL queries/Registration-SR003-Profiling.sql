select RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'The system must auto-generate the Registration invoice number in sequential order' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select [InvoiveID], 1 TargetVal from [ds].[tblInvoice]) Targ
		Left join
		(select [InvoiveID], [InvoiveNo],
					case when [InvoiveNo] = LAG([InvoiveNo]) over (order by [InvoiveNo]) + 1
					then 1
					else 0
					end as Actual

		from [ds].[tblInvoice]
		group by [InvoiveID], [InvoiveNo]) Act
		on targ.[InvoiveID] = act.[InvoiveID]
	) tbl
group by RuleName