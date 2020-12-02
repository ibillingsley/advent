package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

const targetSum = 2020

func parseInput() []int {
	input, err := os.Open("2020/01/input.txt")
	if err != nil {
		panic(err)
	}
	result := []int{}
	scanner := bufio.NewScanner(input)
	for scanner.Scan() {
		value, _ := strconv.Atoi(scanner.Text())
		result = append(result, value)
	}
	return result
}

func part1(input []int) int {
	for i := 0; i < len(input); i++ {
		for j := i + 1; j < len(input); j++ {
			if input[i]+input[j] == targetSum {
				return input[i] * input[j]
			}
		}
	}
	return -1
}

func part2(input []int) int {
	for i := 0; i < len(input); i++ {
		for j := i + 1; j < len(input); j++ {
			for k := j + 1; k < len(input); k++ {
				if input[i]+input[j]+input[k] == targetSum {
					return input[i] * input[j] * input[k]
				}
			}
		}
	}
	return -1
}

func main() {
	input := parseInput()
	fmt.Println("part 1:", part1(input))
	fmt.Println("part 2:", part2(input))
}
