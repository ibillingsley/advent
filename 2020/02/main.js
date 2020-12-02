import { readFileSync } from "fs";

const input = readFileSync("2020/02/input.txt")
	.toString()
	.trim()
	.split("\n")
	.map((line) => {
		const values = line.split(/[- :]+/);
		return [parseInt(values[0]), parseInt(values[1]), values[2], values[3]];
	});

function validate1(min, max, char, password) {
	let count = 0;
	for (const c of password) {
		if (c === char) count++;
	}
	return count >= min && count <= max;
}

function validate2(x, y, char, password) {
	return (password[x - 1] === char) !== (password[y - 1] === char);
}

let answer1 = 0;
let answer2 = 0;
for (const row of input) {
	if (validate1(...row)) answer1++;
	if (validate2(...row)) answer2++;
}

console.log("part 1: " + answer1);
console.log("part 2: " + answer2);
