from ops import add, sub, mul, div

def main():
    print("10+5=", add(10,5))
    print("10-5", sub(10,5))
    print("10*5=", mul(10,5))
    print("10/0=", div(10,0))

if __name__=="__main__" :
    main()