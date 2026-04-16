import Foundation

func isSimple(_ number: Int) -> Bool {
    var left = number
    var resultLeft = 0
    while left > 1 && resultLeft == 0 {
        var isDone = 1
        var i = 2
        while i * i < left + 1 && isDone == 1 {
            if left % i == 0 {
                isDone = 0
            }
            i += 1
        }
        if isDone == 1 {
            resultLeft = left
        }
        left -= 1
    }
    return resultLeft == number
}

func simpleNumber(_ number: Int) -> Int {
    var left = number
    var right = number
    var resultLeft = 0
    var resultRight = 0

    if number < 2 {
        resultLeft = abs(2 - number)
    }

    while left > 1 && resultLeft == 0 {
        var isDone = 1
        var i = 2
        while i * i < left + 1 && isDone == 1 {
            if left % i == 0 {
                isDone = 0
            }
            i += 1
        }
        if isDone == 1 {
            resultLeft = abs(left - number)
        }
        left -= 1
    }

    while resultRight == 0 {
        var isDone = 1
        var i = 2
        while i * i < right + 1 && isDone == 1 {
            if right % i == 0 {
                isDone = 0
            }
            i += 1
        }
        if isDone == 1 {
            resultRight = abs(right - number)
        }
        right += 1
    }

    return resultLeft < resultRight ? resultLeft : resultRight
}

print("Введите число (больше 1): ", terminator: "")
if let input = readLine(), let number = Int(input), number > 1 {
    if isSimple(number) {
        print(0)
    } else {
        print(simpleNumber(number))
    }
} else {
    print("Введите число, которое больше 1")
}
