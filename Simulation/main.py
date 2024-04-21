def isOperand(char: str) -> bool:
    return char.isdigit()

def factorial(n: int) -> int:
    return 1 if n == 0 else n * factorial(n - 1)

def isOperator(char: str) -> bool:
    return char in ('+', '-', '*', '/', '^', '!')

def precedence(char: str) -> int:
    if char == '+' or char == '-': return 1
    if char == '*' or char == '/': return 2
    if char == '^': return 3
    if char == '!': return 4
    return -1

def isBinaryOpt(char: str) -> bool:
    return char in ('+', '-', '*', '/', '^')

def infixToPostfix(string: str, M: int):
    stack: list = []
    result: str = ''
    
    for char in string:
        if (isOperand(char) or char == '.'):
            result += char
        elif char == 'M':
            result += str(M)
        elif char == ' ':
            continue
        elif char == '(':
            stack.append(char)
        elif char == ')':
            while len(stack) != 0 and stack[-1] != '(':
                result += ' '
                result += stack.pop()
            if len(stack) != 0 and stack[-1] == '(':
                stack.pop()
        elif isOperator(char):
            if (char == '-' 
                and (len(stack) == 0 or stack[-1] == '(') 
                and not (len(result) != 0 and isOperand(result[-1]))):
                if len(result) == 0:
                    result += '-'
                print(f'{char}| ', stack, '', f'|{result}|')
                continue
            if char == '!':
                result += ' !'
                print(f'{char}| ', stack, '', f'|{result}|')
                continue
        
            while (stack
                   and precedence(char) <= precedence(stack[-1])
                   and (isBinaryOpt(char) or precedence(char) < precedence(stack[-1]))):
                result += ' '
                result += stack.pop()
            stack.append(char)
            result += ' '
        else:
            raise Exception('Invalid character')
        
        print(f'{char}| ', stack, '', f'|{result}|')
                
    while len(stack) != 0:
        result += ' '
        result += stack.pop()
    
    return result # (-4+1)*-8 # ((-10.2-3)*8-2/7)*2-M!*2^7)*(-1)
    # (-1)*((-4+3))-3+10*10

def infixToPostfix_1(string: str, M: int):
    stack: list = []
    result: str = ''
    
    for char in string:
        if (isOperand(char) or char == '.'):
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
    
def infixToPostfix_(string: str, M: int):
    stack = []
    result = ''
    is_prev_operand = False  # Flag to keep track of previous character
    
    for char in string:
        print(stack, '|', result)
        if isOperand(char) or char == '.':
            if not is_prev_operand and len(result) > 0:
                result += ' '
            result += char
            is_prev_operand = True
        elif char == 'M':
            if not is_prev_operand and len(result) > 0:
                result += ' '
            result += str(M)
            is_prev_operand = True
        elif char == ' ':
            is_prev_operand = False
            continue
        elif char == '(':
            stack.append(char)
            is_prev_operand = False
        elif char == ')':
            while stack and stack[-1] != '(':
                result += ' ' + stack.pop()
            is_prev_operand = False
            stack.pop()
        elif isOperator(char):
            if char == '-' and (not is_prev_operand or (result and result[-1] in ('(', ' '))):
                result += ' '
                result += char
                is_prev_operand = True
                continue
            while stack != 0 and precedence(char) <= precedence(stack[-1]):
                result += ' ' + stack.pop()
            stack.append(char)
            is_prev_operand = False
        else:
            raise Exception('Invalid character')
    
    while stack:
        if stack[-1] == '(':
            stack.pop()
        else: 
            result += ' ' + stack.pop()
    
    return result.strip()  # ((-10.2-3)*8-2/7)*2-M!*2^7)*(-1)
    # (-1)*((-4+3))-3+10*10

def binaryOperator(operand1: str, operand2: str, op: str) -> float:
    operand1 = float(operand1)
    operand2 = float(operand2)
    if op == '+': return operand1 + operand2
    if op == '-': return operand1 - operand2
    if op == '*': return operand1 * operand2
    if op == '/': 
        if operand2 == 0: raise ZeroDivisionError('Division by zero')
        return operand1 / operand2
    if op == '^': return operand1 ** operand2

def unaryOperator(operand: str, op: str) -> int:
    operand = float(operand)
    if op == '!': return factorial(int(operand))
    
def evaluatePostfix(string: str) -> float:
    stack: list = []
    
    for char in string:
        print(stack, '|', string)
        if isOperand(char):
            stack.append(char)
        elif char == ' ':
            continue
        elif isOperator(char):
            if char == '-':
                stack.append(char)
                
            if isBinaryOpt(char):
                operand2 = stack.pop()
                operand1 = stack.pop()
                result = binaryOperator(operand1, operand2, char)
                stack.append(result)
            else:
                operand = stack.pop()
                result = unaryOperator(operand, char)
                stack.append(result)
        else:
            raise Exception('Invalid character')
        
    return stack.pop()

if __name__ == '__main__':
    
    while True:
        f = infixToPostfix_1
        
        print(f'Function: \033[1;92m{f.__name__}\033[0m')
        __input: str = input('Enter the expression: ')
        
        __postfix: str = f(__input, 999)
        print('Postfix:', __postfix)
        
        print('\n\033[1;94mEvaluating the postfix expression...\n\033[0m')
    
    # print('\n\n\033[1;92mEvaluating the postfix expression...\n\n\033[0m')
    
    # __result: str = evaluatePostfix(__postfix)
    # print('Result:', __result)
    
    
    