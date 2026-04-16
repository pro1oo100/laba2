package main

import "fmt"

func input(distance *[]int, planet *int, fuelTank *int) int {
	isDone := 1
	var p, f int
	n1, _ := fmt.Scan(&p)
	n2, _ := fmt.Scan(&f)
	if n1 == 1 && n2 == 1 && p > 0 && f > 0 {
		*planet = p
		*fuelTank = f
		for i := 0; i < p-1; i++ {
			var item int
			n, _ := fmt.Scan(&item)
			if n == 1 && item > 0 {
				*distance = append(*distance, item)
			} else {
				isDone = 0
			}
		}
	} else {
		isDone = 0
	}
	if isDone == 0 {
		fmt.Println("Введите корректное число планет, объем баков, расстояние между планетами")
	}
	return isDone
}

func resultFly(distance []int, planet int, fuelTank int) int {
	meter := 0
	isDone := 1
	fuel := fuelTank
	isFuel := 1
	for i := 0; i < planet-1 && isFuel == 1; i++ {
		if distance[i] > fuelTank {
			isFuel = 0
		}
		if distance[i] >= fuel {
			isDone = 0
		}
		if distance[i] <= fuel {
			fuel -= distance[i]
		}
		if distance[i] <= fuelTank && isDone == 0 && isFuel == 1 {
			meter++
			fuel += (fuelTank - fuel)
			isDone = 1
			fuel -= distance[i]
		}
	}
	return meter
}

func main() {
	planet := 0
	fuelTank := 0
	distance := []int{}
	if input(&distance, &planet, &fuelTank) == 1 {
		fmt.Println(resultFly(distance, planet, fuelTank))
	}
}
