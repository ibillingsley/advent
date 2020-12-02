package main

import (
	"fmt"
	"io/ioutil"
	"regexp"
	"strconv"
	"strings"
)

func validate1(min int, max int, char byte, password string) bool {
	count := 0
	for i := 0; i < len(password); i++ {
		if password[i] == char {
			count++
		}
	}
	return count >= min && count <= max
}

func validate2(x int, y int, char byte, password string) bool {
	return (password[x-1] == char) != (password[y-1] == char)
}

func main() {
	input, err := ioutil.ReadFile("2020/02/input.txt")
	if err != nil {
		panic(err)
	}
	answer1 := 0
	answer2 := 0
	lines := strings.Split(strings.TrimSpace(string(input)), "\n")
	delim := regexp.MustCompile("[- :]+")
	for _, line := range lines {
		values := delim.Split(line, 4)
		x, _ := strconv.Atoi(values[0])
		y, _ := strconv.Atoi(values[1])
		char := values[2][0]
		password := values[3]
		if validate1(x, y, char, password) {
			answer1++
		}
		if validate2(x, y, char, password) {
			answer2++
		}
	}
	fmt.Println("part 1:", answer1)
	fmt.Println("part 2:", answer2)
}
