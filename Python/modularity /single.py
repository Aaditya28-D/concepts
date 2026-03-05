def add(a,b): return a+b
def sub(a,b): return a-b
def mul(a,b): return a*b
def div(a,b): return a/b if b!=0 else "error divide by zero"

def printing():
    print("10+5=", add(10, 5))
    print("10-5", sub(10, 5))
    print("10*5=", mul(10, 5))
    print("10/0=", div(10,0))

if __name__=="__main__":
    printing()
