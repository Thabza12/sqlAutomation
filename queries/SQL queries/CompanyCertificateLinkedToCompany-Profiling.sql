select RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select 'Every Company Certificate Must Link to a Company Profile' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		
		(select [CertificateID], 1 TargetVal from [ds].[tblCertificate]) Targ
		Left join
		(select [CertificateID], [CompanyID],
					case when [CompanyID] is null
					then 0
					else 1
					end as Actual

		from [ds].[tblCertificate]
		group by [CertificateID], [CompanyID]) Act
		on targ.[CertificateID] = act.[CertificateID]
	) tbl
group by RuleName

