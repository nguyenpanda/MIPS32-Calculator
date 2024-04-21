#include <iostream>
#include <stack>

using namespace std;

int factorial(int n) {
    if (n < 0) {
        cerr << "Error: Factorial of a negative number\n";
        return -1;
    }

    int result = 1;
    for (int i = 1; i <= n; i++) {
        result *= i;
    }

    return result;
}

bool isOperator(char c) {
    return (c == '+' || c == '-' || c == '*' || c == '/' || c == '^' || c == '!');
}

bool isLeftAssociative(char op) {
    return (op == '+' || op == '-' || op == '*' || op == '/');
}

int precedence(char op) {
    if (op == '+' || op == '-') return 1;
    else if (op == '*' || op == '/') return 2;
    else if (op == '^') return 3;
    else if (op == '!') return 4;
    else return -1; // Invalid operator
}

string infixToPostfix(const string& infix, int M) {
    stack<char> stack;
    string result;
    
    for (char c : infix) {
        if (isdigit(c) || c == '.') result += c;
        else if (c == 'M') result += to_string(M);
        else if (c == ' ') continue;
        else if (c == '(') stack.push(c);
        else if (c == ')') {
            while (!stack.empty() && stack.top() != '(') {
                result += stack.top();
                stack.pop();
            }
            if (!stack.empty() && stack.top() == '(') {
                stack.pop(); // Pop the '('
            }
        } else if (isOperator(c)) {
            // cout << result << endl;
            if (c == '-' and (stack.empty() || stack.top() == '(') and !isdigit(result[result.size()-1])) {
                if (result.size() == 0) result += '-';
                else result += " -";
                continue;
            }

            while (!stack.empty() 
                && precedence(c) <= precedence(stack.top()) 
                && (isLeftAssociative(c) || precedence(c) < precedence(stack.top()))) {
                result += stack.top();
                stack.pop();
            }
            stack.push(c);
            result += ' ';
        } 
        else throw invalid_argument("Invalid character in infix expression");
    }

    while (!stack.empty()) {
        result += stack.top();
        stack.pop();
    }
    
    return result; // (-4+1)*-8 // ((-10.2-3)*8-2/7)*2-M!*2^7)*(-1)
}

double binaryOperator(double operand1, double operand2, char op) {
    switch(op) {
        case '+':
            return operand1 + operand2;
        case '-':
            return operand1 - operand2;
        case '*':
            return operand1 * operand2;
        case '/':
            if (operand2 != 0)
                return operand1 / operand2;
            else {
                cerr << "Error: Division by zero\n";
                return NAN;
            }
        case '^':
            return pow(operand1, operand2);
        default:
            cerr << "Error: Invalid operator\n";
            return NAN;
    }
}

double evaluatePostfix(const string& result) {
    stack<double> operands;

    for (char c : result) {
        if (isdigit(c) || c == '.') {
            operands.push(c - '0');
        } else if (c == '!') {
            double operand = operands.top();
            operands.pop();
            operands.push(factorial(operand));
        } else if (isOperator(c)) {
            double operand2 = operands.top();
            operands.pop();
            double operand1 = operands.top();
            operands.pop();
            operands.push(binaryOperator(operand1, operand2, c));
        }
    }

    if (operands.size() != 1) {
        cerr << "Error: Invalid result expression\n";
        return NAN;
    } else {
        return operands.top();
    }
}

double evaluateInfix(const string& infix) {
    string result = infixToPostfix(infix, 10);
    cout << "result expression: " << result << endl;
    return evaluatePostfix(result);
}

string test1() {
    string input;
    cout << "Enter the infix expression: ";
    getline(cin, input);
    string result = infixToPostfix(input, 999);
    cout << "Result: " << result << endl;

    return result;
}

void test2() {
    double result = evaluateInfix(test1());
    cout << "Result: " << result << endl;
}

int main() {
    test1();
    // test2();
    return 0;
}
