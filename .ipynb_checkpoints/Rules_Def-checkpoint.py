
class rule:
    
    def __init__(self, ruleName, stype):
        self.ruleName = ruleName
        self.stype = stype


class ruleMgr:
    
    def __init__(self):
        self.rules = []
    
    def add(self):
        r = rule("first case test", "Null Tester")
        r.sql = """(select [BankDetailsID], 1 TargetVal from [ds].[tblBankingDetails]) Targ
		Left join
		(select [BankDetailsID], [AccountName],
					case when [AccountName] is null	
					then 0
					else 1
					end as Actual

		from [ds].[tblBankingDetails]
		group by [BankDetailsID], [AccountName]) Act
		on targ.[BankDetailsID] = act.[BankDetailsID]
	) tbl"""
        
        self.rules.append(r)



    def getFullRule(self,ruleName, innerRule):
        
        fullRule = """
        select RuleName, sum(TargetVal) as TargetVal, sum(Actual) Actual

from

	(

	select '{}' RuleName,

		Targ.TargetVal, Act.Actual		


	from
		{}
		
group by RuleName""".format(ruleName, innerRule)
        
        return fullRule