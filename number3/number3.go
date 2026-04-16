package main

import "fmt"

func input(amount *int, numbers *[]int) int {
	isDone := 1
	var n int
	if _, err := fmt.Scan(&n); err == nil && n > -1 {
		*amount = n
		for i := 0; i < n; i++ {
			var x int
			if _, err := fmt.Scan(&x); err == nil && x > 0 {
				*numbers = append(*numbers, x)
			} else {
				isDone = 0
			}
		}
	} else {
		isDone = 0
	}
	if isDone == 0 {
		fmt.Println("Введите коректное количество чисел, числа должны быть положительные")
	}
	return isDone
}

func palindrome(amount int, numbers []int) {
	var number, unit, tens, hung int
	for i := 0; i < amount; i++ {
		if numbers[i] > 99 && numbers[i] < 1000 {
			unit = numbers[i] % 10
			tens = numbers[i]%100 - unit
			hung = numbers[i]%1000 - tens - unit
			number = (unit * 100) + tens + (hung / 100)
			if number == numbers[i] {
				fmt.Print("Yes ")
			} else {
				fmt.Print("No ")
			}
		} else {
			fmt.Print("- ")
		}
	}
	fmt.Println()
}

func main() {
	amount := 0
	numbers := []int{}
	if input(&amount, &numbers) == 1 {
		palindrome(amount, numbers)
	}
}
