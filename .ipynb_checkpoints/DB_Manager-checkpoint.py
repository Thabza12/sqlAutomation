import pymssql
import csv

class DB:
    
    def __init__(self):
        
        self.conn = pymssql.connect(
            server='sapmetadata.database.windows.net',
            user='PWSanele',
            password='Sanele12345',
            database='sapmetadata',
            as_dict=True
        )
        
    def execute(self, query):
        cursor = self.conn.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        return results
        # records = []
        # for statement in self.queries:
        #     # query = f'"""\n{statement}\n"""'
        #     query = statement
        #     # print(query)
        #     cursor.execute(query)
        #     results = cursor.fetchall()
        #     print(results)
        #     records.append(results)
        # return records
        