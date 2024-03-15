
select RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'The number of two factor enabled from ds.AspNetUser' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select TwoFactorEnabled, 1 TargetVal from [ds].[AspNetUsers]) Targ
		Left join
		(select TwoFactorEnabled,
					case when TwoFactorEnabled = 1	
					then 1
					else 0
					end as Actual

		from [ds].[AspNetUsers]
		group by TwoFactorEnabled) Act
		on targ.TwoFactorEnabled = act.TwoFactorEnabled
	) tbl
group by RuleName


