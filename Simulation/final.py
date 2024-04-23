def add(x, y):
    return x + y

def sub(x, y):
    return x - y

def mul(x, y):
    return x * y

def div(x, y):
    return x / y

def fact(n: int) -> int:
    if n < 0:
        raise ValueError(f'Factorial of negative number is undefined, got n {n}')
    return 1 if n == 0 else n * fact(n - 1)

def exp(x, y):
    return x ** y

def isOperand(char: str) -> bool:
    return char.isdigit() or char == '.'

def isOperator(char: str) -> bool:
    return char in ('+', '-', '*', '/', '^', '!')

def precedence(char: str) -> int:
    if char == '+' or char == '-': return 1
    if char == '*' or char == '/': return 2
    if char == '^': return 3
    if char == '!': return 4
    return -1

    
def operate(operand, operator):
    op = operator.pop()
    if op == '!':
        operand.append(fact(operand.pop()))
    else:
        y = operand.pop()
        x = operand.pop()
        if op == '+':
            operand.append(add(x, y))
        elif op == '-':
            operand.append(sub(x, y))
        elif op == '*':
            operand.append(mul(x, y))
        elif op == '/':
            operand.append(div(x, y))
        elif op == '^':
            operand.append(exp(x, y))

def print_info(char, num_buffer, operand, operator, optional=None):
    if optional:
        print(optional)
    print('\033[1;92m----------------------------\033[0m')
    print(f'Getting info for: \033[1;93m{char}\033[0m')
    print('\t->Num buffer:', num_buffer)
    print('\t->Operand:', operand)
    print('\t->Operator:', operator)
    
def print_info_(char, num_buffer, operand, operator, optional=None):
    if optional:
        print(optional)
    print('\t---')
    print('\t->Num buffer:', num_buffer)
    print('\t->Operand:', operand)
    print('\t->Operator:', operator)

def evaluate_infix(exp: str, M: int) -> int:
    if not (0 < len(exp) <= 100):
        raise ValueError('Invalid length expression, got length', len(exp))
    
    operand: list = []
    operator: list = []
    
    num_buffer = ''
    
    for char in exp:
        print_info(char, num_buffer, operand, operator)
        if isOperand(char):
            num_buffer += char
        elif char == 'M':
            operand.append(M)
        elif char == ' ':
            continue
        elif char == '(':
            operator.append(char)
        elif char == ')':
            if num_buffer:
                operand.append(float(num_buffer))
                num_buffer = ''
            while operator and operator[-1] != '(':
                operate(operand, operator)
            if operator and operator[-1] == '(':
                operator.pop()  # Pop the '('
            else:
                raise ValueError('Unmatched closing parenthesis')
        elif isOperator(char):
            if num_buffer:
                operand.append(float(num_buffer))
                num_buffer = ''
                
            if (char == '-' 
                and (not number)
                and (not operator or operator[-1] in ('(', ' ', '*', '/', '^'))
                ):
                num_buffer += '-'
            else:
                while operator and precedence(char) <= precedence(operator[-1]):
                    operate(operand, operator)
                operator.append(char)
        else:
            raise ValueError('Invalid character')
        
        print_info_(char, num_buffer, operand, operator)
    
    if num_buffer:
        operand.append(float(num_buffer))
    
    while operator:
        operate(operand, operator)
    
    return operand.pop()



if __name__ == '__main__':
    M = 10
    while True:
        try:
            __expression = input('\033[1;93mEnter the expression: \033[0m')
            result = evaluate_infix(__expression, 10)  # Assuming M = 10
            print("Result:", result)  # Output: Result: 14
        except Exception as e:
            print(f'\033[1;91m{e}\033[0m')
            
        print('\n\033[1;94mEvaluating the expression...\n\033[0m')
    
    
