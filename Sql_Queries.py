from pathlib import Path

class queries:
    
    def __init__(self, source_folder):
        self.file_path = source_folder
    
    def processQueries(self):
        queries = []
        for file_name in Path(self.file_path).glob('*.sql'):
            # print(f'{file_name}')
            query = ""
            with open(file_name, 'r') as f:
                # lines = f.read()
                # lines = lines.splitlines()
                # print(lines)
                # lin_arr = []
                for line in f:
                    query += line.strip() + " "
                    # l = (f'"""{}"""'.format(line))
                    # lin_arr.append(line)
                    # print(l)
                    # print("""{}""".format(line))
            queries.append(query)
        return queries
            
            
        
        
        
        