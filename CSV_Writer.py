import csv

class CSV:
    
    def __init__(self):
        headers = ['RuleName', 'TargetVal', 'Actual']
        with open('BusinessRules2.csv', 'a', encoding='UTF8', newline='') as f:
            writer = csv.writer(f)
            writer.writerow(headers)
    
    def write(self, r):
        with open('BusinessRules2.csv', 'a', encoding='UTF8', newline='') as f:
            writer = csv.writer(f)
            # print(f"{r['RuleName']}\t{r['TargetVal']}\t{r['Actual']}")
            data = [r['RuleName'], r['TargetVal'], r['Actual']]
            writer.writerow(data)
            print(f'Following records have been appended: {data}')