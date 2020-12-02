import { readFileSync } from "fs";

const input = readFileSync("2020/01/input.txt")
	.toString()
	.trim()
	.split("\n")
	.map((line) => parseInt(line));

const targetSum = 2020;

function part1() {
	for (let i = 0; i < input.length; i++) {
		for (let j = i + 1; j < input.length; j++) {
			if (input[i] + input[j] === targetSum) {
				return input[i] * input[j];
			}
		}
	}
}

function part2() {
	for (let i = 0; i < input.length; i++) {
		for (let j = i + 1; j < input.length; j++) {
			for (let k = j + 1; k < input.length; k++) {
				if (input[i] + input[j] + input[k] === targetSum) {
					return input[i] * input[j] * input[k];
				}
			}
		}
	}
}

console.log("part 1: " + part1());
console.log("part 2: " + part2());
