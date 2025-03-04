# Return    $f0 - $f3   |   4s/2d
# Temporary $f4 - $f11  |   8s/4d
# Argument  $f12 - $f15 |   4s/2d
# Temporary $f16 - $f19 |   4s/2d
# Constant  $f24 - $f31 |   8s/4d

import csv

def compare_float(x, y):
    return abs(x - y) < 1e-6

def print_info(char, num_buffer, stack, optional=None):
    if optional:
        print(optional)
    print('\033[1;92m----------------------------\033[0m')
    print(f'Getting info for: \033[1;93m{char}\033[0m')
    print('\t->Num buffer:', num_buffer)
    print('\t->Stack:', stack)
    
def print_info_(char, num_buffer, stack, optional=None):
    if optional:
        print(optional)
    print('\t---')
    print('\t->Num buffer:', num_buffer)
    print('\t->Stack:', stack)

def fact(n: int) -> int:
    if n < 0:
        raise ValueError(f'Factorial of negative number is undefined, got n {n}')
    return 1 if n == 0 else n * fact(n - 1)

def isOperand(char: str) -> bool:
    return char.isdigit() or char == '.' or char == 'M'

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
            if char == '!':
                result += ' !'
                continue
            
            if (char == '-' 
                and (not result or result[-1] in ('(', ' ', '*', '/', '^'))
                and (not stack or stack[-1] in ('(', ' ', '*', '/', '^'))
                ):
                result += char
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

    while stack:
        result += ' '
        result += stack.pop()
        
    return result

def evaluate_postfix(expression: str, M: int):
    stack: list[float] = []
    number: str = ''

    for char in expression:
        if char == 'M': number += str(M)
        elif isOperand(char) or (char == '-' and len(stack) < 2): number += char
        elif char == ' ':
            if number:
                if number == '-':
                    stack.append(stack.pop() - operand2)
                    number = ''
                else:
                    stack.append(float(number))
                    number = ''
        else:
            if number:
                stack.append(float(number))
                number = ''

            operand2 = stack.pop()
            if char == '+':
                stack.append(stack.pop() + operand2)
            elif char == '-':
                stack.append(stack.pop() - operand2)
            elif char == '*':
                stack.append(stack.pop() * operand2)
            elif char == '/':
                stack.append(stack.pop() / operand2)
            elif char == '!':
                stack.append(fact(int(operand2)))
            elif char == '^':
                stack.append(stack.pop() ** int(operand2))
            else:
                raise ValueError("Invalid token in expression")
    
    if number:
        stack.append(float(number))

    if len(stack) != 1:
        raise ValueError('Invalid postfix expression')
    
    return stack[0]

def test_csv(filename, output):
    fields = []
    rows = []
    case: int = 0
    true_case: int = 0
    false_case: int = 0

    with open(filename, 'r') as csvfile:
        csvreader = csv.reader(csvfile)
        fields = next(csvreader)
        for row in csvreader:
            rows.append(row)
            case += 1
    
    with open(output, 'w') as test_csv:
        test_csv.write(f'id,bool_value,bool_postfix,got_value,except_value,got_postfix,expected_postfix\n')
        for i, row in enumerate(rows):
            try:
                __postfix: str = infixToPostfix(row[2], row[0])
                print('\n\n\033[1;93mPostfix:\033[0m', __postfix)

                __result = evaluate_postfix(__postfix, row[0])
                print('\n\033[1;94mEvaluating the postfix expression...\n\033[0m')

                __result_bool = compare_float(__result, float(row[1]))
                test_csv.write(f'{i},{__result_bool},{str(__postfix) == str(row[3])},{__result},{row[1]},{__postfix},{row[3]}\n')

                if __result_bool: true_case += 1
                else: false_case += 1
            except Exception as e:
                false_case += 1
                print(f'\033[1;91m{e}\033[0m')
                test_csv.write(f'{i},{False},{str(__postfix) == str(row[3])},{e},{row[1]},{__postfix},{row[3]}\n')

    if false_case == 0: print(f'\033[1;92mAll cases are correct in {case} test cases\033[0m')
    else: print(f'\033[1;91m{false_case} case are wrong in {case} test cases\033[0m')

if __name__ == '__main__':
    test_csv('main_tc.csv', 'result_tc.csv')
    