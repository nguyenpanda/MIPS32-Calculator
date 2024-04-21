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

def infixToPostfix(string: str, M: int):
    if len(string) == 0 or len(string) > 100:
        raise ValueError('Invalid length expression, got length', len(string))
    
    stack: list = []
    result: str = ''
    
    for char in string:
        if (isOperand(char)):
            result += char
        elif char == 'M':
            result += str(M)
        elif char == ' ':
            continue
        elif char == '(':
            stack.append(char)
        elif char == ')':
            while stack and stack[-1] != '(':
                result += ' '
                result += stack.pop()
            if stack and stack[-1] == '(':
                stack.pop()
        elif isOperator(char):
            if (char == '-' 
                and (not result or result[-1] in ('(', ' ', '*', '/', '^'))
                and (not stack or stack[-1] in ('(', ' ', '*', '/', '^'))):
                result += '-'
                print(f'{char}| ', stack, '', f'|{result}|')
                continue
            
            if char == '!':
                result += ' !'
                print(f'{char}| ', stack, '', f'|{result}|')
                continue
            
            while (stack 
                   and stack[-1] != '(' 
                   and precedence(stack[-1]) >= precedence(char)):
                result += ' '
                result += stack.pop()
            stack.append(char)
            result += ' '
        else:
            raise Exception('Invalid character')
        
        print(f'{char}| ', stack, '', f'|{result}|')
                
    while stack:
        result += ' '
        result += stack.pop()
        
    return result

def evaluate_postfix(expression: str, M: int):
    stack = []
    number = ''

    for char in expression:
        print(f'|{char}| ', stack, '', f'|{number}|')
        if char.isdigit() or char == '.' or (char == '-' and len(stack) != 2):
            number += char
        elif char == 'M':
            number += str(M)
        elif char == ' ':
            if number:
                print(f'\t|{char}| ', stack, '', f'|{number}|')
                
                if number == '-':
                    operand2 = stack.pop()
                    operand1 = stack.pop()
                    stack.append(operand1 - operand2)
                    number = ''
                
                else:
                    stack.append(float(number))
                    number = ''
        else:
            if number:
                print(f'\t|{char}| ', stack, '', f'|{number}|')
                stack.append(float(number))
                number = ''

            if char == '+':
                operand2 = stack.pop()
                operand1 = stack.pop()
                stack.append(operand1 + operand2)
            elif char == '-':
                operand2 = stack.pop()
                operand1 = stack.pop()
                stack.append(operand1 - operand2)
            elif char == '*':
                operand2 = stack.pop()
                operand1 = stack.pop()
                stack.append(operand1 * operand2)
            elif char == '/':
                operand2 = stack.pop()
                operand1 = stack.pop()
                stack.append(operand1 / operand2)
            elif char == '!':
                operand = stack.pop()
                stack.append(fact(operand))
            elif char == '^':
                operand2 = stack.pop()
                operand1 = stack.pop()
                stack.append(operand1 ** operand2)
            else:
                raise ValueError("Invalid token in expression")

    if number:
        print(f'\t->|{char}| ', stack, '', f'|{number}|')
        # if number != '-':
        stack.append(float(number))

    if len(stack) != 1:
        raise ValueError("Invalid postfix expression")
    
    return stack[0]

if __name__ == '__main__':
    M = 10
    while True:
        try:
            __input: str = input('\033[1;93mEnter the expression: \033[0m')
            
            __input: str = infixToPostfix(__input, M)
            print('\033[1;93mPostfix:\033[0m', __input)
            
            __input: str = evaluate_postfix(__input, M)
            print('\033[1;93mResult:\033[0m', __input)
        except Exception as e:
            print(f'\033[1;91m{e}\033[0m')
            
    print('\n\033[1;94mEvaluating the postfix expression...\n\033[0m')