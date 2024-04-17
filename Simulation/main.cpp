#include <iostream>
#include <stack>

using namespace std;

bool isOperator(char c) {
    return (c == '+' || c == '-' || c == '*' || c == '/' || c == '^' || c == '!');
}

bool isLeftAssociative(char op) {
    return (op == '+' || op == '-' || op == '*' || op == '/');
}

int precedence(char op) {
    if (op == '+' || op == '-')
        return 1;
    else if (op == '*' || op == '/')
        return 2;
    else if (op == '^')
        return 3;
    else if (op == '!')
        return 4;
    else
        return -1; // Invalid operator
}

string infixToPostfix(const string& infix) {
    stack<char> operators;
    string postfix;
    
    for (char c : infix) {
        if (isdigit(c) || c == '.') {
            postfix += c;
        } else if (c == '(') {
            operators.push(c);
        } else if (c == ')') {
            while (!operators.empty() && operators.top() != '(') {
                postfix += operators.top();
                operators.pop();
            }
            if (!operators.empty() && operators.top() == '(')
                operators.pop(); // Pop the '('
        } else if (isOperator(c)) {
            while (!operators.empty() && precedence(c) <= precedence(operators.top())
                    && (isLeftAssociative(c) || precedence(c) < precedence(operators.top()))) {
                postfix += operators.top();
                operators.pop();
            }
            operators.push(c);
        }
    }

    while (!operators.empty()) {
        postfix += operators.top();
        operators.pop();
    }
    
    return postfix;
}

int main() {
    string infix;
    cout << "Enter the infix expression: ";
    getline(cin, infix);

    string postfix = infixToPostfix(infix);

    cout << "Postfix expression: " << postfix << endl;

    return 0;
}