import kotlin.math.abs

fun main() {
    val input = readlnOrNull()
    val number = input?.toIntOrNull()
    if (number != null && number > 1) {
        if (isSimple(number)) {
            print(0)
        } else {
            print(simpleNumber(number))
        }
    } else {
        print("Введите число ,которое больше 1")
    }
}

fun isSimple(number: Int): Boolean {
    var left = number
    var resultLeft = 0
    while (left > 1 && resultLeft == 0) {
        var isDone = 1
        var i = 2
        while (i * i < left + 1 && isDone == 1) {
            if (left % i == 0) {
                isDone = 0
            }
            i++
        }
        if (isDone == 1) {
            resultLeft = left
        }
        left--
    }
    return resultLeft == number
}

fun simpleNumber(number: Int): Int {
    var left = number
    var right = number
    var resultLeft = 0
    var resultRight = 0

    if (number < 2) {
        resultLeft = abs(2 - number)
    }

    while (left > 1 && resultLeft == 0) {
        var isDone = 1
        var i = 2
        while (i * i < left + 1 && isDone == 1) {
            if (left % i == 0) {
                isDone = 0
            }
            i++
        }
        if (isDone == 1) {
            resultLeft = abs(left - number)
        }
        left--
    }

    while (resultRight == 0) {
        var isDone = 1
        var i = 2
        while (i * i < right + 1 && isDone == 1) {
            if (right % i == 0) {
                isDone = 0
            }
            i++
        }
        if (isDone == 1) {
            resultRight = abs(right - number)
        }
        right++
    }

    return if (resultLeft < resultRight) resultLeft else resultRight
}
