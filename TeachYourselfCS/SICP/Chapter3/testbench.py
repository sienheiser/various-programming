class Stream:
    def __init__(self,a,b):
        self.head = a
        self.tail = lambda:b
    def next(self):
        return self.tail()
    def __repr__(self):
        return f'''Stream<{self.head},{self.tail}>'''

def delay(exp):
    import pdb
    pdb.set_trace()
    return lambda:exp

def force(delayed_obj):
    return delayed_obj()

def enumerate_interval(i:int,j:int)->Stream:
    import pdb
    pdb.set_trace()
    if i > j:
        return Stream(None,None)
    else:
        return Stream(i,enumerate_interval(i+1,j))
    
s = enumerate_interval(1,5)