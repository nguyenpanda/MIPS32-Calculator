def isOpt(c):
    return c == '+' or c == '-' or c == '*' or c == '/' or c == '^' or c == '!'

def constructTree(postfix):
    stack = []
    for char in postfix:
        t = Node(char)
        if isOpt(char):
            t1 = stack.pop()
            t2 = stack.pop()
            t.right = t1
            t.left = t2
        stack.append(t)
    t = stack.pop()
    return t
            

if __name__ == '__main__':
    pass

