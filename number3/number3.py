def main():
    try:
        n = int(input())
    except:
        print("Введите коректное количество чисел, числа должны быть положительные")
        return
    if n < 0:
        print("Введите коректное количество чисел, числа должны быть положительные")
        return
    nums = []
    for _ in range(n):
        try:
            x = int(input())
            if x <= 0:
                raise ValueError
            nums.append(x)
        except:
            print("Введите коректное количество чисел, числа должны быть положительные")
            return
    for x in nums:
        if 99 < x < 1000:
            u = x % 10
            t = x % 100 - u
            h = x % 1000 - t - u
            rev = u * 100 + t + h // 100
            print("Yes " if rev == x else "No ", end="")
        else:
            print("- ", end="")
    print()

if __name__ == "__main__":
    main()
