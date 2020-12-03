import { readFileSync } from "fs";

const input = readFileSync("2020/03/input.txt").toString().trim();
const width = input.indexOf("\n");

function countTrees(dx, dy) {
	let count = 0;
	let x = 0;
	let y = 0;
	let i = 0;
	while (i < input.length) {
		if (input[i] === "#") count++;
		x += dx;
		y += dy;
		i = (x % width) + y * (width + 1);
	}
	return count;
}

function part1() {
	return countTrees(3, 1);
}

function part2() {
	const slopes = [
		[1, 1],
		[3, 1],
		[5, 1],
		[7, 1],
		[1, 2],
	];
	let answer = 1;
	for (let [dx, dy] of slopes) {
		answer *= countTrees(dx, dy);
	}
	return answer;
}

console.log("part 1: " + part1());
console.log("part 2: " + part2());
