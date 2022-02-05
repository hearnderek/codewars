class BraceIndex:
    def __init__(self, start, end):
        self.start = start
        self.end = end

def match_braces(s):
    matches = []
    progress = [] 
    for i,c in enumerate(s):
        if c == '[':
            progress.append(i)
        elif c == ']':
            matches.append( (progress.pop(),i) )
    return matches
        

class bfsm:
    
    def __init__(self):
        self.data = [0]
        self.output = []
        self.input = ''
        self.find_match = {}

        self.ip = 0 
        self.cp = 0 
        self.dp = 0 
        self.cmds = {
            '>': self.pinc,
            '<': self.pdec,
            '+': self.inc,
            '-': self.dec,
            '.': self.out,
            ',': self.read,
            '[': self.jmp1,
            ']': self.jmp2
        }
        
      
    def run(self, code, input):
        code_len = len(code)
        self.input = input
        braces = match_braces(code)
        fo = dict(braces)
        fc = dict([(y,x) for (x,y) in braces])
        self.find_match = {**fo, **fc}

        while self.cp < code_len:
            self.cmds[code[self.cp]]()
            self.cp+=1
        return ''.join([chr(x%256) for x in self.output]) 
      
    def pinc(self):
        self.dp+=1
        if len(self.data)==self.dp:
            self.data.append(0)

    def pdec(self):
        self.dp-=1

    def inc(self):
        self.data[self.dp]+=1

    def dec(self):
        self.data[self.dp]-=1

    def out(self):
        self.output.append(self.data[self.dp])

    def read(self):
        self.data[self.dp]=ord(self.input[self.ip])
        self.ip+=1

    def jmp1(self):
        if self.data[self.dp]%256==0:
            self.cp=self.find_match[self.cp]

    def jmp2(self):
        if self.data[self.dp]%256!=0:
            self.cp=self.find_match[self.cp]

def brain_luck(code, input):
    return bfsm().run(code, input)