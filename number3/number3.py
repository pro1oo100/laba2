import sys

def input_data():
    data = sys.stdin.read().split()
    if not data:
        return False, 0, []
    try:
        amount = int(data[0])
    except ValueError:
        return False, 0, []
    if amount < 0:
        return False, 0, []
    numbers = []
    idx = 1
    for _ in range(amount):
        if idx >= len(data):
            return False, 0, []
        try:
            x = int(data[idx])
            idx += 1
        except ValueError:
            return False, 0, []
        if x <= 0:
            return False, 0, []
        numbers.append(x)
    return True, amount, numbers

def palindrome(amount, numbers):
    for i in range(amount):
        if 99 < numbers[i] < 1000:
            unit = numbers[i] % 10
            tens = numbers[i] % 100 - unit
            hung = numbers[i] % 1000 - tens - unit
            rev = (unit * 100) + tens + (hung // 100)
            if rev == numbers[i]:
                sys.stdout.write("Yes ")
            else:
                sys.stdout.write("No ")
        else:
            sys.stdout.write("- ")
    sys.stdout.write("\n")

def main():
    success, amount, numbers = input_data()
    if success:
        palindrome(amount, numbers)
    else:
        print("Введите коректное количество чисел, числа должны быть положительные")

if __name__ == "__main__":
    main()
