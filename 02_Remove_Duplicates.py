n = input()
result = ""
for i in n:
    if i not in result:
        result += i
print(result)