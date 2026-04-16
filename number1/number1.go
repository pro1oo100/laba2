package main

import (
	"fmt"
	"math"
)


func main() {
	var number int
	_, err := fmt.Scan(&number)
	if err == nil && number > 1 {
		if isSimple(number) {
			fmt.Print(0)
		} else {
			fmt.Print(simpleNumber(number))
		}
	} else {
		fmt.Print("Введите число ,которое больше 1")
	}
}

func isSimple(number int) bool {
	left := number
	resultLeft := 0
	for ; left > 1 && resultLeft == 0; left-- {
		isDone := 1
		for i := 2; i*i < left+1 && isDone == 1; i++ {
			if left%i == 0 {
				isDone = 0
			}
		}
		if isDone == 1 {
			resultLeft = left
		}
	}
	return resultLeft == number
}

func simpleNumber(number int) int {
	left := number
	right := number
	resultLeft := 0
	resultRight := 0

	if number < 2 {
		resultLeft = int(math.Abs(float64(2 - number)))
	}

	for ; left > 1 && resultLeft == 0; left-- {
		isDone := 1
		for i := 2; i*i < left+1 && isDone == 1; i++ {
			if left%i == 0 {
				isDone = 0
			}
		}
		if isDone == 1 {
			resultLeft = int(math.Abs(float64(left - number)))
		}
	}

	for resultRight == 0 {
		isDone := 1
		for i := 2; i*i < right+1 && isDone == 1; i++ {
			if right%i == 0 {
				isDone = 0
			}
		}
		if isDone == 1 {
			resultRight = int(math.Abs(float64(right - number)))
		}
		right++
	}

	if resultLeft < resultRight {
		return resultLeft
	}
	return resultRight
}
