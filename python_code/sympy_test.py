import sympy as sp

x = sp.symbols('x')
f = x**2 + 3*x + 2

def main():
    f_prime = sp.diff(f, x)
    print(f_prime)  # 결과: 2*x + 3
    print(f_prime.subs(x, 2))  # 결과: 7

if __name__ == '__main__':
    main()    