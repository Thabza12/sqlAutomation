from pathlib import Path
import re


class rule:
    
    def __init__(self, ruleName, stype):
        self.ruleName = ruleName
        self.stype = stype


class ruleMgr:
    
    def __init__(self, filePath):
        self.rules = []
        self.filePath = filePath
    
    def add(self):
        # r = rule("first case test", "Null Tester")
        businessRules = []
        for file_name in Path(self.filePath).glob('*.txt'):
            lines = ""
            with open(file_name, 'r') as f:
                for line in f:
                    lines += line.strip() + " "
            ruleName = re.findall(r'"(.*?)"', lines)
            ruleName = ruleName[0]
            # print(ruleName)
            query = lines.replace(f'"{ruleName}"', '')
            query = query.replace(',', '', 1)
            # print(query)
            businessRules.append([ruleName, query])
        return businessRules
#         r.sql = """(select [BankDetailsID], 1 TargetVal from [ds].[tblBankingDetails]) Targ
# 		Left join
# 		(select [BankDetailsID], [AccountName],
# 					case when [AccountName] is null	
# 					then 0
# 					else 1
# 					end as Actual

# 		from [ds].[tblBankingDetails]
# 		group by [BankDetailsID], [AccountName]) Act
# 		on targ.[BankDetailsID] = act.[BankDetailsID]
# 	) tbl"""
        
#         self.rules.append(r)
        


    def getFullRule(self, ruleName, innerRule):
        
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
                      

                      

class nullTester:
    
    def __init__(self, file):
        self.rules = []
        self.file = file
        
        
    def docReader(self):        
        attributes = []
        lines = ""
        with open(self.file, 'r') as f:
            for line in f:
                lines += line.strip() + " "
        ruleName = re.findall(r'"(.*?)"', lines)
        ruleName = ruleName[0]
        fieldNames = lines.replace(f'"{ruleName}"', '')
        fieldNames = fieldNames.replace(',', '', 1)
        attributes.append([ruleName, fieldNames])
        return attributes
        # ruleName = re.findall(r'"(.*?)"', lines)
        # ruleName = ruleName[0]
        # # print(ruleName)
        # query = lines.replace(f'"{ruleName}"', '')
        # query = query.replace(',', '', 1)
        # # print(query)
        # businessRules.append([ruleName, query])
        
    
    

    def ruleBuilder(self, tableName, columnName1, columnName2):
        innerRule = """
        (select columnName1, 1 TargetVal from tableName) Targ
 		Left join
 		(select columnName1, columnName2,
 					case when columnName2 is null	
 					then 0
 					else 1
 					end as Actual

 		from tableName
 		group by columnName1, columnName2) Act
 		on targ.columnName1 = act.columnName1
 	) tbl"""
        innerRule = innerRule.replace('columnName1', f'{columnName1}')
        innerRule = innerRule.replace('columnName2', f'{columnName2}')
        innerRule = innerRule.replace('tableName', f'{tableName}')
        
        return innerRule
    
    
    
    def buildFullRule(self, ruleName, innerRule):
        
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