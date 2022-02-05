import re

def alphanumeric(password):   
    return len(password) != 0 and len(re.sub('[\dA-Za-z]*',repl='',string=password)) == 0