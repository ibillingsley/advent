import { readFileSync } from "fs";

const input = readFileSync("2020/06/input.txt")
	.toString()
	.trim()
	.split("\n\n")
	.map((group) => group.split("\n"));

let answer1 = 0;
let answer2 = 0;
const aCharCode = "a".charCodeAt(0);
for (const group of input) {
	const yesCount = Array(26).fill(0);
	for (const person of group) {
		for (const c of person) {
			yesCount[c.charCodeAt(0) - aCharCode] += 1;
		}
	}
	for (const count of yesCount) {
		if (count > 0) answer1++;
		if (count === group.length) answer2++;
	}
}

console.log("part 1: " + answer1);
console.log("part 2: " + answer2);
