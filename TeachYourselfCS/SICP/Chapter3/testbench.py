class Connector:
    def __init__(self):
        self.value = False
        self.informant = False
        self.constraints = []

    def has_value(self):
        if self.value:
            return True
        else:
            return False

    def get_value(self):
        return self.value
    def set_value(self,value,setter):
        if not self.informant:
            self.value = value
            self.informant = setter    
            for_each_except(setter,
                            inform_about_value,
                            self.constraints)
        elif self.value != value:
            msg = "Contradiction: cannot set value to connector that has value"
            ValueError(msg,[self.value,value])
        else:
            print("ignore")
    def forget_value(self,retractor):
        if retractor == self.informant:
            self.value = False
            self.informant = False
            for_each_except(retractor,
                            inform_about_no_value,
                            self.constraints)
        else:
            print("ignored")

    def connect(self,constraint):
        if constraint not in self.constraints:
            self.constraints.append(constraint)
        if self.has_value():
            inform_about_value(constraint)

def for_each_except(exception,proc,items):
    for item in items:
        if item != exception:
            proc(item)

class Constant:
    def __init__(self,value,connector:Connector):
        self.connector = connector.set_value(value, self)

    def process_value(self):
        ValueError("Error Constant cannot take any requests")
        


def constant(value,connector:Connector):
    def me(request):
        ValueError("Unknown request: CONSTANT " + request)
    connector.set_value(value, me)


class Constraint:
    def process_value(self):...
    def forget_value(self):...

def inform_about_value(constraint:Constraint):
    constraint.process_value()
def inform_about_no_value(constraint:Constraint):
    constraint.forget_value()


class Adder(Constraint):
    def __init__(self,a1:Connector,a2:Connector,sum:Connector):
        self.a1 = a1
        self.a2 = a2
        self.sum = sum
        
        self.a1.connect(self)
        self.a2.connect(self)
        self.sum.connect(self)

    def process_value(self):
        a1 = self.a1
        a2 = self.a2
        sum = self.sum
        if a1.has_value() and a2.has_value():
            new_val = a1.get_value() + a2.get_value()
            sum.set_value(new_val,self)
        elif a1.has_value() and sum.has_value():
            new_val = sum.get_value() + a1.get_value()
            a2.set_value(new_val,self)
        elif a2.has_value() and sum.has_value():
            new_val = sum.get_value() + a2.get_value()
            a1.set_value(new_val,self)

    def forget_value(self):
        self.a1.forget_value(self)
        self.a2.forget_value(self)
        self.sum.forget_value(self)
        self.process_value()

if __name__ == "__main__":
    a1 = Connector()
    a2 = Connector()
    sum = Connector()

    adder = Adder(a1,a2,sum)

    constant1 = Constant(1,a1)
    constant2 = Constant(2,a2)


    

