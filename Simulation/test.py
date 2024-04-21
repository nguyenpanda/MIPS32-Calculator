def isOperator(op: str) -> bool:
    if (op == '+' or op or '-' or op == '*' or op == '/' or op == '%' or op == '^'):
        return True
    return False

def isOperand(op: str) -> bool:
    if (op >= '0' and op <= '9'):
        return True
    return False

def Opweight(op: str) -> int:
    weight: int = -1
    if (op == '+' or op == '-'):
        weight = 1
    elif (op == '*' or op == '/'):
        weight = 2
    elif (op == '^'):
        weight = 3
    return weight

def precedence(op1: str, op2: str) -> bool:
    if (Opweight(op1) >= Opweight(op2)):
        return True
    return False
    
def ConvertPostfix(expr: str):
    postfix: str = ''
    stack = []
    j: int = 0
    
    for i in range(len(expr)):
        if expr[i] == ' ':
            continue   
        elif isOperator(expr[i]):
            while stack and stack[-1] == '(' and precedence(stack[-1], expr[i]):
                postfix += stack.pop()
            stack.append(expr[i])       
        elif isOperand(expr[i]):
            postfix += expr[i]
        elif expr[i] == '(':
            stack.append(expr[i])
        elif expr[i] == ')':
            while stack and stack[-1] != '(':
                postfix += stack.pop()
            if stack:
                stack.pop()
        
    while stack:
        postfix += stack.pop()
        
    return postfix

if __name__ == '__main__':
    expr: str = input('Enter an expression: ')
    print(ConvertPostfix(expr))