import { readFileSync } from "fs";

const input = readFileSync("2020/07/input.txt")
	.toString()
	.trim()
	.split("\n")
	.map((line) => line.split(/ bags contain | bags?[,.] ?/).slice(0, -1))
	.reduce((rules, row) => {
		rules[row[0]] = row
			.slice(1)
			.filter((r) => r && r !== "no other")
			.map((r) => [parseInt(r), r.substring(r.indexOf(" ") + 1)]);
		return rules;
	}, {});

function contains(parent, target) {
	for (const [n, child] of input[parent]) {
		if (child === target || contains(child, target)) {
			return true;
		}
	}
	return false;
}

function countChildren(parent) {
	let count = 0;
	for (const [n, child] of input[parent]) {
		count += n * (countChildren(child) + 1);
	}
	return count;
}

function part1() {
	let answer = 0;
	for (const parent of Object.keys(input)) {
		if (contains(parent, "shiny gold")) answer++;
	}
	return answer;
}

function part2() {
	return countChildren("shiny gold");
}

console.log("part 1: " + part1());
console.log("part 2: " + part2());
