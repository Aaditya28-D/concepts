def c_to_f(c):
    return (c*9/5)+32

def f_to_c(f):
    return (f-32)*5/9

def main():
    print(c_to_f(0), "F")
    print(c_to_f(100), "F")
    print(f_to_c(98.6),"C")

if __name__=="__main__":
    main()